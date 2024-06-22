import 'package:domestico/SharedPrefrence/SharedPref.dart';
import 'package:domestico/booking/request_from_owner.dart';
import 'package:domestico/booking/sitter_list.dart';
import 'package:flutter/material.dart';

class CheckUserType extends StatelessWidget {
  const CheckUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getString(key: userTypeKey),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data == 'owner') {
              return SitterScreen();
            } else {
              return const RequestFromOwner();
            }
          }
        });
  }
}
