# 🌟 Daily Mood

[![Flutter](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter)](https://flutter.dev/)  
[![State Management](https://img.shields.io/badge/State%20Management-flutter_bloc-blueviolet)](https://pub.dev/packages/flutter_bloc)  
[![Routing](https://img.shields.io/badge/Routing-go_router-lightgreen)](https://pub.dev/packages/go_router)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **Track your mood, understand yourself better, and see your emotional journey over time.**

---

## ✨ Features

- 📅 **Mood Entry** — Quickly log your mood with simple inputs.
- 📜 **Mood History** — View a complete, organized timeline of your past moods.
- 📊 **Mood Statistics** — Analyze your emotional trends with intuitive stats and visual insights.

---

## 🛠️ Built With

- **Flutter** — Beautiful, natively compiled applications for mobile.
- **flutter_bloc** — Structured, scalable state management.
- **go_router** — Simple and declarative navigation for Flutter.

---

## 🧩 Architecture Overview

The app is built following a **clean architecture** model for easy scalability and maintenance:

```
lib/
├── features/
│   ├── mood_entry/
│   ├── carousel_bloc/
│   ├── navigation_bloc/
│   └── settings_bloc/
├── routes/
│   └── app_router.dart
├── screens/
│   ├── mood_entry/
│   ├── mood_history/
│   ├── mood_settings/
│   ├── mood_stats/
│   ├── utils/
│   └── main_screen.dart
├── shared/
│   ├── theme/
│   └── widgets.dart
└── main.dart
```

- **Presentation Layer** — UI components and page layouts.
- **Business Logic Layer** — `Bloc` and `Cubit` implementations for feature control.
- **Data Layer** — Handles storage/retrieval of mood data.
- **Routing Layer** — `go_router` used for efficient navigation between screens.

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/mood_tracker_app.git
```

### 2. Navigate into the project directory
```bash
cd mood_tracker_app
```

### 3. Install the dependencies
```bash
flutter pub get
```

### 4. Run the app
```bash
flutter run
```

---

## 📈 Mood Flow Example

| Mood Entry | Mood History | Mood Stats |
|:----------:|:------------:|:----------:|
| 📝 Record your current mood | 📚 Browse your emotional history | 📊 Analyze patterns and trends |

---

> Made with ❤️ using Flutter, Bloc, and GoRouter.
