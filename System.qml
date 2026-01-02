pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int interval: Time.hour 
  property bool updatesAvailable: false

  Process {
		id: updatesProc
		command: ["omarchy-update-available"]
		onExited: function (exitCode) {
			updatesAvailable = exitCode === 0
		}
		Component.onCompleted: running = true
  }

  Timer {
    interval: root.interval
    running: true
    repeat: true
    onTriggered: {
			updatesProc.running = true
    }
  }
}