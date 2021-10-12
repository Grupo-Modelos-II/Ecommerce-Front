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
  final _formKey = GlobalKey<FormState>();
  Future<List<IdentifierTypeResponse>> getIdentifierTypes() async {
    final List<IdentifierTypeResponse> identifierTypes =
        await widget.identifierTypeHandler.getAllTypes();
    idIdentifierType = identifierTypes.first.id;
    return identifierTypes;
  }

  Future<dynamic> registerUser(BuildContext context) async {
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
      return modal(
        context,
        title: 'No pudimos registrarte',
        content: Text('Por favor intenta de nuevo'),
      );
    }
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
                child: Form(
                  key: _formKey,
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
                            final List<IdentifierTypeResponse>?
                                identifierTypes = snapshot.data;
                            return DropdownButton<String>(
                              value: idIdentifierType,
                              onChanged: (String? value) {
                                if (value != null || value!.isNotEmpty) {
                                  idIdentifierType = value;
                                }
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
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            identifier = value;
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Identificador",
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            name = value;
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Nombre",
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            email = value;
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Correo Electronico",
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            location = value;
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Ubicacion",
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            password = value;
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                        ),
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor ingresa un valor";
                          } else {
                            passwordVerification = value;
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirmar Contraseña",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String verification;
                          if (_formKey.currentState!.validate()) {
                            if (password == passwordVerification) {
                              verification = 'Procesando la informacion';
                              registerUser(context);
                            } else {
                              verification = 'Las contraseñas no coinciden';
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(verification),
                              ),
                            );
                          }
                        },
                        child: Text("Registrarse"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
