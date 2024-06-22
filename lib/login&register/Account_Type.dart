import 'package:domestico/login&register/Register_screen.dart';
import 'package:domestico/login&register/Sitter_register.dart';
import 'package:domestico/my_theme.dart';
import 'package:flutter/material.dart';

class AccountType extends StatelessWidget {
  static const String routeName = 'AccType';

  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                'Account Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle owner account type selection
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
                // Navigator.of(context).pushNamed('RegisterScreen');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: MyTheme.primaryLight,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.pets, size: 50, color: MyTheme.primaryLight),
                  const Text('Owner', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Handle sitter account type selection
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SitterRegister(),
                    ));
                //Navigator.of(context).pushNamed('RegisterScreen');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: MyTheme.primaryLight,
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.person, size: 50, color: MyTheme.primaryLight),
                  const Text('Sitter', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
