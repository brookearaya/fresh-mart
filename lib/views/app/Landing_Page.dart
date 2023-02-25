// main.dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/cart/cart.dart';
import 'package:provider/provider.dart';

import '../../cart/provider.dart';
import '../../constants/constants.dart';
import '../../services/authentication.dart';
import '../../services/category-service.dart';
import '../../services/product-service.dart';
import '../../services/promotion-service.dart';
import '../../widgets/category.dart';
import '../../widgets/promotion.dart';
import '../../widgets/recommended.dart';
import '../../widgets/reusables.dart';
import '../../widgets/search.dart';
import '../../widgets/title_with_more_bbtn.dart';

import 'package:fresh_mart/routes/routes.dart' as route;

import 'items.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  int productCount = 2;
  bool isSearch = false;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;
  int _counter = 0;

  changeCart() {
    setState(() {
      _counter += 1;
    });
  }

  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    Provider.of<CategoryProvider>(context, listen: false).getCategory(addAllItems: false
    );
    Provider.of<PromotionProvider>(context, listen: false).getPromotions();
    Provider.of<Authentication>(context, listen: false).showProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchKey = TextEditingController();
    var product = Provider.of<ProductProvider>(context);
    var category = Provider.of<CategoryProvider>(context);
    var profile = Provider.of<Authentication>(context);
    final user = Provider.of<Authentication>(context).userList;
    String format = 'http://192.168.0.41:4000/profileImg/$phone.png';
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).canvasColor,
          body: user.isEmpty
              ? LoadingWidget()
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Theme.of(context).canvasColor,
                      floating: true,
                      pinned: true,
                      snap: false,
                      centerTitle: false,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(profile.userList[0].fullName,
                              style: Theme.of(context).textTheme.labelSmall),
                          Row(
                            children: [
                              AutoSizeText(
                                'Addis Ababa, ETHIOPIA',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.arrow_drop_down,
                                      color: Theme.of(context).iconTheme.color))
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notification_important_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: CachedNetworkImage(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: MediaQuery.of(context).size.width * 0.09,
                                imageUrl: format,
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, progress) => LoadingWidget(),
                                errorWidget: (context, url, progress) =>
                                    Container(
                                        decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(defaultImage),
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                      bottom: AppBar(
                          backgroundColor: Theme.of(context).canvasColor,actions: [
                            Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8,right: 8),
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
                      )],
                          title: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green,
                                    width: MediaQuery.of(context).size.width *
                                        0.0008),
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: TextField(
                                cursorColor: Colors.green,
                                controller: searchKey,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.green),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      EvaIcons.options2,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                    },
                                  ),
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )),
                    ),
                    // Other Sliver Widgets
                    SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        CarouselWithDotsPage(
                          imgList: [
                            'imageitems/promotion/pineapple.jpg',
                            'imageitems/promotion/potato.jpg',
                            'imageitems/promotion/meat.jpg',
                            'imageitems/promotion/watermelon.jpg',
                            'imageitems/promotion/tomato.jpg',
                          ],
                        ),
                        TitleWithMoreBtn(title: 'Category', btnPress: () {}),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: category.catagories.length,
                              itemBuilder: (context, index) {
                                return Category(
                                  btnPress: () {},
                                  category: category.catagories[index].Title,
                                  imgUrl: category.catagories[index].ImageUrl,
                                );
                              }),
                        ),
                        TitleWithMoreBtn(
                            title: 'Recommended',
                            btnPress: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  Items()),
                                );
                              });
                            }),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.width,
                            child: product.productList.isEmpty
                                ? Text('no product found')
                                : product.productLoading
                                    ? LoadingWidget()
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: <Widget>[
                                              Recommended(
                                                id: product
                                                    .productList[index].id,
                                                imgUrl: product
                                                    .productList[index]
                                                    .ImageUrl,
                                                title: product
                                                    .productList[index].Title,
                                                btnPress: changeCart,
                                                price: product
                                                    .productList[index].Price,
                                                category: product
                                                    .productList[index]
                                                    .Category,
                                                quantity: product
                                                    .productList[index]
                                                    .Quantity,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                          ),
                        ),
                      ]),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
