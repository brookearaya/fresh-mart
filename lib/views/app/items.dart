import 'package:badges/badges.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/services/category-service.dart';
import 'package:fresh_mart/widgets/category.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:provider/provider.dart';

import '../../cart/cart.dart';
import '../../models/category-model.dart';
import '../../services/product-service.dart';
import '../../widgets/recommended.dart';
import 'package:fresh_mart/routes/routes.dart' as route;

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  int _counter = 0;
  int activeIndex = 0;

  changeCart() {
    setState(() {
      _counter += 1;
    });
  }

  changeIndex(i) {
    setState(() {
      activeIndex = i;
    });
  }

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategory(addAllItems: true);
  }

  @override
  void deactivate() {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    Provider.of<CategoryProvider>(context,listen: false).getCategory();

    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchKey = TextEditingController();

    var product = Provider.of<ProductProvider>(context);
    bool isLoading = product.isLoading;
    final cat = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
            child: ElevatedButton(
              child: const Text(
                'Search',
              ),
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.green,
                  primary: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                if (searchKey.text.isEmpty) {
                  product.fetchProducts();
                }
                product.fetchProductsByTitle(context, searchKey.text.trim());
                /* Clear the search field */
              },
            ),
          )
        ],
        title: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.0008),
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              cursorColor: Colors.green,
              controller: searchKey,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      floatingActionButton: Badge(
        position: BadgePosition.topEnd(top: 0, end: 3),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          Provider.of<Cart>(context).cartItems.length.toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, route.CartPage);
          },
          backgroundColor: Colors.green,
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: cat.catagories.length,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: cat.catagories.length,
                          itemBuilder: (context, index) {
                            if (index == 0)
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.green,
                                      primary: activeIndex == index
                                          ? Colors.green
                                          : Theme.of(context).cardColor),
                                  onPressed: () {
                                    changeIndex(index);
                                    product.getProductByCategory(
                                        context, cat.catagories[index].Title);
                                  },
                                  child: Text(
                                    "All items",
                                    style: activeIndex == index
                                        ? TextStyle(color: Colors.white)
                                        : Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              );
                            else
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.green,
                                      primary: activeIndex == index
                                          ? Colors.green
                                          : Theme.of(context).cardColor),
                                  onPressed: () {
                                    changeIndex(index);
                                    product.getProductByCategory(
                                        context, cat.catagories[index].Title);
                                  },
                                  child: Text(
                                    cat.catagories[index].Title,
                                    style: activeIndex == index
                                        ? TextStyle(color: Colors.white)
                                        : Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              );
                          }),
                    )),
              ),
              Expanded(
                child: product.productList.isEmpty
                    ? Center(
                        child: product.isLoading
                            ? LoadingWidget()
                            : Text('No Product found'),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          // childAspectRatio: 3 / 2,

                          crossAxisSpacing: 10,
                          // mainAxisSpacing: 100
                        ),
                        itemCount: product.productList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Recommended(
                            id: product.productList[index].id,
                            imgUrl: product.productList[index].ImageUrl,
                            title: product.productList[index].Title,
                            btnPress: changeCart,
                            price: product.productList[index].Price,
                            category: product.productList[index].Category,
                            quantity: product.productList[index].Quantity,
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
