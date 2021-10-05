import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/services/handlers/productsHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/constants.dart';

import '../header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductHandler _productHandler = ProductHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          builder: (BuildContext context,
              AsyncSnapshot<List<ProductResponse>> snapshot) {
            if (snapshot.hasData) {
              final List<ProductResponse>? products = snapshot.data;
              return Column(
                children: [
                  Header(),
                  Container(
                    color: Color(0xFFF8F8F8),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          bannerView(),
                          SizedBox(height: 20),
                          Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 20.0),
                                  child: Text(
                                    'Productos destacados',
                                    style: Style.cardTitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: products!
                                        .map(
                                          (ProductResponse product) =>
                                              productCard(
                                            'logo',
                                            product.cost,
                                            true,
                                            product.name,
                                            context,
                                            key: Key(product.id),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 20.0),
                                  child: Text(
                                    'Ofertas',
                                    style: Style.cardTitle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: products!
                                        .map(
                                          (ProductResponse product) =>
                                              productCard(
                                            'logo',
                                            product.cost,
                                            true,
                                            product.name,
                                            context,
                                            key: Key(product.id),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Palette.mainColor)),
                              onPressed: null,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ver Catálogo Completo',
                                  style: Style.btnText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Footer(),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: _productHandler.getAllProducts(),
        ),
      ),
    );
  }
}

Widget bannerView() {
  return Container(
    child: Image.asset('images/banner01.png'),
  );
}

Widget productCard(
    String img, int price, bool status, String name, BuildContext context,
    {Key? key}) {
  return TextButton(
    onPressed: () => null,
    child: Card(
      key: key,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'images/$img.png',
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '\$ $price',
              style: Style.productPrice,
            ),
            SizedBox(height: 5),
            Text(
              status ? 'Disponible' : 'Agotado',
              style: Style.productStatus
                  .copyWith(color: status ? Colors.green : Colors.red),
            ),
            SizedBox(height: 5),
            Text(
              name,
              style: Style.productPrice,
            ),
          ],
        ),
      ),
    ),
  );
}
