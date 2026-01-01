import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Item {
  anchors.fill: parent

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

  RowLayout {
    id: workspacesRow
    spacing: 8

    Repeater {
      model: HyprlandState.maxId
      
      Rectangle {
        color: Theme.backgroundColor
        implicitWidth: 15
        implicitHeight: 26
        Layout.leftMargin: index === 0 ? xMargin : 0
        Layout.rightMargin: index === (HyprlandState.maxId - 1) ? xMargin : 0

        property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
        property var topLevel: workspace?.toplevels.values[0]
        property var appTitle: topLevel?.wayland?.title
        property var appId: topLevel?.wayland?.appId
        property var iconName: getIconName(appId)
        property string appIcon: {
          Quickshell.iconPath(appId, true) || 
          Quickshell.iconPath(iconName, true) || 
          Quickshell.iconPath(appTitle, true) || 
          (appTitle?.includes("Discord") && Quickshell.iconPath("Discord", true)) || // custom fix for Discord
          (appTitle?.includes("YouTube") && Quickshell.iconPath("YouTube", true)) || // custom fix for YouTube
          ""
        }

        property bool focused: !!workspace?.focused

        Text {
          visible: !appIcon
          anchors.centerIn: parent
          text: index + 1
          color: focused ? Theme.primaryColor : (workspace ? Theme.textColor : Theme.inactiveColor)
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
        }

        Image {
          visible: !!appIcon
          anchors.centerIn: parent
          width: 14
          height: 14

          source: appIcon
          fillMode: Image.PreserveAspectFit
        }

        // mimick bottom border
        Rectangle {
          visible: focused
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          height: 2
          color: Theme.primaryColor
        }

        MouseArea {
          anchors.fill: parent
          onClicked: Hyprland.dispatch("workspace " + (index + 1))
        }
      }
    }
  }

  Rectangle {
    anchors.fill: workspacesRow
    color: Theme.backgroundColor
    radius: Theme.radius
    z: -1
  }
}