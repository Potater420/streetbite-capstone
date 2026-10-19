<p align="center">
  <img src="screenshots/00-banner.png" alt="StreetBite" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
  <img src="https://img.shields.io/badge/State-Bloc%20%2F%20Cubit-00C874?style=for-the-badge" alt="Bloc / Cubit">
  <img src="https://img.shields.io/badge/Architecture-Clean%20%C2%B7%20Feature--first-00C874?style=for-the-badge" alt="Clean architecture, feature-first">
  <img src="https://img.shields.io/badge/Languages-English%20%2F%20Arabic-00C874?style=for-the-badge" alt="English and Arabic">
</p>

<p align="center">
  <a href="#features">Features</a> ·
  <a href="#screenshots">Screenshots</a> ·
  <a href="#architecture">Architecture</a> ·
  <a href="#getting-started">Getting started</a> ·
  <a href="#beta-distribution">Beta build</a> ·
  <a href="https://github.com/Potater420/streetbite-capstone/releases/latest">Download APK</a>
</p>

---

**StreetBite V1.0** is a bilingual (English / Arabic) street-food discovery and ordering app built with **Flutter** and **Firebase**. Browse a live menu, save favourites, order with cash or card, follow your order history, and find nearby vendors on a map, in light or dark mode.

It's the graduation project of the **Sprints Flutter bootcamp**, built phase by phase with one branch and pull request per phase.

## Features

| | |
|---|---|
| **Accounts** | Email and password sign-up and login, persistent session, validated forms, friendly error messages |
| **Live menu** | Meals from TheMealDB with search, category filter, featured banner, hot offers and an offline cache |
| **Meal details** | Full instructions, favourites saved to Firestore, add to cart with live count |
| **Cart and checkout** | Quantity stepper, delivery or pickup, reactive totals, cash or card payment, orders saved to Firestore |
| **Live history** | Orders and favourites update in real time from Firestore |
| **Profile** | Photo from the gallery, device details and a fingerprint lock |
| **Vendor map** | Full-screen Google Map with six vendors and info windows (bonus) |
| **Bilingual and themed** | English and Arabic with RTL, runtime language toggle, light and dark themes |

## Screenshots

<p align="center"><b>Highlights</b></p>

<table>
  <tr>
    <td align="center"><img src="screenshots/04-home-en.png" width="190" alt="Home"><br><sub><b>Home</b></sub></td>
    <td align="center"><img src="screenshots/06-meal-details.png" width="190" alt="Meal details"><br><sub><b>Meal details</b></sub></td>
    <td align="center"><img src="screenshots/07-cart.png" width="190" alt="Cart"><br><sub><b>Cart</b></sub></td>
    <td align="center"><img src="screenshots/08-vendor-map-info-window.png" width="190" alt="Vendor map"><br><sub><b>Nearby vendors</b></sub></td>
  </tr>
</table>

<details open>
<summary><b>Welcome and authentication</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/01-splash.png" width="190" alt="Splash"><br><sub><b>Splash</b></sub></td>
    <td align="center"><img src="screenshots/02-login.png" width="190" alt="Login"><br><sub><b>Login</b></sub></td>
    <td align="center"><img src="screenshots/03-signup.png" width="190" alt="Sign up"><br><sub><b>Sign up</b></sub></td>
    <td align="center"><img src="screenshots/12-signup-validation.png" width="190" alt="Sign-up validation"><br><sub><b>Form validation</b></sub></td>
  </tr>
</table>
</details>

<details open>
<summary><b>Discover</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/04-home-en.png" width="190" alt="Home"><br><sub><b>Home</b></sub></td>
    <td align="center"><img src="screenshots/13-home-category-filter.png" width="190" alt="Category filter"><br><sub><b>Category filter</b></sub></td>
    <td align="center"><img src="screenshots/06-meal-details.png" width="190" alt="Meal details"><br><sub><b>Meal details</b></sub></td>
    <td align="center"><img src="screenshots/14-meal-details-favorited.png" width="190" alt="Favourited meal"><br><sub><b>Favourite and cart</b></sub></td>
  </tr>
