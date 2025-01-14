import 'package:akpa/view/login/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/splashscreen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/akpalogo.jpeg'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'All Kerala ',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Photographers Association',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Santhwanam',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showTermsAndConditions(context),
                  child: const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
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
}
