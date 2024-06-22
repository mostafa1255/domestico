import 'package:domestico/DataLayer/webservice.dart';
import 'package:domestico/Home/home_screen.dart';
import 'package:domestico/SharedPrefrence/SharedPref.dart';
import 'package:domestico/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SitterRegister extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  const SitterRegister({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SitterRegister> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  final List<String> cities = [
    'Alexandria',
    'Cairo',
    'Giza',
    'Shubra El-Kheima',
    'Port Said',
    'Suez',
    'Luxor',
    'Mansoura',
    'Tanta',
    'Asyut',
    'Ismailia',
    'Faiyum',
    'Zagazig',
    'Damietta',
    'Aswan',
    'Minya',
    'Beni Suef',
    'Hurghada',
    'Qena',
    'Sohag',
    'Shibin El Kom',
    'Banha',
    'Kafr El Sheikh',
    'Arish',
    'Mallawi',
    '10th of Ramadan City',
    '6th of October City',
    'Banha',
    'Damanhur',
    'Marsa Matruh'
  ];
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.primaryLight,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 45, left: 14, right: 14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Domestico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              buildTextFormField(
                controller: name,
                label: 'Name',
              ),
              const SizedBox(height: 30),
              buildTextFormField(
                controller: email,
                label: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 30),
              buildTextFormField(
                controller: address,
                label: 'address',
                obscureText: false,
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownMenu(
                  hint: 'Select a city',
                  dropdownMenuEntries: cities.map((city) {
                    return DropdownMenuEntry(value: city, label: city);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                    print('Selected City: $value');
                  },
                ),
              ),
              const SizedBox(height: 30),
              buildTextFormField(
                controller: password1,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              buildTextFormField(
                controller: password2,
                label: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (password1.text == password2.text &&
                      selectedCity != null) {
                    setString(key: userTypeKey, data: "sitter");
                    final res = await HttpService().registerWebService({
                      "email": email.text.trim(),
                      "password": password1.text,
                      "username": name.text,
                      "userType": "sitter",
                      "address": address.text,
                      "city": selectedCity!,
                    });
                    if (res.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                      const SnackBar(
                        content: Text(
                          ' Registration Successful',
                        ),
                        backgroundColor: Colors.green,
                      );
                    } else {
                      // Handle error
                    }
                  } else {
                    const SnackBar(
                      content: Text(
                        'Passwords do not match',
                      ),
                      backgroundColor: Colors.red,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  width: 180,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9C1AFF), Color(0xFF7F00FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget buildTextFormField({
  required TextEditingController controller,
  required String label,
  bool obscureText = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: 'Enter your $label',
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

class DropdownMenu extends StatefulWidget {
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final Function(String?) onChanged;
  final String? hint;

  const DropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    required this.onChanged,
    this.hint,
  });

  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        hint: Text(widget.hint ?? ''),
        items: widget.dropdownMenuEntries.map((DropdownMenuEntry entry) {
          return DropdownMenuItem<String>(
            value: entry.value,
            child: Text(entry.label),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          widget.onChanged(newValue);
        },
        underline: const SizedBox(),
        isExpanded: true,
      ),
    );
  }
}

class DropdownMenuEntry {
  final String value;
  final String label;

  DropdownMenuEntry({
    required this.value,
    required this.label,
  });
}
