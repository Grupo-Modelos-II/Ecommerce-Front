import 'dart:convert' show json;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<dynamic> purchaseProduct(BuildContext context,ProductResponse requestData) async{
    try{
      LoggerUtil.logger.v(requestData);
      final SharedPreferences prefs = await this._prefs;
      LoggerUtil.logger.v(prefs.getString('token') ?? '');
      String idClient = json.decode(prefs.getString('token') ?? '')['id_client'];
      LoggerUtil.logger.d(idClient);
      TransactionRequest request = TransactionRequest(idClient:idClient, total: product.amount);
      TransactionResponse trasactionCreated = await transactionHandler.createTransaction(request);
      
      PurchasedRequest requestDataPurchase = PurchasedRequest(
        idTransaction: trasactionCreated.id,
        idProduct: requestData.id,
        amount: requestData.amount,
        cost: requestData.cost
      );

      bool isPurchasedCreated = await purchaseHandler.createPurchase(requestDataPurchase);
      if(isPurchasedCreated){
        Navigator.pushNamed(context,'/');
      }else{
        throw Exception();
      }

    }catch(e){
      LoggerUtil.logger.e(e.toString());
      return modal(
        context,
        title: 'Error',
        content: Text('Ha ocurrido un error durante la transacción'),
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
                                  onPressed: () async => await purchaseProduct(context,product),
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
                                  onPressed: (){

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
