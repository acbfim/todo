import 'package:flutter/material.dart';
import 'package:todo/pages/autenticaded/todo/pages/todo_page.dart';
import '../../shared/utils/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const TodoPage(); // MainPage() // why? it's
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
      ),
    );
  }
}
