//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                TextField("Search species name", text: $viewModel.query)
                    .textFieldStyle(.roundedBorder)
                Button("Search") {
                    viewModel.resetAndSearch()
                }
                .disabled(viewModel.query.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()

            if viewModel.isLoading && viewModel.species.isEmpty {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(viewModel.species) { sp in
                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(species: sp))) {
                            SpeciesRowView(species: sp)
                        }
                        .listRowBackground(ColorMapper.color(for: sp.colorName).opacity(0.25))
                        .onAppear {
                            if sp.id == viewModel.species.last?.id && !viewModel.isLoading {
                                viewModel.loadNextPage()
                            }
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Pokemon Search")
    }
}

struct SpeciesRowView: View {
    let species: PokemonSpeciesEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(species.name.capitalized).font(.headline)
            HStack {
                if let cp = species.captureRate {
                    Text("Capture: \(cp)")
                        .font(.subheadline)
                }
                Spacer()
                Text(species.pokemons.map { $0.name }.joined(separator: ", "))
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
    }
}
