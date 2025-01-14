import 'dart:developer';
import 'package:akpa/model/helpmodel/help_model.dart';
import 'package:akpa/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/confgmodel/config_model.dart';

class HelpProvidedList extends StatefulWidget {
  const HelpProvidedList({super.key});

  @override
  State<HelpProvidedList> createState() => _HelpProvidedListState();
}

class _HelpProvidedListState extends State<HelpProvidedList> {
  late Config config;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        config = await ApiService().fetchConfig();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Help Provided List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<HelpModel>(
                  future: ApiService().getUserList(),
                  builder: (context, snapshot) {
                    log('Snapshot Data: ${snapshot.data}');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error ui: ${snapshot.error}');
                      return const Center(
                        child: Text(
                          'Failed to load help list',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.list == null) {
                      return const Center(
                        child: Text(
                          'No help provided.',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else if (snapshot.data!.list != null &&
                        snapshot.data!.list!.data != null &&
                        snapshot.data!.list!.data!.isNotEmpty) {
                      final helpList = snapshot.data!.list!.data;
                      return ListView.builder(
                        itemCount: helpList!.length,
                        itemBuilder: (context, index) {
                          final help = helpList[index];
                          final name = help.name;
                          final image = help.image!.isNotEmpty
                              ? "${config.baseUrls.customerImageUrl}/${help.image}"
                              : 'https://via.placeholder.com/150';
                          final helpImage = help.helpImage!.isNotEmpty
                              ? "${config.baseUrls.customerImageUrl}/${help.helpImage}"
                              : 'https://via.placeholder.com/150';

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ExpansionTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    ' ${index + 1}  ', // Serial number
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.42,
                                    child: Text(
                                      name!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                help.districtName!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      helpInfo('Name', help.name),
                                      helpInfo('District', help.districtName),
                                      helpInfo('Meghala', help.meghalaName),
                                      helpInfo('Unit', help.unitName),
                                      helpInfo(
                                          'Nominee Name', help.nomineeName),
                                      helpInfo('Akpa Id', help.akpaId),
                                      helpInfo('Mobile', help.mobile),
                                      helpInfo(
                                          'Account Amount', help.accountAmount),
                                      helpInfo(
                                          'Balance Amount', help.balanceAmount),
                                      helpInfo(
                                          'Date of Birth',
                                          help.dateOfBirth != null
                                              ? DateFormat('dd-MM-yyyy')
                                                  .format(help.dateOfBirth!)
                                              : 'N/A'),
                                      helpInfo(
                                          'Date of Death',
                                          help.dateOfDeath != null
                                              ? DateFormat('dd-MM-yyyy')
                                                  .format(help.dateOfDeath!)
                                              : 'N/A'),
                                      helpInfo(
                                          'Age',
                                          help.dateOfBirth != null
                                              ? calculateAge(help.dateOfBirth!)
                                              : 'N/A'),
                                      helpInfo(
                                          'Cheque Number', help.chequeNumber),
                                      helpInfo(
                                          'Credited Date',
                                          help.creditedDate != null
                                              ? DateFormat('dd-MM-yyyy')
                                                  .format(help.creditedDate!)
                                              : 'N/A'),
                                      helpInfo('Credited Amount',
                                          help.creditedAmount),
                                      const SizedBox(height: 10),
                                      helpInfo('Help Image', ''),
                                      if (help.helpImage != null &&
                                          help.helpImage!.isNotEmpty)
                                        Image.network(
                                          helpImage,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const SizedBox.shrink(),
                                        ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No help provided.',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility function to calculate age based on date of birth
  String calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  Widget helpInfo(String? title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          Text(
            value?.toString() ?? 'N/A',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
