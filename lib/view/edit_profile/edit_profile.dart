// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:akpa/service/profile_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;
  final ImagePicker picker = ImagePicker();
  final ProfileService profileService = ProfileService();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File tempImage = File(pickedFile.path);

        if (await isImageValid(tempImage)) {
          setState(() {
            image = tempImage;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Image must be passport size and less than 100KB')),
          );
        }
      }
    } catch (e) {
      log("Error picking image", error: e);
    }
  }

  Future<bool> isImageValid(File imageFile) async {
    // Check file size
    int fileSizeInBytes = await imageFile.length();
    double fileSizeInKB = fileSizeInBytes / 1024;
    if (fileSizeInKB > 100) {
      return false;
    }

    // Check image dimensions
    // var decodedImage = await decodeImageFromList(imageFile.readAsBytesSync());
    // double aspectRatio = decodedImage.width / decodedImage.height;
    //
    // // Passport photo aspect ratio is typically 35:45 (or 7:9)
    // const double passportAspectRatio = 35 / 45;
    // print("passportAspectRatio");
    // print("$passportAspectRatio");
    //
    // // Allow for a small margin of error (e.g., 5%)
    // if ((aspectRatio - passportAspectRatio).abs() > 0.05) {
    //   return false;
    // }

    return true;
  }

  Future<void> uploadProfilePicture() async {
    if (image != null) {
      try {
        // Compress the image if it's larger than 100KB
        print(await image!.length());
        print("length");
        // if (await image!.length() > 100 * 1024) {
        //   var result = await FlutterImageCompress.compressWithFile(
        //     image!.absolute.path,
        //     minWidth: 350,
        //     minHeight: 450,
        //     quality: 85,
        //   );
        //   if (result != null) {
        //     image = File(image!.path)..writeAsBytesSync(result);
        //   }
        // }

        final response = await profileService.updateProfilePicture(image!);
        if (response.status) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile picture')),
          );
        }
      } catch (e) {
        log('Error during profile upload: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error uploading profile picture')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile Picture',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image == null
                  ? const Text(
                      'No image selected.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : Image.file(image!, height: 150),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: uploadProfilePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
