import 'package:flutter/material.dart';
import 'package:real_chat/core/theme/app_theme.dart';
import 'contacts_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Chats',
    'Contacts',
    'Requests',
    'Settings',
  ];

  static const List<IconData> _icons = [
    Icons.chat_bubble_rounded,
    Icons.people_alt_rounded,
    Icons.person_add_alt_1_rounded,
    Icons.settings_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'real_chat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR SPACE',
                    style: TextStyle(
                      color: AppTheme.lavender,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _titles[_selectedIndex],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _selectedIndex == 0
                        ? 'Your conversations, all in one place.'
                        : _selectedIndex == 1
                        ? 'Find people to connect with.'
                        : _selectedIndex == 2
                        ? 'Manage your friend requests.'
                        : 'Make real_chat yours.',
                    style: const TextStyle(
                      color: AppTheme.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _selectedIndex == 1
                  ? const ContactsTab()
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 104,
                            height: 104,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.deepViolet,
                              border: Border.all(
                                color: AppTheme.plum,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.rosePink.withValues(
                                    alpha: 0.10,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              _icons[_selectedIndex],
                              size: 44,
                              color: AppTheme.rosePink,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _selectedIndex == 0
                                ? 'Your chats start here'
                                : _selectedIndex == 2
                                ? 'No requests to show yet'
                                : 'Your settings',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36),
                            child: Text(
                              _selectedIndex == 0
                                  ? 'Add a friend to start a private conversation.'
                                  : _selectedIndex == 2
                                  ? 'New friend requests will appear here.'
                                  : 'Profile and app preferences will be available here.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.secondaryText,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.deepViolet,
          border: Border(
            top: BorderSide(color: AppTheme.plum.withValues(alpha: 0.7)),
          ),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: AppTheme.rosePink.withValues(alpha: 0.15),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline_rounded),
                selectedIcon: Icon(
                  Icons.chat_bubble_rounded,
                  color: AppTheme.rosePink,
                ),
                label: 'Chats',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(
                  Icons.people_alt_rounded,
                  color: AppTheme.rosePink,
                ),
                label: 'Contacts',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_add_alt_1_outlined),
                selectedIcon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppTheme.rosePink,
                ),
                label: 'Requests',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(
                  Icons.settings_rounded,
                  color: AppTheme.rosePink,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
