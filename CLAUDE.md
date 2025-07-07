# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Flutter mobile application project called "foot_step_meter", which is a pedometer app.
The project follows the standard Flutter project structure and includes platform-specific code for both iOS and Android.

## Development Commands

### Code Generation
- `dart run build_runner build` - Generate code for Freezed models, Riverpod providers, and JSON serialization
- `dart run build_runner build --delete-conflicting-outputs` - Force regenerate all generated files
- `dart run build_runner watch` - Watch for changes and auto-generate code

### Analysis and Testing
- `flutter analyze` - Run static analysis with linting
- `flutter test` - Run unit and widget tests
- `flutter test test/widget_test.dart` - Run specific test file
- `flutter doctor` - Check if Flutter is available

### Build and Run
- `flutter run` - Run app in debug mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app

## Architecture Overview
This Flutter app follows Clean Architecture with feature-based organization:

### Feature Structure (`lib/features/qiita_items/`)
- **Data Layer**:
    - `datasource/` - API clients or DB clients
    - `model/` - Data models with Freezed/JSON serialization 
    - `repository/` - Repository implementations
- **Domain Layer**:
    - `entity/` - Business entities
    - `repository/` - Repository interfaces
    - `usecase/` - Business logic
- **Presentation Layer**:
    - `provider/` - Riverpod state management providers
    - `view/` - UI pages and widgets

### Key Patterns
- **State Management**: Riverpod with code generation (`@riverpod` annotations)
- **Data Models**: Freezed for immutable classes with JSON serialization
- **Dependency Injection**: Riverpod providers for dependency graph
- **Environment Variables**: flutter_dotenv for configuration (requires `.env` file)

### Generated Files
The project uses code generation extensively:
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Freezed immutable classes
- Provider files use `part` declarations for generated code

## Test Overview
In this project, we will follow TDD (Test-Driven Development) as advocated by t-wada.
The types of tests to be implemented are unit tests and widget tests.
Our goal is to achieve 100% code coverage as much as possible.
For widget tests, please focus on testing layout structure rather than fine details such as styles or font sizes.

## Environment Setup
- Create `.env` file in root
- Run code generation after model/provider changes
- Use `flutter pub get` after dependency changes

## Dependencies
- `flutter` - Core Flutter SDK
- `cupertino_icons` - iOS-style icons
- `flutter_riverpod` - State management library for Flutter apps
- `riverpod_annotation` - Annotations for code generation with Riverpod
- `freezed_annotation` - Annotations for generating immutable classes using Freezed
- `json_annotation` - Annotations for generating JSON serialization code
- `dio` – Powerful HTTP client for Dart, used for API requests
- `realm` – Local database for Flutter with object-oriented data storage and real-time sync support
- `flutter_dotenv` – Loads environment variables from a .env file
- `flutter_test` - Testing framework (dev dependency)
- `flutter_lints` - Linting rules (dev dependency)
- `json_serializable` - Generates JSON serialization logic from annotated classes (dev dependency)
- `freezed` - Code generator for immutable data classes and unions (dev dependency)
- `riverpod_lint` - Linter rules specific to Riverpod best practices (dev dependency)
- `custom_lint` - Framework for defining and running custom lint rules (dev dependency)
- `build_runner` - Tool for running code generators like Freezed and JSON serializable (dev dependency)
- `riverpod_generator` - Generates Riverpod-related code based on annotations (dev dependency)
- `mockito` - Mocking framework for writing unit tests (dev dependency)

## Development Notes
- Cupertino Design as the primary UI framework
- Follows standard Flutter/Dart naming conventions
- Lint rules are configured via `package:flutter_lints/flutter.yaml`