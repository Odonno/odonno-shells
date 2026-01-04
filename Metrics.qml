pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property int interval: 2 * Time.second 

	// CPU data
  property int cpuUsage: 0
  property var lastCpuTotal: 0
  property var lastCpuIdle: 0

	// GPU data
  property int gpuUsage: 0

	// Memory data
  property string remainingMemory: "N/A"
  property string memoryUnit: ""

  Process {
    id: cpuProc
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
			onRead: data => {
				if (!data) {
					return
				}

				var p = data.trim().split(/\s+/)
				var idle = parseInt(p[4]) + parseInt(p[5])
				var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
				if (lastCpuTotal > 0) {
					cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
				}

				lastCpuTotal = total
				lastCpuIdle = idle
			}
    }
    Component.onCompleted: running = true
	}
	
  Process {
		id: gpuProc
		command: ["nvidia-smi", "--query-gpu=utilization.gpu", "--format=csv,noheader,nounits"] // TODO : handle different GPU types
		stdout: SplitParser {
			onRead: data => {
				if (data === undefined) {
					return
				}
				gpuUsage = parseInt(data)
			}
		}
		Component.onCompleted: running = true
  }

	function formatMemory(bytes): var {
		if (bytes === undefined || bytes === null || bytes < 0) {
			return "N/A"
		}

		var units = ["KB", "MB", "GB"]
		var unitIndex = 0
		var value = bytes

		while (value >= 1024 && unitIndex < units.length - 1) {
			value /= 1024
			unitIndex++
		}

		var formatted = unitIndex < 2
			? Math.round(value)
			: value.toFixed(1)

		return [formatted, units[unitIndex]]
	}

  Process {
		id: memProc
		command: ["sh", "-c", "free | grep Mem"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) {
					return
				}
				var parts = data.trim().split(/\s+/)
				var total = parseInt(parts[1]) || 1
				var used = parseInt(parts[2]) || 0
				
				var tuple = formatMemory(total - used)
				remainingMemory = tuple[0]
				memoryUnit = tuple[1]
			}
		}
		Component.onCompleted: running = true
  }

  Timer {
		interval: root.interval
		running: true
		repeat: true
		onTriggered: {
			cpuProc.running = true
			gpuProc.running = true
			memProc.running = true
		}
  }
}