import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Item {
  anchors.fill: parent

  readonly property int xMargin: 12

  RowLayout {
    id: workspacesRow
    spacing: 8

    Repeater {
      model: HyprlandState.maxId
      
      Rectangle {
        color: Theme.backgroundColor
        radius: Theme.radius
        implicitWidth: 15
        implicitHeight: 26
        Layout.leftMargin: index === 0 ? xMargin : 0
        Layout.rightMargin: index === (HyprlandState.maxId - 1) ? xMargin : 0

        Text {
          property var workspace: Hyprland.workspaces.values.find(w => w.id === index + 1)
          property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

          anchors.centerIn: parent
          text: index + 1
          color: isActive ? Theme.primaryColor : (workspace ? Theme.textColor : Theme.inactiveColor)
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }

          MouseArea {
            anchors.fill: parent
            onClicked: Hyprland.dispatch("workspace " + (index + 1))
          }
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