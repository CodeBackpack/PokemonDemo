//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import Foundation

public final class Paginator {
    public private(set) var limit: Int
    public private(set) var offset: Int
    public private(set) var isExhausted: Bool = false

    public init(limit: Int = 20) {
        self.limit = limit
        self.offset = 0
    }

    public func reset() {
        offset = 0
        isExhausted = false
    }

    public func advance(by count: Int) {
        offset += count
    }

    public func markExhausted() {
        isExhausted = true
    }
}
