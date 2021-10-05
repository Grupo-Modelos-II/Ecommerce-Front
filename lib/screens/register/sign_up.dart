import 'package:ecommerce/models/client.dart';
import 'package:ecommerce/util/alerts.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/services/handlers/clientsHandler.dart';

import 'package:ecommerce/models/identifier_type.dart';
import 'package:ecommerce/services/handlers/identifierTypeHandler.dart';
import '../header.dart';

class SignUp extends StatefulWidget {
  final IdentifierTypeHandler identifierTypeHandler = IdentifierTypeHandler();
  final ClientHandler clientHandler = ClientHandler();
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  late String idIdentifierType;
  String identifier = "",
      name = "",
      email = "",
      location = "",
      password = "",
      passwordVerification = "";
  Future<List<IdentifierTypeResponse>> getIdentifierTypes() async {
    final List<IdentifierTypeResponse> identifierTypes =
        await widget.identifierTypeHandler.getAllTypes();
    idIdentifierType = identifierTypes.first.id;
    return identifierTypes;
  }

  Future<dynamic> registerUser(BuildContext context) async {
    late final String title, content;
    if (password == passwordVerification) {
      final ClientRequest clientRequest = ClientRequest(
        identifier: identifier,
        name: name,
        email: email,
        location: location,
        password: password,
        idIdentifierType: idIdentifierType,
        credits: 0,
      );
      final bool isUserCreated =
          await widget.clientHandler.register(clientRequest);
      if (isUserCreated) {
        Navigator.pushNamed(context, '/');
      } else {
        title = "No pudimos registrarte";
        content = "Por favor intenta de nuevo";
      }
    } else {
      title = "Las contraseñas no coinciden";
      content = "Port favor verifica que las contraseñas coincidan";
    }
    return modal(
      context,
      title: title,
      content: Text(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Header(),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Registro",
                      style: TextStyle(color: Colors.blue, fontSize: 50),
                      textAlign: TextAlign.left,
                    ),
                    FutureBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<List<IdentifierTypeResponse>>
                              snapshot) {
                        if (snapshot.hasData) {
                          final List<IdentifierTypeResponse>? identifierTypes =
                              snapshot.data;
                          return DropdownButton<String>(
                            value: idIdentifierType,
                            onChanged: (String? newValue) {
                              setState(() {
                                idIdentifierType = newValue ?? "";
                              });
                            },
                            items: identifierTypes!
                                .map((IdentifierTypeResponse identifierType) {
                              return DropdownMenuItem<String>(
                                value: identifierType.id,
                                child: Text(identifierType.name),
                                key: Key(identifierType.id),
                              );
                            }).toList(),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      future: getIdentifierTypes(),
                    ),
                    TextField(
                      onChanged: (String? newValue) {
                        setState(() {
                          identifier = newValue ?? "";
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Identificador",
                      ),
                    ),
                    TextField(
                      onChanged: (String? newValue) {
                        setState(() {
                          name = newValue ?? "";
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Nombre",
                      ),
                    ),
                    TextField(
                      onChanged: (String? newValue) {
                        setState(() {
                          email = newValue ?? "";
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Correo Electronico",
                      ),
                    ),
                    TextField(
                      onChanged: (String? newValue) {
                        setState(() {
                          password = newValue ?? "";
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                      ),
                    ),
                    TextField(
                      onChanged: (String? newValue) {
                        setState(() {
                          passwordVerification = newValue ?? "";
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirmar Contraseña",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => registerUser(context),
                      child: Text("Registrarse"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
