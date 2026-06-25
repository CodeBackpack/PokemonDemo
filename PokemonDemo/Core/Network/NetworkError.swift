//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case apiError(String)
    case decodingError
    case unknown

    public var errorDescription: String? {
        switch self {
        case .apiError(let msg): return msg
        case .decodingError: return "Decoding error"
        case .unknown: return "Unknown network error"
        }
    }
}
