import 'dart:convert' show json;
import 'package:ecommerce/models/providers/ProductList.dart';
import 'package:ecommerce/services/handlers/authHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce/services/handlers/transactionHandler.dart';
import 'package:ecommerce/services/handlers/purchaseHandler.dart';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/transaction.dart';
import 'package:ecommerce/models/purchased.dart';

import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:ecommerce/util/alerts.dart';
import 'package:ecommerce/util/logger.dart';
import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/constants/constants.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductScreen> {
  late ProductResponse product;
  TransactionHandler transactionHandler = TransactionHandler();
  PurchaseHandler purchaseHandler = PurchaseHandler();
  AuthHandler authHandler = AuthHandler();

  Future<dynamic> purchaseProduct(BuildContext context) async {
    String? message;
    try {
      final String token = await authHandler.getToken();
      if (token.isNotEmpty) {
        final Map<String, dynamic> claims = await authHandler.getTokenClaims();
        TransactionRequest request =
            TransactionRequest(idClient: claims['id_client'], total: 0);
        TransactionResponse trasactionCreated =
            await transactionHandler.createTransaction(request);

        PurchasedRequest requestDataPurchase = PurchasedRequest(
          idTransaction: trasactionCreated.id,
          idProduct: product.id,
          amount: 1,
          cost: product.cost,
        );

        bool isPurchasedCreated =
            await purchaseHandler.createPurchase(requestDataPurchase);
        if (isPurchasedCreated) {
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
    product = ModalRoute.of(context)!.settings.arguments as ProductResponse;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: product.images
                                    .map((image) =>
                                        secondaryImage(image, context))
                                    .toList(),
                              ),
                            ),
                            SizedBox(width: 15),
                            ClipRRect(
                              child: Image.network(
                                product.mainImage,
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) =>
                                    Image.asset(
                                  'images/notfound.png',
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name,
                                    style: Style.productInfoTitle),
                                SizedBox(height: 30),
                                Text('\$ ${product.cost}',
                                    style: Style.productInfoPrice),
                                SizedBox(height: 30),
                                Text(
                                  product.description,
                                  style: Style.productInfoText,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Palette.mainColor)),
                                  onPressed: () async =>
                                      await purchaseProduct(context),
                                  child: Text('Comprar ahora',
                                      style: Style.btnPurchase),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFFBFD9F6))),
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<ProductCart>()
                                          .addProduct(product);
                                    });
                                  },
                                  child: Text('Agregar al carrito',
                                      style: Style.btnCart),
                                ),
                              ),
                            ],
                          )
                        ],
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

Widget secondaryImage(String img, BuildContext context) {
  return ClipRRect(
    child: Image.network(
      img,
      width: MediaQuery.of(context).size.width * 0.13,
      height: MediaQuery.of(context).size.width * 0.13,
      fit: BoxFit.fill,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) =>
              Image.asset(
        'images/notfound.png',
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.width * 0.13,
        fit: BoxFit.fill,
      ),
    ),
  );
}
