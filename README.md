# SwiftUI Clean Architecture Showcase

A small iOS app that demonstrates SwiftUI, MVVM, Clean Architecture, REST API integration, async/await, dependency injection, and unit tests.

The product is a movie search app. By default, the app runs with local demo data so it can build and run immediately. To use the real OMDb API, configure the `OMDB_API_KEY` environment variable in the Xcode scheme.

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

## Technical Decisions

- `Domain` defines entities, use cases, and the `MovieRepository` contract.
- `Presentation` depends on use cases and entities without knowing about OMDb DTOs.
- `Data` contains DTOs, the REST client, mappers, and repository implementations.
- View models use `@Observable` and `@MainActor`.
- Tests use `FakeMovieRepository` without making real network calls.
- The `PreviewMovieRepository` fallback keeps the app runnable without credentials.

## Setup

1. Open `SwiftUICleanArchitectureShowcase.xcodeproj` in Xcode 26 or later.
2. If you want to use the real API, create an API key at `https://www.omdbapi.com/`.
3. In the app scheme, add the `OMDB_API_KEY` environment variable with your key.
4. Run the `SwiftUICleanArchitectureShowcase` target.

## Tests

From the terminal:

```sh
xcodebuild test \
  -project SwiftUICleanArchitectureShowcase.xcodeproj \
  -scheme SwiftUICleanArchitectureShowcase \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2'
```

## Main Flow

```text
Home
↓
Movie search
↓
Movie list
↓
Movie details
```

## Screenshots

### Feature: Search Movies
<img width="295" height="640" alt="Simulator Screen Recording - iPhone 17 Pro - 2026-07-09 at 17 26 16" src="https://github.com/user-attachments/assets/4ded531c-ef48-4de6-82ea-e37b5f8fab05" />

### Feature: Movie Details
<img width="295" height="640" alt="Simulator Screen Recording - iPhone 17 Pro - 2026-07-09 at 17 25 27" src="https://github.com/user-attachments/assets/7e51f9d6-5924-44cb-b4ac-13f7157b5cb3" />

