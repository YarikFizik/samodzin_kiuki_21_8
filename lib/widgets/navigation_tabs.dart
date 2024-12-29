import 'package:flutter/material.dart';
import 'divisions_overview.dart';
import 'learners_overview.dart';

class NavigationTabs extends StatefulWidget {
  const NavigationTabs({super.key});

  @override
  State<NavigationTabs> createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DivivsionsOverview(),
    const LearnersOverview(),
  ];

  final List<String> _headers = [
    'Department List',
    'Student Directory',
  ];

  void _switchPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_headers[_currentIndex])),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _switchPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
        ],
      ),
    );
  }
}
