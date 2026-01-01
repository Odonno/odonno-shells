import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

// TODO : bind theme from hyperland

PanelWindow {
  id: root
  color: "transparent"
  HyprlandWindow.opacity: 0.6

  // Theme
  readonly property string fontFamily: "JetBrainsMono Nerd Font"
  readonly property int fontSize: 13
  
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
    color: "black"
    implicitWidth: 50
    implicitHeight: 30
    radius: 8

    Text {
      anchors.centerIn: parent
      color: "white"
      font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
      text: Time.shortTime
    }
  }
}