// ignore_for_file: library_private_types_in_public_api

import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/transactionmodel/transaction_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:akpa/service/api_service.dart';
import 'package:akpa/service/notification_service.dart';
import 'package:akpa/view/dashboard/dashboard.dart';
import 'package:akpa/view/death_details/death_list.dart';
import 'package:akpa/view/drawer/drawer.dart';
import 'package:akpa/view/help_provided_list/help_provided_list.dart';
import 'package:akpa/view/home_screen/widgets/widget.dart';
import 'package:akpa/view/transaction/transaction.dart';
import 'package:akpa/view/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Future<Config> config;
  late Future<UserProfile> userProfile;
  late Future<List<Transaction>> transactionList;
  String lastPaymentAmount = '';
  String lastPaymentDate = '';

  int unreadCount = 0;
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    config = ApiService().fetchConfig();
    userProfile = ApiService().getUserProfile();
    transactionList = ApiService().getTransactionList();
    loadUnreadNotificationsCount();
    loadLastTransactionDetails();
    setupBlinkingAnimation();
  }

  Future<void> loadUnreadNotificationsCount() async {
    final count = await NotificationService().getUnreadCount();
    setState(() {
      unreadCount = count;
    });
  }

  Future<void> loadLastTransactionDetails() async {
    try {
      final transactions = await ApiService().getTransactionList();
      if (transactions.isNotEmpty) {
        final lastTransaction = transactions.last;
        setState(() {
          lastPaymentAmount = lastTransaction.amount.toString();
          lastPaymentDate = formatDate(lastTransaction.date);
        });
      }
    } catch (e) {
      // Log or handle error here
    }
  }

  String formatDate(String dateString) {
    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('dd/MM/yyyy');
      final DateTime dateTime = inputFormat.parse(dateString);
      return outputFormat.format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  void setupBlinkingAnimation() {
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Future.wait([config, userProfile]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final config = snapshot.data![0] as Config;
            final userProfile = snapshot.data![1] as UserProfile;

            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Image.asset(
                          'assets/menus.png',
                          height: 30,
                          width: 30,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Expanded(
                      //   child: Container(
                      //     height: 40,
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey.shade300,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //         hintText: 'Search',
                      //         hintStyle: const TextStyle(color: Colors.black54),
                      //         border: InputBorder.none,
                      //         contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //         suffixIcon: Container(
                      //           width: 60,
                      //           decoration: BoxDecoration(
                      //             color: Colors.grey.shade400,
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           child: const Icon(Icons.search, color: Colors.black),
                      //         ),
                      //       ),
                      //       style: const TextStyle(color: Colors.black),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WebViewPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.web_stories_rounded),
                        label: const Text("Day Book"),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: (userProfile.status == 1 &&
                                  userProfile.balanceAmount >= 0)
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          (userProfile.status == 1 &&
                                  userProfile.balanceAmount >= 0)
                              ? 'Active'
                              : 'Inactive',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: getStatusColor(userProfile.balanceAmount),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          getAccountStatus(userProfile.balanceAmount),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if (userProfile.balanceAmount < 0)
                    Center(
                      child: FadeTransition(
                        opacity: opacityAnimation,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text(
                            'Recharge Your Account Immediately',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: buildProfileImage(config, userProfile),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProfile.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            userProfile.districtName,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if (userProfile.balanceAmount < 0)
                    buildCard(
                      context,
                      'Transactions',
                      '',
                      'assets/transactionimg.png',
                      LinearGradient(
                        colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      Colors.white,
                      const TransactionScreen(),
                    ),
                  if (userProfile.balanceAmount >= 0) ...[
                    Text(
                      'Last Payment Rs: $lastPaymentAmount on $lastPaymentDate',
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    buildCard(
                      context,
                      'Dashboard',
                      '',
                      'assets/dashboard.jpg',
                      LinearGradient(
                        colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      Colors.white,
                      const DashBoardScreen(),
                    ),
                    const SizedBox(height: 5),
                    buildCard(
                      context,
                      'Transactions',
                      '',
                      'assets/transactionimg.png',
                      LinearGradient(
                        colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      Colors.white,
                      const TransactionScreen(),
                    ),
                    const SizedBox(height: 5),
                    buildCard(
                      context,
                      'Help Provided list',
                      '',
                      'assets/help img.png',
                      LinearGradient(
                        colors: [Color(0xFF66BB6A), Color(0xFF388E3C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      Colors.white,
                      const HelpProvidedList(),
                    ),
                    const SizedBox(height: 5),
                    buildCard(
                      context,
                      'Death list',
                      '',
                      'assets/death list.jpg',
                      LinearGradient(
                        colors: [Color(0xFFEF5350), Color(0xFFC62828)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      Colors.white,
                      const DeathListPage(),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color getStatusColor(double amount) {
    if (amount < 0) {
      return Colors.red;
    } else if (amount >= 0 && amount < 100) {
      return Colors.orange;
    } else if (amount >= 100 && amount < 500) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  String getAccountStatus(double amount) {
    if (amount < 0) {
      return 'Minus Balance Account';
    } else if (amount >= 0 && amount < 100) {
      return 'Zero Balance Account';
    } else if (amount >= 100 && amount < 500) {
      return 'Below 500 Account';
    } else {
      return 'Above 500 Account';
    }
  }

  // Widget buildProfileImage(Config config, UserProfile userProfile) {
  //   if (userProfile.imageUrl != null && userProfile.imageUrl.isNotEmpty) {
  //     return CircleAvatar(
  //       radius: 25,
  //       backgroundImage: NetworkImage(userProfile.imageUrl),
  //     );
  //   } else {
  //     return const CircleAvatar(
  //       radius: 25,
  //       backgroundImage: AssetImage('assets/images/default_profile.png'),
  //     );
  //   }
  // }
  Widget buildCard(BuildContext context, String title, String subtitle,
      String imagePath, Gradient bgGradient, Color textColor, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: bgGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center contents vertically
            mainAxisAlignment:
                MainAxisAlignment.center, // Center contents horizontally
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center text vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center text horizontally
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center, // Align title to center
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center, // Align subtitle to center
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
