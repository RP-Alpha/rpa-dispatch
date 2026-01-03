# rpa-dispatch

A modern, NUI-based dispatch and alert system.

## Features
- **Modern Overlay**: Clean, glassmorphism-style alert lists.
- **Blip Management**: Auto-expiring blips for alerts.
- **Exports**: Simple export to trigger alerts from other resources.

## Installation
1. Ensure `rpa-lib` is started.
2. Add `ensure rpa-dispatch` to your `server.cfg`.

## Usage
```lua
exports['rpa-dispatch']:SendAlert({
    message = "Suspicious Activity",
    code = "10-10",
    coords = vector3(x, y, z),
    type = "police"
})
```

## Credits
- RP-Alpha Development Team

## License
MIT