</table>
</details>

<details open>
<summary><b>Order</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/07-cart.png" width="190" alt="Cart"><br><sub><b>Cart</b></sub></td>
    <td align="center"><img src="screenshots/15-cart-pickup.png" width="190" alt="Cart with pickup"><br><sub><b>Pickup (no delivery fee)</b></sub></td>
    <td align="center"><img src="screenshots/16-checkout-card.png" width="190" alt="Checkout with card"><br><sub><b>Checkout</b></sub></td>
    <td align="center"><img src="screenshots/17-order-success.png" width="190" alt="Order placed"><br><sub><b>Order placed</b></sub></td>
  </tr>
  <tr>
    <td align="center"><img src="screenshots/18-orders-history.png" width="190" alt="Order history"><br><sub><b>Order history</b></sub></td>
    <td align="center"><img src="screenshots/19-favorites-tab.png" width="190" alt="Favourites"><br><sub><b>Favourites</b></sub></td>
    <td></td>
    <td></td>
  </tr>
</table>
</details>

<details>
<summary><b>Profile and device features</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/10-biometric-prompt.png" width="190" alt="Fingerprint prompt"><br><sub><b>Fingerprint lock</b></sub></td>
    <td align="center"><img src="screenshots/09-profile-device-details.png" width="190" alt="Profile with device details"><br><sub><b>Profile and device details</b></sub></td>
    <td align="center"><img src="screenshots/21-profile-photo-changed.png" width="190" alt="Profile photo"><br><sub><b>Gallery photo</b></sub></td>
    <td align="center"><img src="screenshots/20-logout-dialog.png" width="190" alt="Logout confirmation"><br><sub><b>Logout confirmation</b></sub></td>
  </tr>
</table>
</details>

<details>
<summary><b>Arabic and right-to-left</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/05-home-ar.png" width="190" alt="Home in Arabic"><br><sub><b>Home</b></sub></td>
    <td align="center"><img src="screenshots/22-cart-ar.png" width="190" alt="Cart in Arabic"><br><sub><b>Cart</b></sub></td>
    <td align="center"><img src="screenshots/23-profile-ar.png" width="190" alt="Profile in Arabic"><br><sub><b>Profile</b></sub></td>
  </tr>
</table>
</details>

<details>
<summary><b>Dark mode</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/11-dark-mode-home.png" width="190" alt="Dark home"><br><sub><b>Home</b></sub></td>
    <td align="center"><img src="screenshots/26-dark-mode-details.png" width="190" alt="Dark details"><br><sub><b>Details</b></sub></td>
    <td align="center"><img src="screenshots/27-dark-mode-cart.png" width="190" alt="Dark cart"><br><sub><b>Cart</b></sub></td>
    <td align="center"><img src="screenshots/28-dark-mode-profile.png" width="190" alt="Dark profile"><br><sub><b>Profile</b></sub></td>
  </tr>
</table>
</details>

<details>
<summary><b>Friendly errors and branding</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/24-login-error-snackbar.png" width="190" alt="Login error"><br><sub><b>Friendly login error</b></sub></td>
    <td align="center"><img src="screenshots/25-offline-error-view.png" width="190" alt="Offline error"><br><sub><b>Offline error and retry</b></sub></td>
    <td align="center"><img src="screenshots/29-launcher-icon.png" width="190" alt="Launcher icon"><br><sub><b>Launcher icon</b></sub></td>
  </tr>
</table>
</details>

## Tech stack

| Area | Technology |
|---|---|
| App | Flutter, Dart |
| Auth and data | Firebase Authentication, Cloud Firestore |
| Networking and cache | Dio, shared_preferences |
| State management | flutter_bloc (Bloc and Cubit) |
| Dependency injection | GetIt |
| Maps | google_maps_flutter |
| Device features | image_picker, local_auth, device_info_plus |
| Localization | flutter_localizations, intl (ARB files) |
| Distribution | Firebase App Distribution |
| Version control | Git and GitHub (one branch and PR per phase) |

