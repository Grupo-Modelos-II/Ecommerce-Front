import 'generic.dart';

class IdentifierTypeRequest {
  String name;
  IdentifierTypeRequest({required this.name});
}

class IdentifierTypeResponse extends Generic {
  late String id;
  late String name;
  IdentifierTypeResponse({required this.id, required this.name});
  IdentifierTypeResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
