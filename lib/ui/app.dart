import 'package:flutter/material.dart';
import 'package:physique_os/ui/screens/habits_screen.dart';
import 'package:physique_os/ui/screens/phase_screen.dart';
import 'package:physique_os/ui/screens/progress_screen.dart';
import 'package:physique_os/ui/screens/today_screen.dart';

class PhysiqueOsApp extends StatefulWidget {
  const PhysiqueOsApp({super.key});

  @override
  State<PhysiqueOsApp> createState() => _PhysiqueOsAppState();
}

class _PhysiqueOsAppState extends State<PhysiqueOsApp> {
  int _selectedIndex = 0;

  final _screens = const [
    TodayScreen(),
    PhaseScreen(),
    HabitsScreen(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physique OS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5F6F52),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F6F2),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.today_outlined),
              label: 'Today',
            ),
            NavigationDestination(
              icon: Icon(Icons.timeline_outlined),
              label: 'My Phase',
            ),
            NavigationDestination(
              icon: Icon(Icons.checklist_outlined),
              label: 'Habits',
            ),
            NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              label: 'Progress',
            ),
          ],
        ),
      ),
    );
  }
}
