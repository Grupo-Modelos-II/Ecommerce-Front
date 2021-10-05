import 'package:ecommerce/constants/colors.dart';
import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/screens/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/constants.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
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
                                children: [
                                  secondaryImage('objeto', context),
                                  secondaryImage('objeto', context),
                                  secondaryImage('objeto', context),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            ClipRRect(
                              child: Image.asset(
                                'images/objeto.png',
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.fill,
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
                                Text('Teclado Gamer',
                                    style: Style.productInfoTitle),
                                SizedBox(height: 30),
                                Text('\$ 200000',
                                    style: Style.productInfoPrice),
                                SizedBox(height: 30),
                                Text(
                                  'Descripción del producto, bla abla l lorem ipsum, bla bla bla, estc, que blablablabla.',
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
                                  onPressed: null,
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
                                  onPressed: null,
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
    child: Image.asset('images/$img.png',
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.width * 0.13,
        fit: BoxFit.fill),
  );
}
