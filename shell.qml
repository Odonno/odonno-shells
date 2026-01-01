import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: root
  color: "transparent"
  HyprlandWindow.opacity: 0.6
  
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 35

  MarginWrapperManager { 
    topMargin: 8
    leftMargin: 10
    rightMargin: 10
    bottomMargin: 0
  }

  RowLayout {
    Rectangle {
      id: menu
      color: Theme.backgroundColor
      width: 32
      height: 26
      radius: Theme.radius

      Image {
        id: icon
        anchors.centerIn: parent
        width: 18
        height: 18

        source: "icons/arch-linux.svg"
        fillMode: Image.PreserveAspectFit
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
          Quickshell.execDetached(["omarchy-menu"])
        }

        onPressed: icon.opacity = 0.6
        onReleased: icon.opacity = 1.0
        onExited: icon.opacity = 1.0
      }
    }

    Item {
        height: 26

        Workspaces {}
    }

    Item { Layout.fillWidth: true }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 80
      implicitHeight: 26
      radius: Theme.radius

      Text {
        anchors.centerIn: parent
        text: "CPU: " + Metrics.cpuUsage + "%"
        color: Theme.textColor
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
      }
    }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 100
      implicitHeight: 26
      radius: Theme.radius

      Text {
        anchors.centerIn: parent
        text: "RAM: " + Metrics.remainingMemory
        color: Theme.textColor
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
      }
    }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 60
      implicitHeight: 26
      radius: Theme.radius

      Text {
        anchors.centerIn: parent
        color: Theme.textColor
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
        text: Time.shortTime
      }
    }
  }
}