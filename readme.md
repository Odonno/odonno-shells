# My Linux shells

<div align="center">

A custom module for Hyprland using Quickshell.

![Quickshell](https://img.shields.io/badge/Quickshell-0.2.1-blue?style=flat-square)
![Hyprland](https://img.shields.io/badge/Hyprland-Compatible-purple?style=flat-square)
![Qt6](https://img.shields.io/badge/Qt-6-green?style=flat-square)

</div>

## Components & Widgets

Here is the list of components & widgets in this project.

### Top bar

A minimalistic top bar with the following features:

* a home menu button (open menu widget)
* an Hyprland workspace view (with icon for each workspace when possible)
* utility links (bluetooth, network, volume)
* system metrics (CPU, RAM)
* current weather
* current time
* a button displayed when system updates are available

![Top bar image](images/topbar.png)

## Get started

First, let's start by copying the project file in the quickshell configuration folder:

```sh
cp -r icons ~/.config/quickshell/icons
cp *.qml ~/.config/quickshell/
```

If you want to make some changes, start this task to ensure the changes are synced:

```sh
while inotifywait -e close_write *.qml; do
  cp *.qml ~/.config/quickshell/
done
```

Finally, run the quickshell project:

```sh
export QML_XHR_ALLOW_FILE_READ=1
qs
```