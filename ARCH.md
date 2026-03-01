# ARCH — Preencha após refatoração

## Estrutura final (cole a árvore de pastas)

```
lib/
├── main.dart
├── app/
│   └── app.dart
├── core/
│   └── app_errors.dart
└── features/
    └── todos/
        ├── data/
        │   ├── datasource/
        │   │   ├── todo_remote_datasource.dart
        │   │   └── todo_local_datasource.dart
        │   ├── repository/
        │   │   └── todo_repository_impl.dart
        │   └── todo_model.dart
        ├── domain/
        │   ├── todo.dart
        │   └── todo_repository.dart
        └── presentation/
            ├── todo_viewmodel.dart
            ├── todos_page.dart
            └── add_todo_dialog.dart
```

## Fluxo de dependências
UI -> ViewModel -> Repository -> (RemoteDataSource, LocalDataSource)

## Decisões

- Onde ficou a validação?
Camada ViewModel. No TodoViewModel (features/todos/presentation/todo_viewmodel.dart). O metodo addTodo() verifica se o titulo esta vazio antes de chamar o Repository. A View nao faz validacao de regra de negocio.

- Onde ficou o parsing JSON?
Camada Data. No TodoModel (features/todos/data/todo_model.dart), com fromJson() e toJson(). O TodoRemoteDataSource (features/todos/data/datasource/) recebe o JSON bruto e delega a conversao para TodoModel.fromJson(). O TodoRepositoryImpl (features/todos/data/repository/) converte TodoModel para Todo puro (dominio sem JSON).

- Como você tratou erros?
Camadas Data e Presentation. Os DataSources (features/todos/data/datasource/) lancam Exception quando o HTTP retorna status fora de 200-299. O TodoViewModel (features/todos/presentation/todo_viewmodel.dart) faz try/catch em todos os metodos (loadTodos, addTodo, toggleCompleted) e expoe o erro via errorMessage (String reativo). A View (features/todos/presentation/) le errorMessage e exibe UI de erro com botao "Tentar novamente". No toggleCompleted, o ViewModel aplica optimistic update (atualiza a UI imediatamente) e faz rollback se a chamada falhar.
