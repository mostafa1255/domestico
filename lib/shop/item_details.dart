import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:domestico/SharedPrefrence/save_fav_products.dart';
import 'package:domestico/my_theme.dart';
import 'package:domestico/shop/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemDetails extends StatefulWidget {
  static const String routeName = 'ItemDetails';
  final ProductModel productModel;

  const ItemDetails({super.key, required this.productModel});
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    void _incrementCounter() {
      if (widget.productModel.quantity! > _counter) {
        setState(() {
          _counter++;
        });
      }
    }

    void _minusCounter() {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      }
    }

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
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 247, 245, 245),
            child: Column(children: [
              Container(
                height: 210,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: const Color.fromARGB(255, 226, 226, 238)),
                child: MaterialButton(
                  onPressed: () {},
                  child: Center(
                      child: Image.network(
                    widget.productModel.productPictures![0],
                  )
                      //size: 150,
                      ),
                ),
                //         child: CustomPaint(
                //   painter: CurvePainter(),
                //   size: Size(MediaQuery.of(context).size.width, 200),
                // ),
              ),
              //SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    height: 30,
                                    child: Text(
                                      widget.productModel.name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Brand: ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.primaryLight),
                                    ),
                                    Text(
                                      widget.productModel.category.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.blackColor),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('${widget.productModel.price} EGP',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: MyTheme.primaryLight))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.productModel.description.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.blackColor),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Text('Quantity',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.blackColor)),
                          SizedBox(
                            width: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: IconButton(
                              onPressed: _minusCounter,
                              icon: Icon(
                                Icons.minimize_rounded,
                                size: 40,
                                color: MyTheme.primaryLight,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('$_counter',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.blackColor)),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: _incrementCounter,
                            icon: Icon(
                              Icons.add,
                              size: 40,
                              color: MyTheme.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.primaryLight),
                          onPressed: () async {
                            saveCartProductInSharedPreference(
                                item: widget.productModel);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ));
                          },
                          child: Text(
                            'Add to Cart',
                            style: MyTheme.lightTheme.textTheme.titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                          )),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
