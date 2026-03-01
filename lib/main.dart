import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/app_root.dart';
import 'viewmodel/todo_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
      ],
      child: const AppRoot(),
    ),
  );
}
