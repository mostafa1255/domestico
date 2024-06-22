import 'package:domestico/Home/home_screen.dart';
import 'package:domestico/my_theme.dart';
import 'package:flutter/material.dart';
import '../DataLayer/webservice.dart';
import '../login&register/Register_screen.dart';

class ChooseAnimalType extends StatelessWidget {
  ChooseAnimalType({super.key});
  final TextEditingController animalType = TextEditingController();
  final TextEditingController animalName = TextEditingController();
  final TextEditingController animalAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryLight,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 250, left: 14, right: 14),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTextFormField(
              controller: animalType,
              label: 'Animal Type',
              obscureText: false,
            ),
            const SizedBox(height: 30),
            buildTextFormField(
              controller: animalName,
              label: 'Animal Name',
              obscureText: false,
            ),
            const SizedBox(height: 30),
            buildTextFormField(
              controller: animalAge,
              label: 'Animal Age',
              obscureText: false,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      MyTheme.primaryLight.withOpacity(0.5)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (animalType.text.isNotEmpty &&
                      animalName.text.isNotEmpty &&
                      animalAge.text.isNotEmpty) {
                    HttpService().patchRequest(data: {
                      "userId": "60d5ec49c2b1f72f44b9cce2",
                      "animalData": {
                        "animalType": animalType.text,
                        "animalName": animalName.text,
                        "animalPicturesUrl": [
                          "https://th.bing.com/th/id/OIP.r5cOR1Vrm9lorAvaACKOsAHaEK?w=301&h=180&c=7&r=0&o=5&pid=1.7"
                        ],
                        "Age": int.parse(animalAge.text)
                      }
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                },
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        )),
      )),
    );
  }
}
