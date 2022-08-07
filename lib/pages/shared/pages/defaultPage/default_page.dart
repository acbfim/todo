import 'package:flutter/material.dart';
import 'package:todo/pages/autenticaded/home_page/home_page.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
