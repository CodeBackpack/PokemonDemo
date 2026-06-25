//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import SwiftUI

public struct ColorMapper {
    public static func color(for name: String?) -> Color {
        guard let name = name?.lowercased() else { return Color(.systemBackground) }
        switch name {
        case "red": return .red
        case "blue": return .blue
        case "yellow": return .yellow
        case "green": return .green
        case "brown": return Color.brown
        case "purple": return .purple
        case "gray", "grey": return .gray
        case "pink": return .pink
        case "white": return .white
        case "black": return .black
        default: return Color(.systemBackground)
        }
    }
}
