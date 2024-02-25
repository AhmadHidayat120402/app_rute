import 'package:app_rute/presentation/home_page.dart';
import 'package:app_rute/presentation/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigasi extends StatefulWidget {
  const BottomNavigasi({super.key});

  @override
  State<BottomNavigasi> createState() => _BottomNavigasiState();
}

class _BottomNavigasiState extends State<BottomNavigasi> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 12, 222, 237),
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 15, // Meningkatkan ketebalan shadow
        type: BottomNavigationBarType
            .fixed, // Mencegah bottom navigation bar dari shrinking
        selectedFontSize: 14,
        unselectedFontSize: 12,
      ),
    );
  }
}
