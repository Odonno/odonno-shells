pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  readonly property string fontFamily: "JetBrainsMono Nerd Font"
  readonly property int fontSize: 13
  readonly property int radius: 8
  readonly property string backgroundColor: "black"
  readonly property string textColor: "white"
  property string primaryColor: "cyan"
  readonly property string inactiveColor: "#444b6a"

  Process {
    id: syncPrimaryColorProc
    running: true
    command: ["hyprctl", "getoption", "general:col.active_border"]
    stdout: StdioCollector {
      onStreamFinished: {
        primaryColor = "#" + this.text.replace("custom type:", "").trim().split(/\s+/)[0]
      }
    }
    Component.onCompleted: running = true
  }

  function syncHyprland() {
    syncPrimaryColorProc.running = true
  }
}