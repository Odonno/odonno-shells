import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
  id: root
  
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30

  Text {
    anchors.centerIn: parent
    text: Time.shortTime
  }
}