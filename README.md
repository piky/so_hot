# SoHot Weather App

SoHot is a minimalist, "glance-and-go" mobile weather application designed to provide immediate access to essential local weather conditions without the clutter of traditional weather apps.

## 🚀 Overview

The app focuses on three core data points: **Location**, **Temperature**, and **"Feels Like"** conditions. It uses high-contrast typography and an ethereal design language to communicate weather status through both data and visual mood.

### Key Features
- **Sub-district Detection:** Automatically identifies your specific local area.
- **Minimalist Dashboard:** Zero secondary navigation; 100% focused UI.
- **Interactive Unit Toggle:** Seamlessly switch between Celsius (°C) and Fahrenheit (°F).
- **Glassmorphic Bento Grid:** Quick access to Wind Speed, Humidity, and Wind Direction.
- **Ethereal Visuals:** Soft gradient backgrounds and atmospheric blurs that reflect current conditions.

## 🛠 Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **Typography:** [Google Fonts](https://pub.dev/packages/google_fonts) (Manrope & Inter)
- **Version Management:** [FVM](https://fvm.app/) (Flutter Version Management)

## 📁 Project Structure

```text
climate/
├── PRD.md            # Product Requirements Document
├── README.md         # Project Overview (You are here)
└── so_hot/           # Core Flutter Application
    ├── lib/
    │   └── main.dart # Entry point & UI Logic
    └── pubspec.yaml  # Dependencies & Config
```

## 🏃 Getting Started

### Prerequisites
- Flutter SDK installed (`^3.10.9`)
- (Optional) [FVM](https://fvm.app/) installed

### Installation & Execution

1. **Navigate to the app directory:**
   ```bash
   cd so_hot
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   # or if using FVM: fvm flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   # or if using FVM: fvm flutter run
   ```

## 📈 Current Status (Phase 1)

The project is currently a high-fidelity **UI Prototype**. 
- [x] Responsive layout & Custom Theme
- [x] Unit conversion logic (Frontend only)
- [x] Glassmorphic UI components
- [ ] Real-time Weather API integration (Planned)
- [ ] Active Geolocation (Planned)

---
*Created by Stitch (Design Partner) & Team.*
