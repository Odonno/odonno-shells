pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    readonly property int length: Hyprland.workspaces.values.length
    readonly property var lastWorkspace: Hyprland.workspaces.values[length - 1]

    readonly property int maxId: lastWorkspace?.id ?? 1
}