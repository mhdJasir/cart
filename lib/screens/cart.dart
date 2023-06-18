import 'package:cart/helper/cart_helper.dart';
import 'package:cart/model/cart_model.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

int counter = 0;

class _CartState extends State<Cart> {
  List<CartModel> cartItems = [];

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  Future getCartItems() async {
    cartItems = await CartHelper().getCartItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            'Add Product',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Row(
                children: [
                  Expanded(child: Text("Name")),
                  SizedBox(
                    width: 10,
                  ),
                  Text("qty"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("price"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(child: Text(cartItem.name ?? "")),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${cartItem.qty}"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${cartItem.price}"),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final cart = CartModel(
                                      name: cartItem.name,
                                      price: cartItem.price,
                                      qty: -1,
                                    );
                                    await CartHelper().addToCart(cart);
                                    getCartItems();
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    child: Center(
                                        child: Icon(
                                      Icons.remove,
                                      size: 15,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final cart = CartModel(
                                      name: cartItem.name,
                                      price: cartItem.price,
                                      qty: 1,
                                    );
                                    await CartHelper().addToCart(cart);
                                    getCartItems();
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      size: 15,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
