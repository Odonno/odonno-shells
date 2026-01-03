import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root
  color: Theme.backgroundColor
  radius: Theme.radius

  implicitWidth: workspacesRow.implicitWidth
  implicitHeight: workspacesRow.implicitHeight

  readonly property int xMargin: 12

  function readLocalFile(path) {
    const xhr = new XMLHttpRequest()
    xhr.open("GET", "file://" + path, false) 
    xhr.send()

    if (xhr.status === 0 || xhr.status === 200) {
        return xhr.responseText
    } else {
        console.warn("Cannot read file:", path)
        return ""
    }
}

  function extractDesktopFile(appId): string {
    const path = "/usr/share/applications/" + appId + ".desktop"
    return readLocalFile(path)
  }

  function extractIconName(desktopFile): string {
    const lines = desktopFile.split("\n")
    for (const line of lines) {
      if (line.startsWith("Icon=")) {
        return line.split("=")[1].trim()
      }
    }

    return ""
  }

  function getIconName(appId): string {
    if (!appId) {
      return ""
    }

    const desktopFile = extractDesktopFile(appId)
    return extractIconName(desktopFile)
  }

  readonly property list<string> webAppNames: ["Discord", "YouTube", "GitHub"]
  property Rectangle focusedItem: undefined

  RowLayout {
    id: workspacesRow
    anchors.fill: parent
    spacing: 8

    Repeater {
      model: HyprlandState.maxId
      
      Rectangle {
        color: Theme.backgroundColor
        width: 15
        height: 26
        Layout.leftMargin: index === 0 ? xMargin : 0
        Layout.rightMargin: index === (HyprlandState.maxId - 1) ? xMargin : 0

        property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property var topLevel: workspace?.toplevels.values[0]
        property var appTitle: topLevel?.wayland?.title
        property var appId: topLevel?.wayland?.appId
        property var iconName: getIconName(appId)
        property string appIcon: {
          const possibleWebAppName = 
            webAppNames
            .filter(n => appTitle?.includes(n) || appId?.startsWith(`brave-${n.toLowerCase()}.com`))
            [0]

          Quickshell.iconPath(appId, true) 
          || Quickshell.iconPath(iconName, true) 
          || Quickshell.iconPath(appTitle, true) 
          || (possibleWebAppName && Quickshell.iconPath(possibleWebAppName, true)) // custom fix for known web apps
          || ""
        }

        property bool focused: !!workspace?.focused

        onFocusedChanged: {
          if (focused) {
            root.focusedItem = this
          }
        }

        Text {
          visible: !appIcon
          anchors.centerIn: parent
          text: index + 1
          color: focused ? Theme.primaryColor : (workspace ? Theme.textColor : Theme.inactiveColor)
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }

          Behavior on color {
            ColorAnimation {
              duration: 300
              easing.type: Easing.InOutQuad
            }
          }
        }

        Image {
          visible: !!appIcon
          anchors.centerIn: parent
          width: 14
          height: 14

          source: appIcon
          fillMode: Image.PreserveAspectFit
        }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }
  }

  // mimick bottom border
  Rectangle {
    visible: !!root.focusedItem
    height: 2
    color: Theme.primaryColor
    anchors.bottom: parent.bottom

    x: root.focusedItem ? root.focusedItem.x : 0
    width: root.focusedItem ? root.focusedItem.width : 0

    Behavior on x {
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }

    Behavior on width {
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }
  }
}