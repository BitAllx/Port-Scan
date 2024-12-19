# 🔍 Port Scanner Bash Script

A lightweight and efficient **port scanner** written in Bash, designed to identify open ports on a specified target IP address within a given port range. This script is simple to use, provides real-time progress updates, and automatically copies the results to your clipboard.

## ✨ Features

- 🛠 **Customizable Target**: Scan any target IP address with a specific range of ports.
- 🚀 **Progress Display**: Real-time percentage progress during the scan.
- 📋 **Clipboard Integration**: Automatically copies open ports to your clipboard.
- ✅ **Input Validation**: Ensures the correctness of IP addresses and port ranges.
- 🔔 **Graceful Exit**: Safely handle interruptions with `Ctrl + C`.

---

## 📜 Usage

### Syntax
```bash
./port-scanner.sh <IP> <port-range>
```

### Example
```bash
./port-scanner.sh 192.168.1.1 1-10000
```

### Help Panel
For usage details:
```bash
./port-scanner.sh -h
```

---

## 🚦 Prerequisites

Make sure you have the following installed on your system:

- **Bash**
- **xclip** (for clipboard functionality)

Install xclip on Debian/Ubuntu:
```bash
sudo apt install xclip
```

---

## 🖥 Output Example

```plaintext
[+] Target IP: 192.168.1.1
[+] Open ports: 22,80,443
[+] Ports copied to clipboard
```

---

## 🛑 Error Handling

- **Invalid Syntax**:
  ```plaintext
  [!] La sintaxis de la IP o el rango de puertos es incorrecta
  ```
- **Too Many Parameters**:
  ```plaintext
  [!] Esta herramienta acepta como máximo dos parámetros
  ```

---

## 👤 Author

**Jorge Arana Fedriani**  
📧 Contact: [YourEmail@example.com](mailto:YourEmail@example.com)

---

### 🛠 Contribution

Contributions, issues, and feature requests are welcome! Feel free to fork this repository and submit a pull request. 😊

