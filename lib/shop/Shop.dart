// shop.dart

import 'package:domestico/my_theme.dart';
import 'package:domestico/shop/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domestico/DataLayer/cubits/shopwithcategory_cubit/shopwithcategory_cubit.dart';
import 'package:domestico/DataLayer/models/product_model.dart';

class Shop extends StatefulWidget {
  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.offwhiteColor,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              color: MyTheme.offwhiteColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: SearchAnchor.bar(
                  barHintText: 'Search here',
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return <Widget>[
                      Center(
                          child: Text('No search history.',
                              style: TextStyle(color: Colors.red))),
                    ];
                  },
                ),
              ),
            ),
          ),
        ),
        body: Container(
          color: MyTheme.offwhiteColor,
          child: Column(
            children: [
              TabBar(
                indicatorColor: MyTheme.primaryLight,
                labelColor: MyTheme.primaryLight,
                unselectedLabelColor: Colors.grey,
                onTap: (index) {
                  print(index);
                  if (index == 0) {
                    BlocProvider.of<ShopwithcategoryCubit>(context)
                        .getShopwithcategory(category: 'food');
                  }
                  if (index == 1) {
                    BlocProvider.of<ShopwithcategoryCubit>(context)
                        .getShopwithcategory(category: 'Vet Items');
                  }
                  if (index == 2) {
                    BlocProvider.of<ShopwithcategoryCubit>(context)
                        .getShopwithcategory(category: 'Accessories');
                  }
                  if (index == 3) {
                    BlocProvider.of<ShopwithcategoryCubit>(context)
                        .getShopwithcategory(category: 'IOT Devices');
                  }
                  final categories = [
                    'Food',
                    'Vet Items',
                    'Accessories',
                    'IOT Devices'
                  ];
                  // BlocProvider.of<ShopwithcategoryCubit>(context)
                  //     .getShopwithcategory(category: categories[index]);
                },
                tabs: [
                  Tab(
                      icon: Image.asset('assets/icons/a.png',
                          width: 20, height: 20),
                      text: 'Food'),
                  Tab(
                      icon: Image.asset('assets/icons/b.png',
                          width: 20, height: 20),
                      text: 'Vet Items'),
                  Tab(
                      icon: Image.asset('assets/icons/c.png',
                          width: 20, height: 20),
                      text: 'Accessories'),
                  Tab(
                      icon: Image.asset('assets/icons/d.png',
                          width: 20, height: 20),
                      text: 'IOT Devices'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildCategoryContent(context),
                    buildCategoryContent(context),
                    buildCategoryContent(context),
                    buildCategoryContent(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryContent(BuildContext context) {
    return BlocBuilder<ShopwithcategoryCubit, ShopwithcategoryState>(
      builder: (context, state) {
        if (state is ShopwithcategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShopwithcategorySuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetails(
                          productModel: state.products[index],
                        ),
                      ),
                    );
                  },
                  child: Material(
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 3, color: Colors.transparent),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            state.products[index].productPictures![0],
                            width: 120,
                            height: 120,
                          ),
                          Text(
                            state.products[index].name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: MyTheme.primaryLight),
                          ),
                          Text(
                            '${state.products[index].price} EGP',
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: state.products.length,
            scrollDirection: Axis.vertical,
          );
        }
        if (state is ShopwithcategoryFailure) {
          return Center(
              child: Text(state.errMessage,
                  style: const TextStyle(color: Colors.red)));
        }
        return const Center(
            child: Text('Select a category',
                style: TextStyle(color: Colors.grey)));
      },
    );
  }
}
