import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Example pages for each tab
  final List<Widget> _pages = [
    Center(
      child: Text("Chats Page", style: TextStyle(color: Colors.white)),
    ),
    Center(
      child: Text("Groups Page", style: TextStyle(color: Colors.white)),
    ),
    Center(
      child: Text("Phone Page", style: TextStyle(color: Colors.white)),
    ),
    Center(
      child: Text("Message Page", style: TextStyle(color: Colors.white)),
    ),
    Center(
      child: Text("Profile Page", style: TextStyle(color: Colors.white)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0056A6),
      body: Stack(
        children: [
          // ======= Page Content =======
          Positioned.fill(child: _pages[_selectedIndex]),

          // ======= Bottom Navigation =======
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 65,
                  color: const Color(0xff023C7B),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _bottomIcon(Icons.chat_bubble, "Chats", 0),
                      _bottomIcon(Icons.people, "Groups", 1),
                      _bottomIcon(Icons.phone, "Phone", 2),
                      _bottomIcon(Icons.message, "Message", 3),
                      _bottomIcon(Icons.person, "Profile", 4),
                    ],
                  ),
                ),
                Container(
                  height: 39,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff012B5E)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "©2025 Kingdom® Call Circles",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Licensed Trademark",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Bottom Navigation Icon =====
  Widget _bottomIcon(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xffFF6600) : Colors.white,
            size: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xffFF6600) : Colors.white,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
