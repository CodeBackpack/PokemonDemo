# PokemonDemo

## 项目介绍
基于 SwiftUI + Clean Architecture 架构开发的宝可梦 iOS 演示项目，通过 Apollo 对接 PokeAPI GraphQL 接口实现宝可梦搜索、分页、详情查看功能。

**GraphQL 接口地址**  
`https://beta.pokeapi.co/graphql/v1beta`

---

## 一、功能需求

### 页面 UI 规范
- 全程纯 SwiftUI 开发，仅保证基础交互可用，无需精致美化界面

### 启动页
- App 首次打开展示 Splash 欢迎页，延时自动跳转首页

### GraphQL 网络能力
- 使用 `pokemon_v2_pokemonspecies` 实现宝可梦名称模糊查询
- 集成 Apollo iOS SDK + Apollo CLI，自动生成 GraphQL 查询模型

### 首页搜索模块
- 搜索输入框搭配搜索按钮，输入内容为空时按钮置灰禁用
- 网络请求期间展示 Loading 加载视图
- 搜索结果分页列表展示，列表条目展示：物种名称、捕获率、旗下宝可梦
- 列表背景色根据接口返回 `pokemon_v2_pokemoncolor.name` 映射为 SwiftUI Color
- 点击列表条目跳转宝可梦详情页

### 详情页面
- 展示宝可梦名称、全部特性 abilities
- 自带导航返回按钮，返回首页后完整保留搜索结果与页面状态

---

## 二、技术实现要求

### 响应式
- 使用 Combine，所有页面 ViewModel 遵循 `ObservableObject`

### 页面路由
- 采用 SwiftUI `NavigationStack` 管理页面跳转

### Clean Architecture 四层分层架构
- **Core**：公共工具基础层
- **Data**：数据层（Apollo 数据源 + Repository 仓储）
- **Domain**：领域层（Entity 业务实体 + UseCase 业务用例）
- **Presentation**：展示页面层（Splash、Home、Detail）

### 通用工具封装
- 分页通用工具类
- 宝可梦颜色映射工具
- 统一网络错误状态处理

---

## 三、仓库包含完整代码资源
- 标准分层项目目录结构
- 各分层完整可运行核心代码
- Apollo 客户端封装代码
- GraphQL 查询语句文件
- Splash 启动页、首页、详情页完整页面代码
- ViewModel、Repository、UseCase 全套业务逻辑代码
