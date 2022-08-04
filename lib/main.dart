import 'package:flutter/material.dart';
import 'package:todo/pages/shared/pages/defaultPage/default_page.dart';
import 'package:todo/pages/shared/utils/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DefaultPage(),
      title: "Lista de tarefas",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Util.colorSeed),
      ),
    );
  }
}
