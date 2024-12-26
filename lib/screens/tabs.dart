import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/screens/departments.dart';
import 'package:zinoviev_kiuki_21_8/screens/students.dart';
import 'package:zinoviev_kiuki_21_8/widgets/new_student.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = DepartmentsScreen();
    var activePageTitle = 'Departments';
    List<Widget> actions = [];

    if (_selectedPageIndex == 1) {
      activePage = const StudentsScreen();
      activePageTitle = 'Students';
      actions = [
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => const NewStudent());
            },
            icon: const Icon(Icons.add))
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: actions,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Departments'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Students'),
        ],
      ),
    );
  }
}
