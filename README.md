# Walletix

A personal finance management and activity planning mobile application built with Flutter.

---

## 📱 About the Project

**Walletix** is designed to give users complete control and understanding of their personal finances. Managing daily expenses, setting monthly budgets, and tracking spending habits can often feel overwhelming. Walletix solves this by providing an offline-first, feature-rich dashboard that tracks every transaction, computes instant monthly summaries, visualizes spending trends, and alerts users about scheduled tasks and financial plans.

### Core Objectives
* **Track Income & Expenses:** Easily record and categorize all daily financial activities.
* **Monitor Budget & Savings:** Track remaining balances against user-defined monthly budgets.
* **Monthly Financial Summaries:** Automatically analyze spending habits, category breakdowns, and top expense drivers.
* **Task & Plan Reminders ("Remember Me"):** Plan daily or monthly activities and receive timed local notifications.

---

## ✨ Features

### 1. 💳 Expense & Income Tracking
* Log individual transactions with detailed amounts, custom notes, dates, and category icons.
* Real-time reactive updates to global transactions state.

### 2. 📊 Monthly Overview & Summaries
* **Current Monthly View:** Track total expenditure against monthly budget limits in real time.
* **Historical Monthly Summaries:** Pure-Dart `SummaryService` automatically computes monthly totals, category percentages, and top expense categories.
* Persisted summaries enable historical comparisons over time.

### 3. 🎯 Financial Planning & Budgeting
* Set and adjust monthly budget targets (`globalBudget`).
* Instant feedback on remaining savings and budget utilization.

### 4. ⏰ "Remember Me" (Activity & Financial Planning)
> **Note:** *Remember Me is NOT a login credential feature.* It is a dedicated task scheduling and reminder system.
* Create daily or monthly activity and financial plans.
* Specify date, exact time, description, priority (Low, Medium, High), and repeat intervals (None, Daily, Weekly).
* Triggers precise local device push notifications (`flutter_local_notifications`) with exact alarms.

### 5. 📈 Interactive Analytics & Charts
* Interactive graphical representations using `fl_chart` (pie/bar views).
* Categorized breakdown of top spending drivers.

### 6. 🌐 Localization & Offline Storage
* Dual-language support (English & Arabic) configured via `flutter_intl`.
* Fast offline data persistence using **Hive** boxes and **SharedPreferences**.

---

## 🧠 How It Works

1. **Onboarding & Initialization:**
   * On first launch, users navigate through the Onboarding flow.
   * `main.dart` initializes essential services (`LocalStorage`, `HiveManager`, `NotificationService`) asynchronously without blocking app startup.
2. **Main Navigation (Root Dashboard):**
   * Accessible via a custom bottom navigation bar (`RootView` with `NavigationCubit`).
   * **Home Tab:** Quick overview of total balance, budget status, and recent transactions.
   * **Category Tab:** Categorized view of transactions.
   * **Report Tab:** Visual charts and monthly summary analytics.
   * **Settings Tab:** App preferences, language options, and budget settings.
3. **Remember Me Scheduler:**
   * Accessible from app views, allowing users to queue tasks with specific alarm times.
   * Notifications trigger even when the app is in the background or closed.

---

## 🏗️ Architecture

Walletix follows a **Feature-First Architecture** combining modular separation with clean code principles:

```text
Presentation Layer (View & Widgets)
          │
     Logic Layer (Cubit & ValueNotifier)
          │
  Domain / Service Layer (SummaryService, NotificationService)
          │
   Data / Storage Layer (HiveManager, LocalStorage)
```

* **State Management:**
  * `flutter_bloc` (Cubit pattern) for screen-level complex states (`RememberMeCubit`, `NavigationCubit`).
  * `ValueNotifier` for lightweight global application singletons (`globalTransactions`, `globalBudget`, `globalLocale`).
* **Service Decoupling:** `SummaryService` is a pure Dart domain class isolated from UI frameworks, enabling fast execution and simplified unit testing.
* **Storage Abstraction:** `HiveManager` manages high-performance local database boxes for transactions and tasks, with legacy migration support from `LocalStorage` (SharedPreferences).

---

## 🛠️ Tech Stack

