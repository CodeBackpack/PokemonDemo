//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation
import Apollo

public final class ApolloClientProvider {
    public static let shared = ApolloClientProvider()

    public let client: ApolloClient

    private init() {
        let url = URL(string: "https://beta.pokeapi.co/graphql/v1beta")!
        client = ApolloClient(url: url)
    }
}
