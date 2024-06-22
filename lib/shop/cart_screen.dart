import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:domestico/SharedPrefrence/save_fav_products.dart';
import 'package:domestico/my_theme.dart';
import 'package:domestico/shop/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = 'CartScreen';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _counter = 0;
  List<ProductModel> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    cartItems = await SaveCartProducts.getItems();
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _minusCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  double calculateTotalAmount() {
    double total = 0;
    for (var item in cartItems) {
      total += item.price ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = calculateTotalAmount();
    double discount = 20.00; // Example discount amount
    double total = subtotal - discount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryLight,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new_rounded, color: MyTheme.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Cart',
          style: MyTheme.lightTheme.textTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: MyTheme.offwhiteColor),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Slidable(
                    startActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              cartItems.removeAt(index);
                              SaveCartProducts.saveItems(cartItems);
                            });
                          },
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Container(
                            color: MyTheme.primaryLight,
                            height: 90,
                            width: 4,
                          ),
                          Image.network(
                            item.productPictures![0],
                            height: 80,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.price.toString(),
                                  style: TextStyle(
                                    color: MyTheme.primaryLight,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  item.name!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: _incrementCounter,
                                icon: Icon(
                                  Icons.add,
                                  color: MyTheme.primaryLight,
                                ),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: _minusCounter,
                                icon: Icon(
                                  Icons.remove,
                                  color: MyTheme.primaryLight,
                                ),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SubTotal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'EGP ${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Discount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'EGP  -${discount.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'EGP ${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: MyTheme.primaryLight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 100,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Checkout',
                      style: TextStyle(color: MyTheme.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
