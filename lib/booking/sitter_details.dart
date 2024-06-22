import 'package:domestico/DataLayer/models/user_model.dart';
import 'package:domestico/booking/calendar_screen.dart';
import 'package:domestico/booking/reviews_screen.dart';
import 'package:domestico/booking/sitter_models.dart';
import 'package:domestico/my_theme.dart';
import 'package:flutter/material.dart';

class SitterDetails extends StatelessWidget {
  static const String routeName = 'SitterDetails';
  final UserModel user;
  const SitterDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: MyTheme.primaryLight,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: MyTheme.whiteColor,
                  ),
                ),
              );
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Details',
              style: MyTheme.lightTheme.textTheme.titleLarge,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 17.0, top: 20.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewsScreen(),
                      ));
                },
                icon: Icon(Icons.reviews, color: MyTheme.whiteColor),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 247, 245, 245),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 210,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Color.fromARGB(255, 226, 226, 238),
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          Models().sitterModels[0].imageSrc,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.username!,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Animal Type: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.primaryLight,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                user.animals!.isNotEmpty
                                    ? user.animals![0].animalType!
                                    : 'Dog',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (user.animals!.isNotEmpty)
                            Text(
                              'Animal Name: ${user.animals![0].animalName!}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (user.animals!.isNotEmpty)
                            Text(
                              'Age: ${user.animals![0].age!}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primaryLight,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalendarScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Make an Appointment',
                        style: MyTheme.lightTheme.textTheme.titleSmall!
                            .copyWith(color: MyTheme.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
