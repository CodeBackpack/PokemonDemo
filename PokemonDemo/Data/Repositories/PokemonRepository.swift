//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation
import Combine
import Apollo

public protocol PokemonRepositoryProtocol {
    func searchSpecies(name search: String, limit: Int, offset: Int) -> AnyPublisher<[PokemonSpeciesEntity], NetworkError>
}

public final class PokemonRepository: PokemonRepositoryProtocol {
    private let client: ApolloClient

    public init(client: ApolloClient = ApolloClientProvider.shared.client) {
        self.client = client
    }

    public func searchSpecies(name search: String, limit: Int, offset: Int) -> AnyPublisher<[PokemonSpeciesEntity], NetworkError> {
        let queryString = "%" + search + "%"
        let query = PokemonAPI.SearchSpeciesQuery(search: queryString, limit: Int32(limit), offset: Int32(offset))

        return Future { promise in
            self.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let graphQLResult):
                    let nodes = graphQLResult.data?.pokemon_v2_pokemonspecies ?? []
                    let entities: [PokemonSpeciesEntity] = nodes.compactMap { node in
                        let id = node.id
                        let name = node.name
                        let capture = node.capture_rate
                        let colorName = node.pokemon_v2_pokemoncolor?.name
                        let pokemons: [PokemonEntity] = (node.pokemon_v2_pokemons).compactMap { p in
                            let pid = p.id
                            let pname = p.name
                            let abilities = (p.pokemon_v2_pokemonabilities).compactMap { $0.pokemon_v2_ability?.name }
                            return PokemonEntity(id: pid, name: pname, abilities: abilities)
                        }
                        return PokemonSpeciesEntity(id: id, name: name, captureRate: capture, colorName: colorName, pokemons: pokemons)
                    }
                    promise(.success(entities))
                case .failure(let error):
                    promise(.failure(.apiError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
