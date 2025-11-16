import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/features/auth/domain/entities/app_user.dart';
import 'package:datingapp/features/chat/presentation/pages/chat_list_page.dart';
import 'package:datingapp/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0; // keeps track of the selected tab
  final PageController _pageController = PageController();

  List<AppUser> allUsers = [];
  String currentUserId = "";

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final auth = FirebaseAuth.instance;
    currentUserId = auth.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance.collection("users").get();

    allUsers = snapshot.docs.map((doc) {
      return AppUser(uid: doc.id, email: doc['email'], name: doc['name']);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // pages for each tab
    final List<Widget> pages = [
      HomePage(),
      const Center(child: Text("For you")),
      ChatListPage(users: allUsers, currentUserId: currentUserId),
      const Center(child: Text("Search Page")),
      const Center(child: Text("Profile Page")),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFFF3EA4), // <-- Use 0xFF + your hex code
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _selectedIndex, // highlight selected item
        onTap: _onItemTapped, // handle tap
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "For you"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
