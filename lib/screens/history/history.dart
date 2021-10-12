import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/providers/ProductList.dart'
    show ProductAtCart, ProductCart;
import 'package:ecommerce/models/purchased.dart';
import 'package:ecommerce/models/transaction.dart';
import 'package:ecommerce/services/handlers/transactionHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:provider/src/provider.dart';

import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TransactionHandler transactionHandler = TransactionHandler();
  Future<List<TransactionResponse>> getTransactionsByClient() async {
    return await transactionHandler.getTransactionsByClient();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTransactionsByClient(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TransactionResponse>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<TransactionResponse> transactions = snapshot.data ?? [];
          List<PurchasedItem> products = [];
          for (TransactionResponse transaction in transactions) {
            for (PurchasedResponse purchased in transaction.purchases) {
              products.add(
                PurchasedItem(
                  transaction: transaction,
                  purchased: purchased,
                  product: purchased.product,
                ),
              );
            }
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Header(),
                  Container(
                    color: Color(0xFFf8f8f8),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Expanded(
                        child: Column(
                          children: [
                            Text('Historial de compras',
                                style: Style.cardTitle),
                            SizedBox(height: 15),
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: products.length > 0
                                    ? Column(
                                        children: products,
                                      )
                                    : Text("No tienes productos registrados"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Footer(),
                ],
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class PurchasedItem extends StatelessWidget {
  TransactionResponse transaction;
  PurchasedResponse purchased;
  ProductResponse product;

  PurchasedItem(
      {required this.transaction,
      required this.purchased,
      required this.product,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              product.mainImage,
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: Style.cartItemTitle),
                      SizedBox(height: 10),
                      Text(product.description, style: Style.cartItemText),
                      Text(purchased.amount.toString(),
                          style: Style.cartItemText)
                    ],
                  ),
                ),
                Text('\$ ${purchased.cost}', style: Style.cartItemPrice),
              ],
            ),
          ),
          Text('${transaction.client.location}', style: Style.cartItemPrice),
          SizedBox(width: 15),
          Text('${DateFormat('yyyy-MM-dd').format(transaction.date)}',
              style: Style.cartItemPrice),
        ],
      ),
    );
  }
}
