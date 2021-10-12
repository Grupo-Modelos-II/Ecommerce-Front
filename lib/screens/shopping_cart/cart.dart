import 'package:ecommerce/models/providers/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:provider/src/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final List<ProductAtCart> products =
        context.watch<ProductAtCart>().products;
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
                                      Colors.transparent),
                                ),
                                onPressed:
                                    context.read<ProductCart>().clearProducts,
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
                                children: products
                                    .map(
                                      (ProductResponse product) => Item(
                                        product: product,
                                        key: Key(product.id),
                                      ),
                                    )
                                    .toList(),
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
}

class Item extends StatelessWidget {
  final ProductAtCart product;
  Item({required this.product, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              product.mainImage,
              width: 150,
              height: 150,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) =>
                  Image.asset(
                'images/objeto.png',
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
                  Text(product.name, style: Style.cartItemTitle),
                  SizedBox(height: 10),
                  Text(product.description, style: Style.cartItemText),
                  Text('Cantidad: ${product.amount}', style: Style.cartItemText)
                ],
              ),
            ),
          ),
          Text('\$ ${product.cost}', style: Style.cartItemPrice),
          IconButton(
            onPressed: () {
              context.read<ProductCart>().removeProduct(product);
            },
            icon: Icon(
              Icons.delete_outline,
              color: Palette.mainColor,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
