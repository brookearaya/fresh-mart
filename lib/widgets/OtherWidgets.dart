import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/cart/provider.dart';
import 'package:fresh_mart/models/product-model.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/services/product-service.dart';
import 'package:provider/provider.dart';

import '../cart/cart.dart';

class CustomOutlineButtonImg extends StatelessWidget {
  final String imgUrl;
  final double btnHeight;
  final VoidCallback btnPress;

  const CustomOutlineButtonImg(
      {Key? key,
      required this.imgUrl,
      required this.btnHeight,
      required this.btnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: btnPress,
      child: Image.asset(
        imgUrl,
        height: MediaQuery.of(context).size.height * btnHeight,
      ),
    );
  }
}

class CustomOutlineButtonIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback btnPress;

  const CustomOutlineButtonIcon(
      {Key? key, required this.icon, required this.btnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: btnPress,
      child: icon,
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String btnText;
  final VoidCallback btnPress;

  const CustomOutlineButton(
      {Key? key, required this.btnText, required this.btnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: btnPress,
        child: Text(btnText,
            style: TextStyle(color: Colors.black, fontSize: 17.0)));
  }
}

class CustomOutlineButtonImgTxt extends StatelessWidget {
  final String imgUrl;
  final String btnText;
  final double btnHeight;
  final VoidCallback btnPress;

  const CustomOutlineButtonImgTxt({
    Key? key,
    required this.imgUrl,
    required this.btnText,
    required this.btnHeight,
    required this.btnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: btnPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgUrl,
            height: MediaQuery.of(context).size.height * btnHeight,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            btnText,
            style: TextStyle(fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}

class CustomOutlineButtonIconText extends StatelessWidget {
  final IconData icon;
  final String btnText;
  final VoidCallback btnPress;

  const CustomOutlineButtonIconText({
    Key? key,
    required this.icon,
    required this.btnText,
    required this.btnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: btnPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(
            width: 5,
          ),
          Text(
            btnText,
            style: TextStyle(fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final IconButton icon;
  final String btnText;

  const CustomAppBar({
    Key? key,
    required this.icon,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: icon,
      title: Text(
        btnText,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}

class ImageProfile extends StatefulWidget {
  final VoidCallback? pickImage;
  final File? image;

  @override
  _ImageProfileState createState() => _ImageProfileState();

  const ImageProfile({
    Key? key,
    this.pickImage,
    this.image,
  }) : super(key: key);
}

class _ImageProfileState extends State<ImageProfile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          TextButton(
            onPressed: widget.pickImage,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60.0,
              child: Container(
                  child: widget.image == null
                      ? Icon(
                          Icons.account_circle,
                          size: 120,
                          color: Colors.green,
                        )
                      : Image.file(widget.image!)),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).cardColor),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(Icons.camera_alt,
                    color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback btnPress;

  const SettingButtons({
    Key? key,
    required this.icon,
    required this.text,
    required this.btnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          height: MediaQuery.of(context).size.height * 0.06),
      child: ElevatedButton(
        onPressed: btnPress,
        style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            onPrimary: Colors.green,
            shadowColor: Colors.transparent,
            elevation: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(
                icon,
                color: Colors.green,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ]),
            Icon(
              Icons.navigate_next,
              color: Theme.of(context).iconTheme.color,
            )
          ],
        ),
      ),
    );
  }
}

class ImageProfileEdit extends StatelessWidget {
  final NetworkImage net;

  const ImageProfileEdit(this.net, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 60.0,
            backgroundImage: net,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).iconTheme.color,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Custom Quantity
class CustomQuantity extends StatefulWidget {
  String productId;
  bool denied = false;
  CustomQuantity({Key? key, required this.productId}) : super(key: key);

  @override
  State<CustomQuantity> createState() => _CustomQuantityState();
}

class _CustomQuantityState extends State<CustomQuantity> {
  int quantity = 0;
  late int index;

  @override
  Widget build(BuildContext context) {
    var nebil = Provider.of<Cart>(context);
    var items = Provider.of<ProductProvider>(context);
    return quantity == 0
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Icon(Icons.shopping_cart_outlined),
            onPressed: nebil.dismis(widget.productId)
                ? null
                : () {
                    Products prod = items.productList.firstWhere(
                        (element) => element.id == widget.productId);
                    print(prod.Title);

                    Provider.of<Cart>(context, listen: false).addToCart(prod);
                    nebil.dismis(widget.productId);
                  },
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: Icon(
              Icons.remove_shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                quantity--;
              });
              Provider.of<CartCountProvider>(context, listen: false)
                  .removeCartCount();
            },
          );
  }
}

// class CustomCartQuantity extends StatefulWidget {
//   CustomCartQuantity({Key? key, required this.index})
//       : super(key: key);
//   int index;
//
//   @override
//   State<CustomCartQuantity> createState() => _CustomCartQuantityState();
// }
//
// class _CustomCartQuantityState extends State<CustomCartQuantity> {
//   int count = 0;
//   int quantity = 0;
//   int totalQuantity = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     var cartItem = Provider.of<Cart>(context);
//     var prod = Provider.of<Cart>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Flexible(
//           flex: 1,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(5),
//                 primary: Colors.green),
//             child: Icon(
//               Icons.remove,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // prod.getPrice(widget.index, totalQuantity);
//               setState(() {
//                 count--;
//               });
//
//               prod.getPrice(widget.index, count);
//
//               // print(prod.);
//             },
//           ),
//         ),
//         AutoSizeText(
//           quantity.toString(),
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         Flexible(
//           flex: 1,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(5),
//                 primary: Colors.green),
//             onPressed: () {
//               setState(() {
//                 count++;
//               });
//                 prod.getPrice(widget.index, count);
//             },
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Text('price = ${count}'),
//       ],
//     );
//   }
// }

//
// class CustomCart extends StatefulWidget {
//   const CustomCart({Key? key}) : super(key: key);
//
//   @override
//   State<CustomCart> createState() => _CustomCartState();
// }
//
// class _CustomCartState extends State<CustomCart> {
//   bool click = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           click = !click;
//         });
//       },style: ElevatedButton.styleFrom(primary: (click == false) ? Colors.green : Colors.red),
//       child: Icon(
//         (click == false) ? Icons.add_shopping_cart_outlined : Icons.remove_circle,
//         color: (click == false) ? Colors.white : Colors.white,
//       ), // Padding
//     );
//   }
// }