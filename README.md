# SwiftUI Clean Architecture Showcase

![Platform](https://img.shields.io/badge/platform-iOS%2026.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)
![Xcode](https://img.shields.io/badge/Xcode-26.2-blue.svg)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture%20%2B%20MVVM-success.svg)
![Tests](https://img.shields.io/badge/tests-passing-brightgreen.svg)
![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)

A iOS movie search app built with SwiftUI, MVVM, Clean Architecture, REST API integration, async/await, dependency injection, and unit tests.

This showcase is designed as a compact reference project: the UI stays simple, the architecture is explicit, and the domain layer remains independent from networking details.


<img width="250"  alt="Movie search screen" src="https://github.com/user-attachments/assets/4ded531c-ef48-4de6-82ea-e37b5f8fab05" />


<img width="250"  alt="Movie details screen" src="https://github.com/user-attachments/assets/7e51f9d6-5924-44cb-b4ac-13f7157b5cb3" />

---

## Table of Contents

- [Requirements](#requirements)
- [Features](#features)
- [Architecture](#architecture)
- [Technical Decisions](#technical-decisions)
- [Setup](#setup)
- [Configuration](#configuration)
- [Tests](#tests)
- [Screenshots](#screenshots)
- [License](#license)

## Requirements

- **iOS 26.0+**
- **Swift 6.2+**
- **Xcode 26.2+**

## Features

### Movie Search

- Search movies by title
- Display a list of movie results
- Open a movie detail screen
- Show loading, empty, and error states
- Retry a failed search

### Architecture and Testing

- Clean Architecture boundaries between `Presentation`, `Domain`, and `Data`
- MVVM with SwiftUI and `@Observable`
- Async/await based API calls
- Dependency injection through `AppContainer`
- Unit tests for use cases and view models
- Fake repository for deterministic tests

## Architecture

```text
SwiftUICleanArchitectureShowcase
├── App
│   └── AppContainer
├── Presentation
│   ├── Views
│   ├── ViewModels
│   └── UIState
├── Domain
│   ├── Entities
│   ├── UseCases
│   ├── Repositories
│   └── Errors
└── Data
    ├── DTOs
    ├── API
    ├── Repositories
    └── Mappers
```

### Main Flow

```text
Home
-> Movie search
-> Movie list
-> Movie details
```

## Technical Decisions

- `Domain` defines entities, use cases, and the `MovieRepository` contract.
- `Presentation` depends on use cases and entities without knowing about OMDb DTOs.
- `Data` contains DTOs, the REST client, mappers, and repository implementations.
- View models use `@Observable` and `@MainActor`.
- Tests use `FakeMovieRepository` without making real network calls.
- The `PreviewMovieRepository` fallback keeps the app runnable without credentials.

## Setup

1. Open `SwiftUICleanArchitectureShowcase.xcodeproj` in Xcode 26 or later.
2. Select the `SwiftUICleanArchitectureShowcase` scheme.
3. Run the `SwiftUICleanArchitectureShowcase` target.

The app works out of the box with local demo data. Configure an OMDb API key only if you want to hit the real API.

## Configuration

### OMDb API Key

Create an API key at [omdbapi.com](https://www.omdbapi.com/), then add it as an environment variable:

```text
Name:  OMDB_API_KEY
Value: your_api_key
```

In Xcode:

1. Open `Product` > `Scheme` > `Edit Scheme...`.
2. Select `Run`.
3. Open the `Arguments` tab.
4. Add `OMDB_API_KEY` under `Environment Variables`.

Avoid committing real API keys in shared Xcode schemes or any tracked file.

## Tests

From the terminal:

```sh
xcodebuild test \
  -project SwiftUICleanArchitectureShowcase.xcodeproj \
  -scheme SwiftUICleanArchitectureShowcase \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2'
```

## Screenshots



## License

SwiftUI Clean Architecture Showcase is available under the MIT License. See [LICENSE](LICENSE) for details.
