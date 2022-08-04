import 'package:flutter/material.dart';
import 'package:todo/pages/autenticaded/home_page/home_page.dart';

import '../../utils/util.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomePage(); // MainPage() // why? it's
      case 1:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'DashBoard',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ); // SecondPage()
      case 2:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Configurações',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        );
      default:
        return Container(color: Colors.amber); // HomePage() same mistake here
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Util.colorBgLight,
        surfaceTintColor: Util.colorBgLight,
        title: const Text('Tarefas'),
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      backgroundColor: Util.colorBgLight,
    );
  }
}
