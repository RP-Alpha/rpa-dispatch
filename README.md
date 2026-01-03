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

## 📥 Installation

1. Download the [latest release](https://github.com/RP-Alpha/rpa-dispatch/releases/latest)
2. Extract to your `resources` folder
3. Add to `server.cfg`:
   ```cfg
   ensure rpa-dispatch
   ```

---

## 📚 Exports

```lua
exports['rpa-dispatch']:SendAlert({
    message = "Suspicious Activity",
    code = "10-10",
    coords = vector3(x, y, z),
    type = "police"
})
```

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/RP-Alpha">RP-Alpha</a></sub>
</div>
