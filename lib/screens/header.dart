import 'package:ecommerce/models/providers/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:ecommerce/services/handlers/authHandler.dart';

import 'package:ecommerce/util/alerts.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:provider/src/provider.dart';

class Header extends StatefulWidget {
  final AuthHandler authHandler = AuthHandler();
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late String email, password;

  Future<dynamic> _login(BuildContext context) async {
    final response =
        await this.widget.authHandler.login(this.email, this.password);
    if (!response) {
      return modal(
        context,
        title: 'Error',
        content: Text('Nombre de usuario y/o contraseña incorrectos'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
          )
        ],
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int productList = context.watch<ProductCart>().products.length;
    return Container(
      color: Palette.mainColor,
      height: 100,
      child: Row(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45),
              child: Image.asset(
                'images/logo.png',
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: TextField(
                          style:
                              TextStyle(color: Color(0xFF9A9A9A), fontSize: 14),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            filled: true,
                            fillColor: Colors.white,
                            hintText:
                                'Palabras clave, # de modelo, # de producto',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Tienda Online', style: Style.labelSearch),
                          Text('Contáctanos', style: Style.labelSearch),
                          Text('Sobre nosotros', style: Style.labelSearch),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.supervised_user_circle,
                              size: 40,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bienvenido',
                                    style: TextStyle(color: Color(0xFFC2C2C2)),
                                  ),
                                  Row(
                                    children: [
                                      FutureBuilder(
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text('Bienvenido Usuario');
                                          } else {
                                            if (snapshot.hasError) {
                                              return Text(
                                                'Error',
                                                style: TextStyle(
                                                  color: Color(0xFFC2C2C2),
                                                ),
                                              );
                                            }
                                            return TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () => modal(
                                                context,
                                                title: 'Bienvenido',
                                                content: SizedBox(
                                                  height: 150,
                                                  width: 100,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextField(
                                                          decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  'Correo Electronico'),
                                                          onChanged: (email) {
                                                            this.email = email;
                                                          }),
                                                      TextField(
                                                        obscureText: true,
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Contraseña'),
                                                        onChanged: (password) {
                                                          this.password =
                                                              password;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      return await _login(
                                                          context);
                                                    },
                                                    child: Text(
                                                      'Iniciar Sesión',
                                                      style: Style.labelSearch,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              child: Text('Iniciar sesión',
                                                  style: Style.labelSearch),
                                            );
                                          }
                                        },
                                      ),
                                      Text('/', style: Style.labelSearch),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/register'),
                                        child: Text('Registrarse',
                                            style: Style.labelSearch),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                FontAwesomeIcons.twitter,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/'),
                                icon: Icon(Icons.house_outlined),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 65),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/cart'),
                              ),
                              productList > 0
                                  ? Container(
                                      height: 18,
                                      width: 20,
                                      margin: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          productList.toString(),
                                          style: Style.labelSearch,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          Icon(
                            Icons.flag_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
