## Setup Rodecol layout on linux

1. Add the layout to the layout collection

```
sudo ln -s $(pwd)/rodecol /usr/share/X11/xkb/symbols/rd
```

2. Index it

```
sudo nvim /usr/share/X11/xkb/rules/evdev.xml
```

and add the following

```
  <layoutList>
   . . .
    <layout>
      <configItem>
        <name>rd</name>
        <shortDescription>rd</shortDescription>
        <description>Rodecol RO DE FR ES</description>
        <languageList>
          <iso639Id>eng</iso639Id>
        </languageList>
      </configItem>
    </layout>
```

3. Set it in sway

```
input * {
  xkb_layout "rd"
  xkb_options "grp:alt_shift_toggle"
}
```


