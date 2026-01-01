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
        width: 15
        height: 15

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

      RowLayout {
        anchors.centerIn: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Rectangle {
          color: "transparent"
          implicitWidth: 16
          implicitHeight: 26
          
          Text {
            anchors.centerIn: parent
            id: bluetoothText
            text: ""
            color: Theme.textColor
            font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              Quickshell.execDetached(["omarchy-launch-bluetooth"])
            }

            onPressed: bluetoothText.opacity = 0.6
            onReleased: bluetoothText.opacity = 1.0
            onExited: bluetoothText.opacity = 1.0
          }
        }

        Rectangle {
          color: "transparent"
          implicitWidth: 16
          implicitHeight: 26
          
          Text {
            anchors.centerIn: parent
            id: networkText
            text: "\uf1eb"
            color: Theme.textColor
            font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              Quickshell.execDetached(["omarchy-launch-wifi"])
            }

            onPressed: networkText.opacity = 0.6
            onReleased: networkText.opacity = 1.0
            onExited: networkText.opacity = 1.0
          }
        }

        Rectangle {
          color: "transparent"
          implicitWidth: 20
          implicitHeight: 26
          
          Text {
            anchors.centerIn: parent
            id: volumeText
            text: "\uf028"
            color: Theme.textColor
            font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
              Quickshell.execDetached(["omarchy-launch-or-focus-tui", "wiremix"])
            }

            onPressed: volumeText.opacity = 0.6
            onReleased: volumeText.opacity = 1.0
            onExited: volumeText.opacity = 1.0
          }
        }
      }
    }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 80
      implicitHeight: 26
      radius: Theme.radius

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Text {
          text: "CPU:"
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          opacity: 0.6
        }
        Item {
          Layout.fillWidth: true
        }
        Text {
          id: cpuText
          text: Metrics.cpuUsage
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
        }
        Text {
          text: "%"
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          opacity: 0.6
        }
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
          Quickshell.execDetached(["omarchy-launch-or-focus-tui", "btop"])
        }

        onPressed: cpuText.opacity = 0.6
        onReleased: cpuText.opacity = 1.0
        onExited: cpuText.opacity = 1.0
      }
    }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 110
      implicitHeight: 26
      radius: Theme.radius

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Text {
          text: "RAM:"
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          opacity: 0.6
        }
        Item {
          Layout.fillWidth: true
        }
        Text {
          id: memoryText
          text: Metrics.remainingMemory
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
        }
        Text {
          text: Metrics.memoryUnit
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          opacity: 0.6
        }
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
          Quickshell.execDetached(["omarchy-launch-or-focus-tui", "btop"])
        }

        onPressed: memoryText.opacity = 0.6
        onReleased: memoryText.opacity = 1.0
        onExited: memoryText.opacity = 1.0
      }
    }

    Rectangle {
      color: Theme.backgroundColor
      implicitWidth: 70
      implicitHeight: 26
      radius: Theme.radius
      visible: Weather.textValue

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Text {
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          text: Weather.textIcon
        }
        Item {
          Layout.fillWidth: true
        }
        Text {
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          text: Weather.textValue
        }
        Text {
          color: Theme.textColor
          font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
          text: Weather.textUnit
          opacity: 0.6
        }
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

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton

        onClicked: {
          Quickshell.execDetached(["omarchy-launch-floating-terminal-with-presentation", "omarchy-tz-select"])
        }
      }
    }
  }

  Component.onCompleted: {
    Hyprland.rawEvent.connect(function(event) {
      if (event.name === "configreloaded") {
        Theme.syncHyprland()
      }
    })
  }
}