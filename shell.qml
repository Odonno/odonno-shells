import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

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

  Rectangle {
    color: Theme.backgroundColor
    implicitWidth: 50
    implicitHeight: 30
    radius: 8

    Text {
      anchors.centerIn: parent
      color: Theme.textColor
      font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
      text: Time.shortTime
    }
  }
}