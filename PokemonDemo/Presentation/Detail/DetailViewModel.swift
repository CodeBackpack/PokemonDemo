//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    @Published var species: PokemonSpeciesEntity
    @Published var abilities: [String] = []

    init(species: PokemonSpeciesEntity) {
        self.species = species
        self.abilities = Self.extractAbilities(from: species)
    }

    private static func extractAbilities(from species: PokemonSpeciesEntity) -> [String] {
        let all = species.pokemons.flatMap { $0.abilities }
        return Array(Set(all)).sorted()
    }
}
