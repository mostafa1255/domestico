import 'package:domestico/Home/home_screen.dart';
import 'package:domestico/my_theme.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        title: const Text("Payment", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: MyTheme.primaryLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Card Information",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const CustomTextField(
              labelText: "Card Number",
              hintText: "1234 5678 9012 3456",
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            const Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: "Expiry Date",
                    hintText: "MM/YY",
                    inputType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: CustomTextField(
                    labelText: "CVV",
                    hintText: "123",
                    inputType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const CustomTextField(
              labelText: "Cardholder Name",
              hintText: "John Doe",
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(MyTheme.primaryLight)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType inputType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
