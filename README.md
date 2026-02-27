# 🎲 BacklogRoulette

<p align="center">
  <img src="assets/readme/banner.png" alt="BacklogRoulette Banner" width="100%">
</p>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  </a>
  <a href="https://riverpod.dev">
    <img src="https://img.shields.io/badge/Riverpod-232323?style=for-the-badge&logo=riverpod&logoColor=white" alt="Riverpod">
  </a>
  <a href="https://firebase.google.com">
    <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
  </a>
</p>

<h3 align="center">Kill your backlog, kill your back pain.</h3>

---

## 🚀 Sobre o Projeto

O **BacklogRoulette** é um aplicativo Flutter desenvolvido para resolver o clássico dilema do gamer moderno: ter uma biblioteca gigante e não saber o que jogar.

Diferente de um sorteio aleatório simples, o app utiliza um **sistema de filtro inteligente chamado 'Moods'**. O usuário seleciona seu estado de espírito atual e o algoritmo atribui pesos aos jogos da biblioteca que correspondem a essa "vibe", garantindo que a roleta sugira o jogo perfeito para o momento, mas ainda com aquela aleatoriedade caótica.

> **Nota:** Este projeto foi desenvolvido focado em alta performance, UI moderna com animações fluidas e uma arquitetura escalável.

---

## 📸 Demonstração

<table style="width: 100%; border-collapse: collapse; text-align: center;">
    <thead>
        <tr>
            <th style="border: 1px solid #ddd; padding: 8px;">Home Screen</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Roulette</th>
            <th style="border: 1px solid #ddd; padding: 8px;">Settings</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="border: 1px solid #ddd; padding: 8px;">
                <img src="assets/readme/gifs/home.gif" alt="Home" style="max-width: 100%; height: auto;">
            </td>
            <td style="border: 1px solid #ddd; padding: 8px;">
                <img src="assets/readme/gifs/roulette.gif" alt="Roulette" style="max-width: 100%; height: auto;">
            </td>
            <td style="border: 1px solid #ddd; padding: 8px;">
                <img src="assets/readme/gifs/settings.gif" alt="Settings" style="max-width: 100%; height: auto;">
            </td>
        </tr>
    </tbody>
</table>
---

## ✨ Principais Funcionalidades

* **⚡ Experiência do Usuário Elevada (UX):** UI 100% animada, com foco em transições fluidas (*Hero animations*) e *Haptic Feedback* para um toque tátil e satisfatório.
* **🧠 Algoritmo de "Moods":** Filtros inteligentes que cruzam o humor do jogador com o estilo dos jogos.
* **🔗 Integração Multiverso (API Mashup):** Integração profunda com **Steam API** para importar a biblioteca e **IGDB API** para metadados ricos (capas, gêneros, descrições).
* **🌐 Localização Global:** Suporte a 6 idiomas (PT, PT-BR, EN, ZH, FR, ES) usando o pacote oficial `l10n`.
* **🔒 Autenticação Segura:** Login facilitado com Firebase Auth.

---

## 🛠️ Stack Tecnológica

O app utiliza o estado da arte do desenvolvimento Flutter:

* **UI/Core:** Flutter
* **Gerenciamento de Estado & DI:** `riverpod` (Mais de 50 providers gerenciando temas, línguas e a lógica de negócios).
* **Modelagem de Dados & Imutabilidade:** `freezed` (com *pattern matching* para garantir segurança no código).
* **Backend & Cache:** Firebase (Auth & Firestore).
* **Persistência Local:** `isar` (Planejado para cache offline de jogos e configurações).
* **APIs:** Steam API & IGDB API.

---

## 🏗️ Arquitetura e Estrutura

O projeto adota uma abordagem **Feature-First** híbrida com **MVVM** e **Clean Architecture**, garantindo desacoplamento e facilidade de manutenção.

```text
lib/
├── core/
│   ├── di/
│   ├── firebase/
│   ├── l10n/
│   ├── router/
│   └── themes/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── games/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── home/
│   │   └── presentation/
│   └── settings/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## 🧠 Estratégia de Dados (Cross-Refencing)

Para otimizar performance e custo de API, o app utiliza uma estratégia de cache no Firestore:

1.  O app busca o `appId` da Steam.
2.  Consulta a **IGDB** usando campos de referência externa (fallback via nome do jogo).
3.  Filtra automaticamente demos, playtests e alphas.
4.  Cruza os dados e salva no **Firestore**.
5.  Próximas requisições utilizam o cache do Firestore, tornando o app extremamente rápido.

---

## ⚙️ Como Executar

1.  Clone o repositório:
    ```bash
    git clone [https://github.com/pedrokGs/BacklogRoulette.git](https://github.com/pedrokGs/BacklogRoulette.git)
    ```
2.  Instale as dependências:
    ```bash
    flutter pub get
    ```
3.  Configure o Firebase no projeto (necessário arquivo `google-services.json` e `GoogleService-Info.plist`).
4.  Adicione as chaves de API da Steam e IGDB conforme .env.example.
5.  Execute o app:
    ```bash
    flutter run
    ```