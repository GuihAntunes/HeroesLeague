# HeroesLeague

# Stack
- Xcode 11.6
- Swift 5

# Arquitetura
- **Model:** Representa os dados da aplicação
- **View:** Camada de apresentação visual
- **ViewModel:** Camada de regras de apresentação e regras de negócio (se houver alguma no frontend)
- **Service:** Camada que busca os dados da internet ou do Core Data
- **Repository:** Camada que decide onde buscar os dados (API ou Core Data)
- **Coordinator:** Camada que orquestra os fluxos de apresentação do app
- **Injector:** Camada que injeta as dependências de cada tela/view model do app

# Fluxo de camadas do app (Como as camadas se comunicam)

AppDelegate -> Coordinator (Injector) <-> ViewModel (Repository/Service) <-> View
