import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import '../theme.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeScreen(),
      CartScreen(onBack: () => setState(() => _index = 0)),
      Center(child: Text('Favorites', style: poppins(18))),
      Center(child: Text('Profile', style: poppins(18))),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(child: IndexedStack(index: _index, children: pages)),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNav(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
            ),
          ),
        ],
      ),
    );
  }
}
