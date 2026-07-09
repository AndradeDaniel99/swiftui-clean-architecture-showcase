# SwiftUI Clean Architecture Showcase

Aplicativo iOS pequeno para demonstrar SwiftUI, MVVM, Clean Architecture, REST API, async/await, dependency injection e testes unitarios.

O produto e uma busca de filmes. Por padrao o app roda com dados locais de demonstracao para permitir build imediato. Para usar a OMDb API real, configure a variavel de ambiente `OMDB_API_KEY` no scheme do Xcode.

## Arquitetura

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

## Decisoes tecnicas

- `Domain` define entidades, casos de uso e o contrato `MovieRepository`.
- `Presentation` depende de use cases e entidades, sem conhecer DTOs da OMDb.
- `Data` concentra DTOs, cliente REST, mappers e implementacoes de repositorio.
- ViewModels usam `@Observable` e `@MainActor`.
- Testes usam `FakeMovieRepository`, sem chamadas reais de rede.
- O fallback `PreviewMovieRepository` deixa o app executavel sem credenciais.

## Setup

1. Abra `SwiftUICleanArchitectureShowcase.xcodeproj` no Xcode 26 ou superior.
2. Se quiser consumir a API real, crie uma chave em `https://www.omdbapi.com/`.
3. No scheme do app, adicione a variavel de ambiente `OMDB_API_KEY` com sua chave.
4. Rode o target `SwiftUICleanArchitectureShowcase`.

## Testes

Pelo terminal:

```sh
xcodebuild test \
  -project SwiftUICleanArchitectureShowcase.xcodeproj \
  -scheme SwiftUICleanArchitectureShowcase \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.2'
```

## Fluxo principal

```text
Home
↓
Busca por texto
↓
Lista de filmes
↓
Detalhe do filme
```

## Screenshots

As capturas devem ser adicionadas em `Docs/Screenshots/` quando o fluxo visual estiver estabilizado.
