// ignore_for_file: library_private_types_in_public_api

import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:akpa/service/api_service.dart';

import 'package:akpa/view/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  UserProfile? userProfile;
  Config? _config;
  bool isLoading = true;
  bool showFullDetails = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final profile = await apiService.getUserProfile();
    final config = await apiService.getConfig();
    setState(() {
      userProfile = profile;
      _config = config;
      isLoading = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.black))
            : userProfile != null && _config != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          buildProfileHeader(),
                          const SizedBox(height: 20),
                          buildProfileDetails(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      'Failed to load user details',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget buildProfileHeader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: buildProfileImage(),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userProfile!.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                userProfile!.meghalaName,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    final imageUrl = '${_config!.baseUrls.customerImageUrl}/${userProfile!.image}';
    return Image.network(
      imageUrl,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, size: 80, color: Colors.grey);
      },
    );
  }

  Widget buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          buildProfileDetail('Name', userProfile!.name),
          buildProfileDetail('Mobile', userProfile!.mobile),
          buildProfileDetail('UPI ID', userProfile!.upiId),
          buildProfileDetail('Place', userProfile!.meghalaName),
          buildProfileDetail('District Name', userProfile!.districtName),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              setState(() {
                showFullDetails = !showFullDetails;
              });
            },
            child: Text(
              showFullDetails ? 'Show Less' : 'Show Full Details',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          if (showFullDetails) _buildFullProfileDetails(),
        ],
      ),
    );
  }

  Widget buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        buildProfileDetail('District Name', userProfile!.districtName),
        buildProfileDetail('Meghala Name', userProfile!.meghalaName),
        buildProfileDetail('Unit', userProfile!.unitName),
        buildProfileDetail('Username', userProfile!.username),
        buildProfileDetail('Date of Birth', formatDate(userProfile!.dateOfBirth)),
        buildProfileDetail('Nominee', userProfile!.nomineeName),
        buildProfileDetail('Total Cash', userProfile!.accountAmount.toStringAsFixed(2)),
        buildProfileDetail('Cash Balance', userProfile!.balanceAmount.toStringAsFixed(2)),
      ],
    );
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
}
