//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.species.name.capitalized)
                .font(.largeTitle)
                .padding(.bottom, 8)

            Text("Abilities")
                .font(.headline)

            if viewModel.abilities.isEmpty {
                Text("No abilities available")
                    .foregroundColor(.secondary)
            } else {
                ForEach(viewModel.abilities, id: \ .self) { a in
                    Text(a.capitalized)
                        .padding(.vertical, 4)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.species.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
