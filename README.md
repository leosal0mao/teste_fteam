# Rick and Morty App (Flutter)

Um aplicativo Flutter que consome a [The Rick and Morty API](https://rickandmortyapi.com/) para listar, buscar e exibir detalhes dos personagens da série. O projeto foi construído com foco em uma arquitetura limpa, escalável e de fácil manutenção.

---

## Índice

- [Funcionalidades](#funcionalidades)
- [Arquitetura do Projeto](#arquitetura-do-projeto)
- [Pacotes Utilizados](#pacotes-utilizados)
- [API](#api)
- [Como Executar o Projeto](#como-executar-o-projeto)
- [Autor](#autor)

---

## Funcionalidades

- ✅ **Listagem de Personagens**: Exibe uma lista de personagens da API.
- ✅ **Scroll Infinito**: Carrega mais personagens automaticamente conforme o usuário rola a tela.
- ✅ **Cache em Memória**: As páginas já carregadas são mantidas em cache para evitar requisições repetidas.
- ✅ **Busca por Nome**: Permite filtrar personagens em tempo real com um mecanismo de *debounce* para otimizar as chamadas à API.
- ✅ **Tela de Detalhes**: Apresenta informações detalhadas de cada personagem com um design moderno.

---

## Arquitetura do Projeto

O projeto foi desenvolvido seguindo os princípios da **Clean Architecture**, garantindo a separação de responsabilidades, e implementando o padrão **MVVM (Model-View-ViewModel)** na camada de apresentação.

A estrutura é dividida em três camadas principais:

### 1. Domain (Domínio)

É o núcleo da aplicação. Contém a lógica de negócio pura, sem depender de detalhes de implementação (Flutter, pacotes, etc.).

- **Entities**: Objetos puros do negócio (Ex: `Character`).
- **Repositories (Abstratos)**: Contratos que definem as operações de dados que a aplicação pode realizar (Ex: `CharacterRepository`).
- **Use Cases**: Orquestram o fluxo de dados, encapsulando uma única regra de negócio (Ex: `GetCharacters`).

### 2. Data (Dados)

Responsável por implementar os contratos definidos na camada de Domínio. É aqui que os dados são buscados de fontes externas (API, banco de dados, etc.).

- **Models**: Representações dos dados da API, incluindo a lógica de serialização (`fromJson`).
- **Data Sources**: Classes que fazem a comunicação direta com a API (Ex: `CharacterRemoteDataSource`).
- **Repositories (Concretos)**: Implementação dos repositórios do domínio, que orquestram de onde os dados vêm (rede, cache, etc.).

### 3. Presentation (Apresentação - MVVM)

A camada de interface do usuário (UI) e a lógica de apresentação.

- **View**: Os Widgets do Flutter. A View é "burra", apenas exibe o que o ViewModel manda e notifica sobre as interações do usuário (Ex: `CharacterListPage`).
- **ViewModel (Provider)**: O intermediário que gerencia o estado da View. Ele chama os *Use Cases* para obter os dados, trata os estados (carregando, sucesso, erro) e expõe os dados para a View através de um `ChangeNotifier` (`CharacterProvider`).
- **Model**: Neste contexto, são as *Entities* do Domínio, prontas para serem exibidas.

### Fluxo de Dependência

`View` → `ViewModel(Provider)` → `Use Case` → `Repository (Contrato)` → `Repository (Implementação)` → `DataSource`

---

## Pacotes Utilizados

| Pacote                                                              | Versão              | Utilidade                                                       |
| ------------------------------------------------------------------- | ------------------- | --------------------------------------------------------------- |
| [**http**](https://pub.dev/packages/http)                           | `^1.5.0`            | Cliente HTTP para realizar as chamadas à API REST.              |
| [**provider**](https://pub.dev/packages/provider)                   | `^6.1.5+1`            | Gerenciamento de estado, utilizado para implementar o MVVM.     |
| [**either_dart**](https://pub.dev/packages/either_dart)             | `^1.0.0`            | Para tratamento de erros funcional, retornando `Sucesso` ou `Falha`. |

---

## API

Este projeto consome a **The Rick and Morty API**, uma API RESTful baseada no universo da série de TV Rick and Morty.

- **Link para a documentação oficial:** [rickandmortyapi.com/documentation](https://rickandmortyapi.com/documentation)

---

## Como Executar o Projeto

Siga os passos abaixo para executar o projeto localmente.

### Pré-requisitos

- `Projeto feito utilizando a versão 3.32.8 do flutter`
- `Alguma IDE de sua escolha, como o VSCode ou Android Studio`

### Passos

1. **Clone o repositório:**

    ```bash
    git clone https://github.com/leosal0mao/teste_fteam.git
    ```

2. **Navegue até a pasta do projeto:**

    ```bash
    cd nome-do-projeto
    ```

3. **Instale as dependências:**

    ```bash
    flutter pub get
    ```

4. **Execute o aplicativo:**

    ```bash
    flutter run
    ```

---

## Autor

`Leonardo Salomão`

- LinkedIn: [https://www.linkedin.com/in/leosalomao20/]
- GitHub: [https://github.com/leosal0mao]
