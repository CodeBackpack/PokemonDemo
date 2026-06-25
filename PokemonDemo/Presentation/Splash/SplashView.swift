//
//  PokemonDemoApp.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive: Bool

    var body: some View {
        ZStack {
            Color(.yellow).ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.accentColor)
                Text("Welcome to PokemonDemo")
                    .font(.title2)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(false))
    }
}
