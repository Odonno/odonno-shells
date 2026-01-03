//@ pragma Env QML_XHR_ALLOW_FILE_READ=1

import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
  TopBar {}

  Component.onCompleted: {
    Hyprland.rawEvent.connect(function(event) {
      if (event.name === "configreloaded") {
        Theme.syncHyprland()
      }
    })
  }
}