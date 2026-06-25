//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var species: [PokemonSpeciesEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let useCase: SearchSpeciesUseCase
    private let paginator = Paginator(limit: 20)
    private var cancellables: AnyCancellable?

    init(useCase: SearchSpeciesUseCase) {
        self.useCase = useCase
    }

    func resetAndSearch() {
        paginator.reset()
        species = []
        loadNextPage()
    }

    func loadNextPage() {
        guard !isLoading, !paginator.isExhausted, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        isLoading = true
        errorMessage = nil

        cancellables = useCase.execute(search: query, limit: paginator.limit, offset: paginator.offset)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let err) = completion {
                    self.errorMessage = err.localizedDescription
                }
            } receiveValue: { items in
                if items.count < self.paginator.limit {
                    self.paginator.markExhausted()
                } else {
                    self.paginator.advance(by: items.count)
                }
                self.species.append(contentsOf: items)
            }
    }
}
