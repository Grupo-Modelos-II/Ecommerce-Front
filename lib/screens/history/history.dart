import 'package:ecommerce/models/providers/ProductList.dart';
import 'package:ecommerce/models/purchased.dart';
import 'package:ecommerce/models/transaction.dart';
import 'package:ecommerce/services/handlers/authHandler.dart';
import 'package:ecommerce/services/handlers/purchaseHandler.dart';
import 'package:ecommerce/services/handlers/transactionHandler.dart';
import 'package:ecommerce/util/alerts.dart';
import 'package:ecommerce/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:provider/src/provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  AuthHandler authHandler = AuthHandler();
  TransactionHandler transactionHandler = TransactionHandler();
  PurchaseHandler purchaseHandler = PurchaseHandler();
  Future<dynamic> generatePurchase(
      BuildContext context, List<ProductAtCart> products) async {
    String? message;
    try {
      final String token = await authHandler.getToken();
      if (token.isNotEmpty) {
        final Map<String, dynamic> claims = await authHandler.getTokenClaims();
        TransactionRequest request =
            TransactionRequest(idClient: claims['id_client'], total: 0);
        TransactionResponse trasactionCreated =
            await transactionHandler.createTransaction(request);

        bool isPurchased = true;
        products.forEach((ProductAtCart product) async {
          PurchasedRequest requestDataPurchase = PurchasedRequest(
              idTransaction: trasactionCreated.id,
              idProduct: product.product.id,
              amount: product.amount,
              cost: product.product.cost);
          isPurchased &=
              await purchaseHandler.createPurchase(requestDataPurchase);
        });
        if (isPurchased) {
          Navigator.pushNamed(context, '/');
        } else {
          throw Exception();
        }
      } else {
        message = "Debe iniciar sesion";
        throw Exception();
      }
    } catch (e) {
      LoggerUtil.logger.e(e);
      return modal(
        context,
        title: 'Error',
        content: Text(message ?? "No pudimos realizar la compra"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductAtCart> products = context.watch<ProductCart>().products;
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
                                children: products.length == 0
                                    ? [
                                        Text(
                                            'El carro de compra se encuentra vacio, que esperas para añadir productos?!')
                                      ]
                                    : products
                                        .map(
                                          (ProductAtCart product) => Item(
                                            product: product,
                                            key: Key(product.product.id),
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
                                Text(
                                    '\$ ${context.read<ProductCart>().getCostCart()}',
                                    style: Style.cartResumeItem),
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
                                Text(
                                    '\$ ${context.read<ProductCart>().getCostCart()}',
                                    style: Style.cartResumeItem),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async =>
                                      await generatePurchase(context, products),
                                  child: Image.asset('images/nequi.png',
                                      height: 30),
                                ),
                                GestureDetector(
                                  onTap: () async =>
                                      await generatePurchase(context, products),
                                  child:
                                      Image.asset('images/pse.png', height: 30),
                                ),
                                GestureDetector(
                                  onTap: () async =>
                                      await generatePurchase(context, products),
                                  child: Image.asset('images/paypal.png',
                                      height: 30),
                                ),
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
              product.product.mainImage,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) =>
                  Image.asset(
                'images/notfound.png',
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
                  Text(product.product.name, style: Style.cartItemTitle),
                  SizedBox(height: 10),
                  Text(product.product.description, style: Style.cartItemText),
                  Text('Cantidad: ${product.amount}', style: Style.cartItemText)
                ],
              ),
            ),
          ),
          Text('\$ ${product.product.cost}', style: Style.cartItemPrice),
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
