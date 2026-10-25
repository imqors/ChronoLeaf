# ChronoLeaf 2.2.1

<p align="center">
  <img src="https://github.imqors.com/chronoleaf/8Z4yK.png" height="320">
  <img src="https://github.imqors.com/chronoleaf/xD67C.png" height="320">
</p>

<p align="center">
  <strong>A modern countdown and event tracking app for Windows.</strong>
</p>

<p align="center">
  Track important dates, deadlines and events with a clean and modern interface.
</p>

<p align="center">
  <a href="README.ru.md">🇷🇺 Русский</a> ·
  <a href="README.zh-CN.md">🇨🇳 中文</a>
</p>

---

## ✨ Features

### ⏳ Countdown

Create events with a specific date and time and see the remaining:

* Days
* Hours
* Minutes
* Seconds

ChronoLeaf continuously updates each countdown using your computer's local system time.

### 📅 Multiple Events

Create and manage multiple countdowns at the same time.

Each event has its own:

* Name
* Date
* Time
* Countdown
* Status

Events can also be reordered directly from the event card using the **Move Up** and **Move Down** controls.

### 🗑️ Event Management

Manage individual events directly from their cards.

Available actions include:

* ✏️ Edit an event
* 🗑️ Delete a specific event
* ⬆️ Move an event up
* ⬇️ Move an event down

The available move buttons automatically depend on the event's position in the list.

### 🌐 Three Languages

ChronoLeaf currently supports three languages:

* 🇷🇺 Russian
* 🇬🇧 English
* 🇨🇳 Chinese

You can change the application language in the settings.

### 🎨 Modern Interface

ChronoLeaf features a dark, minimal interface designed for readability and everyday use.

Visual indicators help you quickly understand the urgency of upcoming events.

### 🟢 Event Status

Events display different statuses depending on the time remaining:

* 🟢 **Normal** — plenty of time remains
* 🟡 **Attention** — the event is approaching
* 🔴 **Critical** — very little time remains or the event has passed

### 🪟 Window Customization

Customize how ChronoLeaf behaves as a desktop window.

Available options include:

* **Window transparency** — adjust the window opacity
* **Always on top** — keep ChronoLeaf above other windows
* **Timers Only** — hide unnecessary interface elements and focus on the countdowns

The **Settings** button remains available in Timers Only mode, so the interface can always be restored.

### 💾 Local Storage

Your events and settings are stored locally on your computer.

No account is required to use ChronoLeaf.

### ⚙️ Customizable Settings

ChronoLeaf provides settings for customizing the application according to your preferences.

Settings include:

* Application language
* Yellow status threshold
* Red status threshold
* Window transparency
* Always on top
* Timers Only mode

---

## 🆕 What's New in 2.2.1

Version 2.2.1 focuses on refining the existing application and improving the build process rather than introducing major new features.

* **Improved Builder** — the installation and build process has been made more carefully structured.
* **Application Refinements** — the existing interface and application behavior have received additional attention.
* **Same Core Experience** — ChronoLeaf retains its familiar functionality, settings, and event management workflow.

The goal is to make building and using ChronoLeaf more straightforward without unnecessarily changing what already works.

---

## 🖥️ Installation

The easiest way to install ChronoLeaf is using the included builder/installer.

### Automatic installation

1. Download `install.bat`.
2. Run the file.
3. Wait for the build and installation process to finish.
4. ChronoLeaf will be created on your Desktop.

The builder downloads the required application files and prepares ChronoLeaf for use.

> **Note:** An internet connection is required during installation and building.

---

## 📋 Requirements

* Windows 10 or Windows 11
* Internet connection for installation and building
* Python installed and available to the builder

### Recommended Python version

**Python 3.11 is still the recommended version** for the most predictable build experience.

However, the builder has been refined in version 2.2.1, so you can first try building ChronoLeaf with your currently installed Python version instead of immediately installing a different one.

Compatibility may depend on the Python version and the availability of compatible dependencies. If the build fails, try Python 3.11.

During Python installation, make sure to enable **“Add Python.exe to PATH”** (or **“Add Python to PATH”**).

> **Important:** The builder requires Python to build the application. If the resulting executable bundles its required runtime and dependencies, end users generally do not need to install Python separately.

### Windows compatibility

ChronoLeaf is designed for **Windows 10 and Windows 11**, with these versions as its primary target platforms.

Countdowns follow your computer's local system time, so events are calculated according to the current date and time configured in Windows.

---

## 📁 Project Structure

```text
ChronoLeaf/
├── README.md
├── README.ru.md
├── README.zh-CN.md
└── install.bat
```

---

<p align="center">
  <strong>Created by IMQORS · Approved by So</strong><br>
  <a href="https://imqors.com/">imqors.com</a>
</p>
