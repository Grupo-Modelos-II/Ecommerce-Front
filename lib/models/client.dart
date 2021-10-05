import 'generic.dart';
import 'identifier_type.dart';

class ClientRequest {
  String idIdentifierType;
  String identifier;
  String name;
  String email;
  String password;
  String location;
  int credits;

  ClientRequest({
    required this.idIdentifierType,
    required this.identifier,
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.credits,
  });

  Map<String, dynamic> toDict(){
    return {
      ' 'id':self.id,
            'id_identifier_type':self.id_identifier_type,
            'identifier':self.identifier,
            'name':self.name,
            'email':self.email,
            'password':self.password,
            'location':self.location,
            'credits':self.credits,
            'identifier_type':self.identifier_type,
            'transactions':self.transactions
    };
  }
}

class ClientResponse extends Generic {
  late final String id;
  late final IdentifierTypeResponse id_identifier_type;
  late final String name;
  late final String email;
  late final String password;
  late final String location;
  late final int credits;

  ClientResponse({
    required this.id,
    required this.id_identifier_type,
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.credits,
  });

  ClientResponse.fromJson(dynamic json) {
    id = json['id'];
    id_identifier_type =
        IdentifierTypeResponse.fromJson(json['id_identifier_type']);
    name = json['name'];
    email = json['email'];
    password = json['password'];
    location = json['location'];
    credits = json['credits'];
  }
}
