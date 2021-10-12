import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/footer.dart';
import 'package:ecommerce/services/handlers/productsHandler.dart';
import 'package:ecommerce/util/logger.dart';
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
              final List<ProductResponse> products = snapshot.data ?? [];
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
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: ((products.length % 4) + 1) * 500,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: GridView.count(
                                      crossAxisCount: 4,
                                      children: products
                                          .map(
                                            (ProductResponse product) =>
                                                ProductCard(
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
                        ],
                      ),
                    ),
                  ),
                  Footer(),
                ],
              );
            } else {
              if (snapshot.hasError) {
                LoggerUtil.logger.e(snapshot.error);
                return Center(
                  child: Text('Error al cargar los productos'),
                );
              }
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

class ProductCard extends StatelessWidget {
  final ProductResponse product;

  ProductCard({required this.product, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool status = product.amount > 0;
    return TextButton(
      onPressed: () =>
          Navigator.pushNamed(context, '/product', arguments: product),
      child: Card(
        key: key,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.mainImage,
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                  errorBuilder:
                      (BuildContext context, Object exception, StackTrace? _) =>
                          Image.asset(
                    'images/notfound.png',
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                '\$ ${product.cost}',
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
                product.name,
                style: Style.productPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
