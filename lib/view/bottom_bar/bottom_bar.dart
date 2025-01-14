// ignore_for_file: library_private_types_in_public_api

import 'package:akpa/view/dashboard/dashboard.dart';
import 'package:akpa/view/help_provided_list/help_provided_list.dart';
import 'package:akpa/view/home_screen/home.dart';
import 'package:akpa/view/profile_screen/profile.dart';
import 'package:akpa/view/transaction/transaction.dart';
import 'package:flutter/material.dart';

class BottombarScreens extends StatefulWidget {
  const BottombarScreens({
    super.key,
  });

  @override
  __BottombarScreensState createState() => __BottombarScreensState();
}

class __BottombarScreensState extends State<BottombarScreens> {
  int currentPageIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(),
      const DashBoardScreen(),
      const TransactionScreen(),
      const HelpProvidedList(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 132, 211, 248),
            currentIndex: currentPageIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            onTap: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            items: [
              buildBottomNavigationBarItem(
                imagePath: 'assets/home.png',
                index: 0,
                label: 'Home',
              ),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/dashboardicon.png',
                  index: 1,
                  label: 'Dashboard'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/transactionicon.png',
                  index: 2,
                  label: 'Transaction'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/helpprovided.png',
                  index: 3,
                  label: 'Help Provided'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/user.png', index: 4, label: 'Profile'),
            ],
          ),
        ),
      ),
      body: pages[currentPageIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String imagePath,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPageIndex == index
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
          ),
          padding: const EdgeInsets.all(10),
          child: ImageIcon(
            AssetImage(imagePath),
            color: currentPageIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
      label: label,
    );
  }
}
