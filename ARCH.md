# ARCH — Preencha após refatoração

## Estrutura final (cole a árvore de pastas)

```
lib/
├── main.dart
├── core/
│   └── app_errors.dart
├── data/
│   ├── todo_local_datasource.dart
│   ├── todo_remote_datasource.dart
│   └── todo_repository_impl.dart
├── model/
│   ├── todo.dart
│   ├── todo_model.dart
│   └── todo_repository.dart
├── view/
│   ├── add_todo_dialog.dart
│   ├── app_root.dart
│   └── todos_page.dart
└── viewmodel/
    └── todo_viewmodel.dart
```

## Fluxo de dependências
UI -> ViewModel -> Repository -> (RemoteDataSource, LocalDataSource)

## Decisões

- Onde ficou a validação?
Camada ViewModel. No TodoViewModel (viewmodel/todo_viewmodel.dart). O metodo addTodo() verifica se o titulo esta vazio antes de chamar o Repository. A View nao faz validacao de regra de negocio.

- Onde ficou o parsing JSON?
Camada Model. No TodoModel (model/todo_model.dart), com fromJson() e toJson(). O TodoRemoteDataSource (camada Data) recebe o JSON bruto e delega a conversao para TodoModel.fromJson(). O TodoRepositoryImpl (camada Data) converte TodoModel para Todo puro (dominio sem JSON).

- Como você tratou erros?
Camadas Data e ViewModel. Os DataSources (camada Data) lancam Exception quando o HTTP retorna status fora de 200-299. O TodoViewModel (camada ViewModel) faz try/catch em todos os metodos (loadTodos, addTodo, toggleCompleted) e expoe o erro via errorMessage (String reativo). A View (camada View) le errorMessage e exibe UI de erro com botao "Tentar novamente". No toggleCompleted, o ViewModel aplica optimistic update (atualiza a UI imediatamente) e faz rollback se a chamada falhar.
