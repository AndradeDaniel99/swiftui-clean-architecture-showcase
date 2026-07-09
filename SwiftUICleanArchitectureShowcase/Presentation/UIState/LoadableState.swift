enum LoadableState<Value: Equatable>: Equatable {
    case idle
    case loading
    case loaded(Value)
    case empty(String)
    case failed(String)
}
