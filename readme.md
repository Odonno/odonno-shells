```sh
cp shell.qml ~/.config/quickshell
```

```sh
while inotifywait -e close_write shell.qml; do
  cp shell.qml ~/.config/quickshell
done
```