### Core Framework & UI
* **Flutter SDK:** `^3.11.0`
* **Responsive Layout:** `flutter_screenutil` (`^5.9.3`), `gap` (`^3.0.1`)
* **Typography:** Inter Google Font

### State Management & Logic
* **State Management:** `flutter_bloc` (`^9.1.1`), `ValueNotifier`
* **Localization:** `flutter_intl`, `intl` (`^0.20.2`), `flutter_localizations`

### Data Storage & Infrastructure
* **Local Database:** `hive` (`^2.2.3`), `hive_flutter` (`^1.1.0`)
* **Key-Value Storage:** `shared_preferences` (`^2.5.5`)
* **Firebase (Backend Ready):** `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`

### Notifications & Scheduling
* **Local Notifications:** `flutter_local_notifications` (`^18.0.1`)
* **Timezone Management:** `timezone` (`^0.10.0`), `flutter_timezone` (`^5.0.2`)

### Data Visualization & Utilities
* **Charts:** `fl_chart` (`^0.69.0`)
* **Calendar UI:** `table_calendar` (`^3.1.2`)
* **Identifiers:** `uuid` (`^4.5.1`)
* **Splash & Icons:** `flutter_native_splash`, `flutter_launcher_icons`

---

## 📂 Project Structure

```text
lib/
├── core/
│   ├── i18n/           # Locale management (globalLocale)
│   ├── notifications/  # NotificationService with exact alarm scheduling
│   ├── routing/        # AppRouter, route constants, and navigator keys
│   ├── storage/        # HiveManager & LocalStorage wrappers
│   └── theme/          # App color palette & UI styling
├── feature/
│   ├── category/       # Category management views & widgets
│   ├── expandse/       # Transaction entry & expense forms
│   ├── home/           # Main dashboard & transaction data models
│   ├── monthly_summary/# Monthly summary models, services & detail views
│   ├── onboarding/     # First-time onboarding user flow
│   ├── remember_me/    # Task planning, Cubit, and notification scheduler
│   ├── report/         # Analytics charts & financial breakdown
│   ├── root/           # NavigationCubit & RootView container
│   └── setting/        # Preferences & configuration view
├── generated/          # Auto-generated localization code (flutter_intl)
├── l10n/               # AR/EN localization source files
├── main.dart           # App initialization & service entry point
└── walletix_app.dart   # MaterialApp configuration & ScreenUtil init
```

---

## 🚀 Getting Started

### Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.11.0`)
* Android Studio / VS Code with Flutter extensions
* Connected physical device or emulator

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/ahmedsayed744/wallApp.git
   cd spendwise
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Localization Files (Optional):**
   ```bash
   flutter pub run intl_utils:generate
   ```

4. **Run the Application:**
   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

### Android Configuration
* **Permissions:** Notification scheduling requires `SCHEDULE_EXACT_ALARM` and `POST_NOTIFICATIONS` permissions on Android 12+.
* **Icon Settings:** Configured via `flutter_launcher_icons` using `assets/images/logo/logoapp.png`.

### Storage Setup
* Local data is stored in three main Hive boxes:
  * `settings_box` (App configuration and migration flags)
  * `transactions_box` (Encrypted JSON transaction records)
  * `tasks_box` (Scheduled Remember Me tasks)

---

## 📸 Screenshots

<!--
Add application screenshots here.
| Home Screen | Expense Tracking | Monthly Summary | Remember Me |
|:---:|:---:|:---:|:---:|
| ![Home](assets/screenshots/home.png) | ![Expenses](assets/screenshots/expenses.png) | ![Summary](assets/screenshots/summary.png) | ![Remember Me](assets/screenshots/remember_me.png) |
-->

*Screenshots will be added soon.*

---

## 🔮 Future Improvements

* [ ] Cloud synchronization & backup via Firebase Firestore.
* [ ] CSV and PDF export capabilities for financial statements.
* [ ] Category-specific spending cap alerts and warnings.
* [ ] Enhanced recurring payment options (bi-weekly, yearly).

---

## 👨‍💻 Author

**Ahmed Sayed**
* **GitHub:** [@ahmedsayed744](https://github.com/ahmedsayed744)
* **Phone:** `01151109167`
* **Email:** `ahmed1sayed45@gmail.com`

---

## 📄 License

Currently, no explicit license has been specified for this project.