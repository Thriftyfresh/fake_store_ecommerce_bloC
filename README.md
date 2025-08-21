# Fake Store - Flutter E-commerce App

## Overview
A beautiful, modern Flutter e-commerce application that integrates with the Fake Store API. Features a clean UI/UX with gradient designs, animations, and comprehensive shopping functionality.

## Features

### Authentication
- Beautiful animated login screen with gradient background
- Secure token-based authentication
- Auto-login with stored credentials
- Logout confirmation dialog

### Product Management
- Product listing with search functionality
- Product details with hero animations
- Category-based filtering
- Real-time search with debouncing

### Shopping Cart
- Add/remove products from cart
- Quantity management (auto-remove when quantity reaches 0)
- Beautiful cart UI with animations
- Total price calculation

### UI/UX Features
- Modern gradient-based design system
- Smooth page transitions and micro-animations
- Hero animations between screens
- Beautiful loading and error states
- Responsive design
- Theme switching (Light/Dark/System)

### Navigation
- App drawer with profile, theme settings, and logout
- Smooth page transitions
- Proper navigation flow

## Architecture

### Clean Architecture Pattern
- **Presentation Layer**: BLoC pattern for state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: API services and repositories

### Key Technologies
- Flutter BLoC for state management
- Dio for HTTP requests
- Provider for theme management
- Cached Network Image for image loading
- Flutter Secure Storage for token storage

## Project Structure
```
lib/
├── core/
│   ├── constants/          # App colors, spacing, themes
│   └── widgets/           # Reusable UI components
├── data/
│   ├── datasources/       # API service
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
└── presentation/
    ├── blocs/            # BLoC state management
    ├── pages/            # App screens
    └── widgets/          # Page-specific widgets
```

## API Integration
- Fake Store API (https://fakestoreapi.com/)
- Products, Cart, Authentication endpoints
- Error handling and loading states

## Demo Credentials
- Username: mor_2314
- Password: 83r5^_

## Dependencies
- flutter_bloc: State management
- dio: HTTP client
- provider: Theme management
- cached_network_image: Image caching
- flutter_secure_storage: Secure storage
- equatable: Value equality

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app
4. Use demo credentials to login

## Features Implemented
✅ Beautiful UI/UX with animations
✅ Product listing and search
✅ Shopping cart functionality
✅ User authentication
✅ Theme switching
✅ Profile page
✅ Logout confirmation
✅ Error handling
✅ Loading states
✅ Responsive design
- Payment integration
- Push notifications
- Offline support
