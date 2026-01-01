```sh
cp -r icons ~/.config/quickshell/icons
cp *.qml ~/.config/quickshell/
```

```sh
while inotifywait -e close_write *.qml; do
  cp *.qml ~/.config/quickshell/
done
```

```sh
export QML_XHR_ALLOW_FILE_READ=1
qs
```