import 'generic.dart';

class CategoryRequest {
  final String name;

  CategoryRequest({required this.name});
}

class CategoryResponse extends Generic {
  late final String id;
  late final String name;

  CategoryResponse({required this.id, required this.name});
  CategoryResponse.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];
}
