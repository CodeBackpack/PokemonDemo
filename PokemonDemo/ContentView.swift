//
//  ContentView.swift
//  PokemonDemo
//
//  Created by 顾鸿飞 on 2026/6/24.
//

import SwiftUI
/*
 
 「PokemonDemo」的SwiftUI iOS项目，采用Clean Architecture架构，满足以下全部需求：
 1. 纯SwiftUI开发，无需精美UI，基础可用即可。
 2. 启动页：首次打开展示Splash欢迎页，延时自动跳转首页。
 3. 接口：GraphQL地址 https://beta.pokeapi.co/graphql/v1beta，使用pokemon_v2_pokemonspecies做模糊名称查询，使用Apollo iOS SDK + Apollo CLI处理GraphQL请求，自动生成查询模型。
 4. 首页搜索模块：采用输入框+搜索按钮方案，输入为空时按钮置灰；点击按钮模糊搜索宝可梦物种，请求时展示加载视图，结果分页展示；列表项显示物种名称、捕获率、旗下宝可梦，列表背景色根据接口返回pokemon_v2_pokemoncolor.name映射为对应Color；点击条目跳转详情页。
 5. 详情页：展示宝可梦名称、所有abilities特性；自带返回按钮，返回首页保留全部搜索结果。
 6. 技术要求：使用Combine，ViewModel采用ObservableObject；使用NavigationStack路由，分层架构分为Core公共层、Data数据层(Apollo数据源+Repository)、Domain领域层(Entity实体+UseCase用例)、Presentation页面层(Splash、Home、Detail)；增加分页工具、颜色映射工具、网络错误状态处理。
 7. 输出完整分层目录结构 + 各模块核心可运行代码，包含Apollo客户端封装、GraphQL查询语句、Splash启动页、首页搜索列表、详情页面、ViewModel、Repository、UseCase完整代码。

 */
struct ContentView: View {
    @State private var splashActive: Bool = false

    // Wire simple dependencies here. In a real app use DI container.
    private var repository = PokemonRepository()
    private var useCase: SearchSpeciesUseCase

    init() {
        self.useCase = SearchSpeciesUseCase(repository: repository)
    }

    var body: some View {
        ZStack {
            NavigationStack {
                HomeView(viewModel: HomeViewModel(useCase: useCase))
            }
            
            if !splashActive {
                SplashView(isActive: $splashActive)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
