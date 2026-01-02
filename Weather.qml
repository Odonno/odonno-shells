pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
	id: root

	property int interval: 10 * Time.minute 
	property string textIcon: ""
	property string textValue: ""
	property string textUnit: ""

  Process {
    id: weatherProc
    command: ["curl", "-s", "https://wttr.in/?format=%c+%t"]
    stdout: SplitParser {
			onRead: data => {
				if (!data) {
						return
				}

				var p = data.trim().split(/\s+/)
        textIcon = p[0]
        textValue = p[1].replace("+", "").slice(0, -2)
        textUnit = p[1].slice(-2)
			}
    }
    Component.onCompleted: running = true
	}

  Timer {
    interval: root.interval
    running: true
    repeat: true
    onTriggered: {
			weatherProc.running = true
    }
  }
}