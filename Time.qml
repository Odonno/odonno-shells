pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property int second: 1000
  readonly property int minute: 60 * second
  readonly property int hour: 60 * minute

  readonly property string shortTime: {
    Qt.formatDateTime(clock.date, "hh:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}