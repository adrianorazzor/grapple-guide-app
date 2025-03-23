# Grapple Guide

A Flutter mobile app designed for Brazilian Jiu Jitsu students to organize and study instructional videos.

## Overview

Grapple Guide allows BJJ practitioners to:

- Organize instructional videos by categories (Guard Passing, Submissions, etc.)
- View detailed information about each video
- Mark favorite videos for quick access
- Add personal notes to videos for enhanced learning
- Interact with a backend API for managing the video library

## Technologies Used

- **Flutter**: UI framework for building cross-platform applications
- **Riverpod**: State management and dependency injection
- **go_router**: Navigation and routing
- **Dio**: HTTP client for API communication
- **Freezed**: Code generation for immutable models

## Architecture

The app follows a feature-based architecture with a clear separation of concerns:

- **Core**: Contains shared code, models, and services
  - **API**: API communication using Dio
  - **Models**: Data models using Freezed
  - **Providers**: Riverpod providers for state management
  - **Router**: Navigation configuration using go_router

- **Features**: Contains feature-specific screens and widgets
  - **Categories**: UI for displaying and managing categories
  - **Videos**: UI for displaying and managing videos

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/grapple-guide.git
   ```

2. Navigate to the project directory
   ```
   cd grapple-guide/app
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Run the app
   ```
   flutter run
   ```

### Build

To build the app for production:

```
flutter build apk  # Android
flutter build ios  # iOS
```

## Future Enhancements

- Video player integration
- User authentication
- Offline support
- Search functionality
- Custom categories
- Progress tracking

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Riverpod](https://riverpod.dev/)
- [go_router](https://pub.dev/packages/go_router)
- [Dio](https://pub.dev/packages/dio)
- [Freezed](https://pub.dev/packages/freezed)
