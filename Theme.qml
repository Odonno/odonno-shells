pragma Singleton

import Quickshell

// TODO : bind theme from hyperland

Singleton {
  id: root

  readonly property string fontFamily: "JetBrainsMono Nerd Font"
  readonly property int fontSize: 13
  readonly property string backgroundColor: "black"
  readonly property string textColor: "white"
}