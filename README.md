# rpa-dispatch

<div align="center">

![GitHub Release](https://img.shields.io/github/v/release/RP-Alpha/rpa-dispatch?style=for-the-badge&logo=github&color=blue)
![GitHub commits](https://img.shields.io/github/commits-since/RP-Alpha/rpa-dispatch/latest?style=for-the-badge&logo=git&color=green)
![License](https://img.shields.io/github/license/RP-Alpha/rpa-dispatch?style=for-the-badge&color=orange)
![Downloads](https://img.shields.io/github/downloads/RP-Alpha/rpa-dispatch/total?style=for-the-badge&logo=github&color=purple)

**Emergency Dispatch System**

</div>

---

## ✨ Features

- 🚨 **Alert System** - Modern NUI overlay for incoming alerts
- 📍 **Blip Management** - Auto-expiring location markers
- 🔗 **Export API** - Easy integration with other resources
- 🎨 **Glassmorphism** - Clean, modern design

---

## � Dependencies

- `rpa-lib` (Required)

---

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-dispatch/releases/latest)
2. Extract to your `resources` folder
3. Add to `server.cfg`:
   ```cfg
   ensure rpa-lib
   ensure rpa-dispatch
   ```

---

## 📚 Exports

### Server Export

```lua
exports['rpa-dispatch']:SendAlert({
    message = "Suspicious Activity",
    code = "10-10",
    coords = vector3(x, y, z),
    type = "police",    -- 'police', 'ems', 'fire'
    blip = {
        sprite = 161,
        color = 1,
        duration = 60000  -- milliseconds
    }
})
```

### Alert Types

| Type | Recipients |
|------|------------|
| `police` | Police job |
| `ems` | Ambulance/EMS job |
| `fire` | Fire department |
| `all` | All emergency services |

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/RP-Alpha">RP-Alpha</a></sub>
</div>
