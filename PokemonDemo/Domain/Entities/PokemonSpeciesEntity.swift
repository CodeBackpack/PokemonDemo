//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation

public struct PokemonEntity: Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let abilities: [String]
}

public struct PokemonSpeciesEntity: Hashable, Identifiable {
    public let id: Int
    public let name: String
    public let captureRate: Int?
    public let colorName: String?
    public let pokemons: [PokemonEntity]
}