## Architecture

**Clean Architecture** inside a **feature-first** layout. Each feature has only the layers it needs.

```mermaid
flowchart LR
    P["Presentation<br/>screens · Bloc / Cubit · widgets"] --> D["Domain<br/>entities · use cases · repository interfaces"]
    DA["Data<br/>models · data sources · repository implementations"] --> D
    DA --> X[("Firebase · TheMealDB · device")]
```

```
flutter_app/
├── screenshots/            images used in this README
├── firestore.rules         Firestore security rules
├── pubspec.yaml
├── test/                   unit tests
└── lib/
    ├── main.dart · app.dart · injection.dart
    ├── l10n/               English and Arabic ARB files
    ├── core/               constants, errors, router, theme, utils,
    │                       services (Firestore Singleton), shared widgets
    └── features/
        ├── auth/           login, sign-up, AuthCubit
        ├── splash/
        ├── settings/       ThemeBloc, LocaleCubit
        ├── home/           meals API, cache, MealsCubit
        ├── meal_details/
        ├── favorites/
        ├── cart/           CartBloc, pricing
        ├── orders/         checkout, payments, order history
        ├── profile/        photo, device details, biometrics
        ├── vendors/        map and vendors
        └── main_layout/    tab shell and bottom navigation
```

Presentation depends on domain, and data implements the domain interfaces, so domain code imports no Flutter or Firebase. Two files in `core/` deliberately reference feature code: the router (it has to know every screen) and `HotOfferCard` (shared by Home and Profile).

### Design patterns

| Pattern | Where | Why |
|---|---|---|
| **Builder** | `lib/features/auth/data/models/user_model.dart` (`UserBuilder`) | Builds a `UserModel` step by step and refuses an incomplete user |
| **Factory** | `lib/features/home/data/datasources/meal_data_source_factory.dart` | Chooses the cached or the remote meal source for `MealRepository` |
| **Singleton** | `lib/core/services/firestore_service.dart` | One shared Firestore service, working only with plain maps |
| **SOLID payments** | `lib/features/orders/domain/payments/` | A small `PaymentMethod` interface with separate `CashPayment` and `CardPayment`; `PlaceOrderUseCase` depends only on the abstraction |

### Key decisions

| Topic | Decision |
|---|---|
| Full menu | TheMealDB's empty search returns only 25 meals, so the app requests every first letter in parallel and merges them |
| Offline | Meals are cached for 30 minutes and used as a fallback when the API fails; offline writes time out with a clear message instead of hanging |
| Profile photo | Resized to 512 px and stored as a small base64 string in the user's Firestore document, as the brief asks |
| Errors | Repositories turn every exception into a typed `Failure`, which the UI shows as a localized message; a global handler in `main.dart` is the last safety net |
| Localization | No hard-coded UI text; categories are translated for display; Poppins for Latin text and Cairo for Arabic |

## Getting started

**Requirements:** Flutter stable (Dart 3.13 or newer) and an Android emulator or device.

```bash
git clone https://github.com/Potater420/streetbite-capstone.git
cd streetbite-capstone/flutter_app
flutter pub get
```

**Firebase.** The repo includes the project's `firebase_options.dart`. To use your own project, create a Firebase project, enable **Email/Password** authentication, create a **Cloud Firestore** database, run `flutterfire configure`, and publish `firestore.rules`.

**Google Maps key (optional).** Enable *Maps SDK for Android* in Google Cloud, create a key, and add it to `android/local.properties`, which Git ignores:

```
MAPS_API_KEY=your-key-here
```

Without a key everything works except the map screen.

```bash
flutter run                      # run the app
flutter test                     # unit tests
flutter build apk --release      # release APK
```

## Permissions

| Permission | Why |
|---|---|
| `INTERNET` | Firebase, TheMealDB and Google Maps |
| `USE_BIOMETRIC` | Fingerprint check before the profile opens |

Choosing a profile photo uses the system photo picker and needs no permission.

## Security

