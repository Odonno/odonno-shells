pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int interval: 60 * 60 * 1000 
  property bool updatesAvailable: false

  Process {
		id: updatesProc
		command: ["omarchy-update-available"]
		onExited: function (exitCode) {
			updatesAvailable = exitCode === 0
		}
  }

  Timer {
    interval: interval
    running: true
    repeat: true
    onTriggered: {
			updatesProc.running = true
    }
  }
}