import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:flutter/material.dart';

Widget buildProfileImage(Config config, UserProfile userProfile) {
  final imageUrl = '${config.baseUrls.customerImageUrl}/${userProfile.image}';
  return Image.network(
    imageUrl,
    height: 50,
    width: 50,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.person, size: 80, color: Colors.grey);
    },
  );
}
Widget buildCard(BuildContext context, String title, String subtitle, Color backgroundColor, Color textColor, Widget destination) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => destination),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

