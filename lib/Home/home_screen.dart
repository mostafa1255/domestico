import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:domestico/Home/check_user_type.dart';
import 'package:domestico/SharedPrefrence/SharedPref.dart';
import 'package:domestico/SharedPrefrence/save_fav_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:domestico/DataLayer/cubits/home_cubit/home_cubit.dart';
import 'package:domestico/booking/sitter_list.dart';
import 'package:domestico/drawer/about_app.dart';
import 'package:domestico/drawer/contact_us.dart';
import 'package:domestico/favourite/favourite_screen.dart';
import 'package:domestico/login&register/Login_screen.dart';
import 'package:domestico/my_theme.dart';
import 'package:domestico/profile/owner_profile_screen.dart';
import 'package:domestico/shop/Shop.dart';
import 'package:domestico/shop/cart_screen.dart';
import 'package:domestico/shop/item_details.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomNavigationBarExample();
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    _buildHomeWidget(products: []),
    Shop(),
    const CheckUserType(),
    const FavouriteScreen(),
    const OwnerProfileScreen(),
  ];

  static Widget _buildHomeWidget({required List<ProductModel> products}) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return ListView(
            children: [
              Padding(
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
              const SizedBox(height: 40),
              _buildRecommendedItems(products: state.homeModel),
              _buildNearbySitters(),
            ],
          );
        } else if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        } else if (state is HomeFailure) {
          return Center(
            child: Text(
              "Something went wrong ${state.errMessage}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  static Widget _buildRecommendedItems({required List<ProductModel> products}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Recommended Items',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          child: SizedBox(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ItemDetails(
                            productModel: products[index],
                          );
                        }));
                      },
                      child: Material(
                        elevation: 5,
                        child: Column(
                          children: [
                            Image.network(products[index].productPictures![0],
                                height: 120),
                            Row(
                              children: [
                                Text(
                                  products[index].price.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyTheme.primaryLight,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                FavoriteButton(
                                  valueChanged: (_) {
                                    saveFavoriteProductInSharedPreference(
                                        item: products[index]);
                                  },
                                  iconSize: 30,
                                ),
                              ],
                            ),
                            Text(
                              products[index].name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildNearbySitters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Nearby Sitters',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 220,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/img.png', height: 120),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '2.5 km',
                            style: TextStyle(
                              fontSize: 15,
                              color: MyTheme.primaryLight,
                            ),
                          ),
                          const SizedBox(width: 20),
                          FavoriteButton(
                            valueChanged: (_) {},
                            iconSize: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text(
                            '5.0',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '(100 Reviews)',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Domestico", style: TextStyle(color: Colors.white)),
        backgroundColor: MyTheme.primaryLight,
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyTheme.primaryLight,
              ),
              child: const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Theme Mode'),
              trailing: Switch(
                value: true,
                onChanged: (bool newVal) {
                  setState(() {
                    newVal = true;
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Order History'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text('Cart'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
              leading: Icon(Icons.support_agent),
              title: Text('Contact Us'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutApp()),
                );
              },
              leading: Icon(Icons.newspaper),
              title: Text('About App'),
            ),
            ListTile(
              onTap: () async {
                removeToken();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              title: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyTheme.primaryLight,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
