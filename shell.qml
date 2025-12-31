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

  property string time

  Text {
    id: clock
    anchors.centerIn: parent
    text: root.time
  }

  Process {
    id: dateProc
    command: ["date"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }

  Timer {
    interval: 1000 // 1000 milliseconds is 1 second
    running: true
    repeat: true

    onTriggered: dateProc.running = true
  }
}