- `firestore.rules` lets each signed-in user read and write only their own data; orders can be created but never edited or deleted.
- The Maps key is injected from a git-ignored file and is never committed.
- Card numbers and CVVs are never stored: an order keeps only the payment method and the last four digits.

## Beta distribution

The release APK is built with `flutter build apk --release` and distributed to testers with **Firebase App Distribution**. You can also [download the APK](https://github.com/Potater420/streetbite-capstone/releases/latest).

<table>
  <tr>
    <td align="center"><img src="screenshots/33-app-distribution-releases.png" width="400" alt="App Distribution releases"><br><sub><b>Release in App Distribution</b></sub></td>
    <td align="center"><img src="screenshots/34-app-distribution-testers.png" width="400" alt="App Distribution testers"><br><sub><b>Invited testers</b></sub></td>
  </tr>
</table>

<details>
<summary><b>Backend evidence (Firebase console)</b></summary>

<table>
  <tr>
    <td align="center"><img src="screenshots/30-firebase-auth-users.png" width="260" alt="Firebase Auth users"><br><sub><b>Authentication users</b></sub></td>
    <td align="center"><img src="screenshots/31-firestore-user-document.png" width="260" alt="Firestore user document"><br><sub><b>User document</b></sub></td>
    <td align="center"><img src="screenshots/32-firestore-orders.png" width="260" alt="Firestore orders"><br><sub><b>Saved order</b></sub></td>
  </tr>
</table>
</details>

## Requirements checklist

<details>
<summary><b>Where each requirement of the brief is implemented</b></summary>

Paths are relative to `lib/`.

| Requirement | Where |
|---|---|
| Splash with fade-in animation | `features/splash/presentation/screens/splash_screen.dart` |
| Sign-up validation (capitalized name, email, 6-character password, confirmation) | `core/utils/validators.dart` |
| Firebase auth with persistent session, `AuthCubit` | `features/auth/` |
| `User` model with the Builder pattern | `features/auth/data/models/user_model.dart` |
| Responsive home, `PageView` banner, five Hot Offers, two-column grid | `features/home/presentation/` |
| Dio meals API with loading and error states, `shared_preferences` cache | `features/home/data/` |
| Factory pattern in `MealRepository` | `features/home/data/datasources/meal_data_source_factory.dart` |
| Theme toggle through `ThemeBloc` | `features/settings/presentation/blocs/theme_bloc.dart` |
| Details through navigation arguments, favourites in Firestore, `BlocConsumer` | `features/meal_details/`, `features/favorites/` |
| Cart with `BlocBuilder` and `BlocListener`, orders saved to Firestore | `features/cart/`, `features/orders/` |
| SOLID payment classes (cash and card) | `features/orders/domain/payments/` |
| Vendor map, six vendors with info windows (bonus) | `features/vendors/` |
| Fingerprint before the profile (bonus), photo upload, device details, live favourites and orders | `features/profile/` |
| Firestore service as a Singleton | `core/services/firestore_service.dart` |
| English and Arabic with a runtime toggle, no hard-coded text, unused ARB entries removed | `l10n/` |
| Release APK on Firebase App Distribution with testers | [Beta distribution](#beta-distribution) |
| Manual QA and Appium automation (bonus) | Not included |

</details>

## Known limitations and next steps

- TheMealDB has no prices, so each meal gets a stable demo price derived from its id
- Card payment is simulated (no real gateway); vendors on the map are hardcoded
- Meal names, areas and instructions come from the API in English
- Next: a real payment gateway, live vendor data, order tracking, push notifications and automated UI tests

## Credits

- Design reference: *Food Delivery Mobile App UI Kit* (Figma Community)
- Meals data: [TheMealDB](https://www.themealdb.com/api.php)
- Built as the graduation project of the Sprints Flutter bootcamp

## Developer

**Peter Gamal**, Flutter developer

[GitHub](https://github.com/Potater420) · [LinkedIn](https://www.linkedin.com/in/1peter-gamal) · [Email](mailto:betergamal2019@gmail.com)