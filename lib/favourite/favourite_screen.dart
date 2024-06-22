import 'package:domestico/SharedPrefrence/save_fav_products.dart';
import 'package:domestico/my_theme.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import '../shop/item_details.dart';

class FavouriteScreen extends StatelessWidget {
  static const String routeName = 'FavouriteScreen';

  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: MyTheme.offwhiteColor,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
              child: SearchAnchor.bar(
                barHintText: 'Search here',
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return <Widget>[
                    const Center(
                        child: Text('No search history.',
                            style: TextStyle(color: Colors.red)))
                  ];
                },
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(right: 230.0),
            child: Text(
              'Favourite Items',
              style: MyTheme.lightTheme.textTheme.titleMedium,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          FutureBuilder(
              future: SaveFavoriteProducts.getItems(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 300,
                    width: 300,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetails(
                                    productModel: snapshot.data![index],
                                  ),
                                ));
                          },
                          child: Material(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 3, color: Colors.transparent),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Image.network(snapshot
                                              .data![index]
                                              .productPictures![0]))),
                                  Row(
                                    children: [
                                      Text(
                                        '${snapshot.data![index].price}EGP',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: MyTheme.primaryLight),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    snapshot.data![index].name.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    ));
  }
}
