```sh
cp *.qml ~/.config/quickshell/
```

```sh
while inotifywait -e close_write *.qml; do
  cp *.qml ~/.config/quickshell/
done
```