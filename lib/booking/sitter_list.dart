import 'package:domestico/DataLayer/cubits/booking_cubit/booking_cubit.dart';
import 'package:domestico/SharedPrefrence/SharedPref.dart';
import 'package:domestico/booking/sitter_details.dart';
import 'package:domestico/booking/sitter_models.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SitterScreen extends StatefulWidget {
  const SitterScreen({super.key});
  static const String routeName = 'SitterScreen';

  @override
  State<SitterScreen> createState() => _SitterScreenState();
}

class _SitterScreenState extends State<SitterScreen> {
  @override
  void initState() {
    getAllSittersByCity();
    super.initState();
  }

  void getAllSittersByCity() async {
    String? city = await getString(key: cityKey);
    BlocProvider.of<BookingCubit>(context).getAllSittersByCity(city: city!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingSuccess) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: SearchAnchor.bar(
                      barHintText: 'Search here',
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return [
                          const Center(
                            child: Text(
                              'No search history.',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ];
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.sitters.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SitterDetails(
                                  user: state.sitters[index],
                                ),
                              ));
                          ///// hena el next widget
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 5,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: double.infinity,
                                  width: 100,
                                  child: Image.network(
                                    Models().sitterModels[0].imageSrc,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.sitters[index].username!,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.sitters[index].city!,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is BookingFailure) {
            return Center(
              child: Text(state.errMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 20)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
