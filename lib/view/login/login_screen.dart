// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:developer';
import 'package:akpa/service/api_service.dart';
import 'package:akpa/service/store_service.dart';
import 'package:akpa/view/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final StoreService storeService = StoreService();

  bool isLoading = false;
  bool signInObscureText = true;

  void signInObscureChange() {
    setState(() {
      signInObscureText = !signInObscureText;
    });
  }

  Future<void> attemptLogin() async {
    setState(() {
      isLoading = true;
    });

    String username = usernameController.text;
    String password = passwordController.text;

    final loginResponse = await apiService.login(username, password);

    setState(() {
      isLoading = false;
    });

    if (loginResponse != null) {
      await storeService.setKeys('username', username);
      await storeService.setKeys('password', password);

      await apiService.updateDeviceToken(username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottombarScreens(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password, please try again'),
        ),
      );
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1) 2022-2023 വർഷത്തിൽ അംഗത്വമുള്ള എല്ലാ എ.കെ.പി.എ. അംഗങ്ങളെയും പ്രായഭേദമന്യേ ഈ പദ്ധതിയിൽ ചേർത്തിട്ടുണ്ട് .',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '2)എന്നാൽ പുതുതായി സംഘടനയിൽ അംഗത്വം എടുക്കുന്ന 55 വയസ്സ് കഴിഞ്ഞ അംഗങ്ങളെ ഈ പദ്ധതിയിൽ ഉൾപെടുത്തുന്നതല്ല. ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '3)തുടർച്ചയായി 5 വർഷം എ കെ പി എ മെമ്പർഷിപ്പിലുള്ള 70 വയസ്സ് തികയാത്ത അംഗങ്ങളെ 2024 -25 വർഷത്തിൽ സാന്ത്വനം പദ്ധതിയിൽ ചേർക്കാവുന്നതും തുടർ വർഷങ്ങളിൽ എ കെ പി എ അംഗങ്ങളായ 55 വയസ്സ് കഴിഞ്ഞവർക്കും ഡയാലിസിസ്, ക്യാൻസർ നിലവിൽ പക്ഷാഘാതം,  ഹൃദയസംബന്ധമായി ചികിത്സയിൽ കഴിയുന്നവരെയും ഈ പദ്ധതിയിൽ ഉൾപ്പെടുത്തുന്നതല്ല.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '4) സീറോ ബാലൻസ് ഉള്ള അംഗങ്ങൾക്ക്  പദ്ധതി ആനുകൂല്യം ലഭിക്കുകയും എന്നാൽ മൈനസ് ബാലൻസ് ഉള്ള അംഗങ്ങൾക്ക് പദ്ധതി ആനുകൂല്യത്തിന് അർഹത ഉണ്ടായിരിക്കുന്നതല്ല.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '5) പദ്ധതിയിലെ അംഗങ്ങളുടെ മരണം മൂലവും, അംഗങ്ങൾ പിന്മാറുന്നതു മൂലവും  പദ്ധതിയിൽ നിന്നും അംഗങ്ങളുടെ ക്രമാതീതമായ കുറവ് ഉണ്ടാകുന്നത് കാരണം കരുതൽ ധനം കഴിയുന്ന സാഹചര്യം ഉണ്ടായാൽ പദ്ധതിയിൽ നിലനിൽക്കുന്ന അംഗങ്ങളുടെ എണ്ണം അനുസരിച്ചുള്ള തുകയായിരിക്കും മരണപ്പെടുന്ന അംഗത്തിന്റെ കുടുംബത്തിന് നൽകുക',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/akpalogo.jpeg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const Text(
                'Santhwanam',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                    suffixIcon:
                        Icon(Icons.check_circle_outlined, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter User Name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: signInObscureText,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: signInObscureChange,
                      icon: Icon(
                        signInObscureText
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       onPressed: () {},
              //       child: const Text(
              //         'Forgot password?',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await attemptLogin();
                          } catch (e) {
                            log("validation error: $e");
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 20),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Don’t have an account? ',
              //       style: TextStyle(fontSize: 12, color: Colors.black),
              //     ),
              //     // GestureDetector(
              //     //   onTap: () async {
              //     //     final url = Uri.parse(
              //     //         'https://lifelinekeralatrust.com/member/auth/register');
              //     //     if (await canLaunchUrl(url)) {
              //     //       await launchUrl(url);
              //     //       log('URL opened: $url');
              //     //     } else {
              //     //       log('Could not launch URL');
              //     //     }
              //     //   },
              //     //   child: const Text(
              //     //     'Register now',
              //     //     style: TextStyle(
              //     //         fontSize: 18,
              //     //         color: Colors.black,
              //     //         decoration: TextDecoration.underline),
              //     //   ),
              //     // ),
              //   ],
              // ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'By signing up, you agree with our ',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () => _showTermsAndConditions(context),
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
