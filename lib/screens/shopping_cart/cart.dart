import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product.dart';

List<ProductResponse> products = [];

class CartScreen extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              color: Color(0xFFf8f8f8),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Carro de compras', style: Style.cardTitle),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: null,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'REMOVER TODO',
                                      style: Style.cartResumeItem,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  item(
                                      'objeto',
                                      'Teclado Gamer',
                                      'Descripción del producto, bla abla l lorem ipsum, bla bla bla, estc, que blablablabla .',
                                      200000,
                                      0,
                                      context),
                                  item(
                                      'objeto',
                                      'Teclado Gamer',
                                      'Descripción del producto, bla abla l lorem ipsum, bla bla bla, estc, que blablablabla .',
                                      200000,
                                      1,
                                      context),
                                  item(
                                      'objeto',
                                      'Teclado Gamer',
                                      'Descripción del producto, bla abla l lorem ipsum, bla bla bla, estc, que blablablabla .',
                                      200000,
                                      2,
                                      context),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Resumen',
                              style: Style.cardTitle,
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Items', style: Style.cartResumeItem),
                                Text('\$ 600000', style: Style.cartResumeItem),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Descuento', style: Style.cartResumeItem),
                                Text('\$ 0', style: Style.cartResumeItem),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(height: 3),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total', style: Style.cartResumeItem),
                                Text('\$ 600000', style: Style.cartResumeItem),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: null,
                                    child: Image.asset('images/nequi.png',
                                        height: 30)),
                                GestureDetector(
                                    onTap: null,
                                    child: Image.asset('images/pse.png',
                                        height: 30)),
                                GestureDetector(
                                    onTap: null,
                                    child: Image.asset('images/paypal.png',
                                        height: 30)),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget item(String img, String title, String text, int price, int id,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              img,
              width: 150,
              height: 150,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) =>
                  Image.asset(
                'images/$img.png',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Style.cartItemTitle),
                  SizedBox(height: 10),
                  Text(text, style: Style.cartItemText),
                ],
              ),
            ),
          ),
          Text('\$ $price', style: Style.cartItemPrice),
          IconButton(
              onPressed: () {
                setState(() {
                  products.removeAt(id);
                });
              },
              icon: Icon(
                Icons.delete_outline,
                color: Palette.mainColor,
                size: 34,
              )),
        ],
      ),
    );
  }
}
