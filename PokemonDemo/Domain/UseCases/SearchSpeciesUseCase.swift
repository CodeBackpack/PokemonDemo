//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation
import Combine

public final class SearchSpeciesUseCase {
    private let repository: PokemonRepositoryProtocol

    public init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(search: String, limit: Int, offset: Int) -> AnyPublisher<[PokemonSpeciesEntity], NetworkError> {
        return repository.searchSpecies(name: search, limit: limit, offset: offset)
    }
}
