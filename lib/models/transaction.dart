import 'generic.dart';
import 'client.dart';
import 'purchased.dart';

class TransactionRequest {
  String idClient;
  int total;
  TransactionRequest({required this.idClient, required this.total});
}

class TransactionResponse extends Generic {
  late final String id;
  late final ClientResponse client;
  late final List<PurchasedResponse> purchases;
  late final DateTime date;
  late final int total;

  TransactionResponse({
    required this.id,
    required this.client,
    required this.purchases,
    required this.date,
    required this.total,
  });
  TransactionResponse.fromJson(dynamic json) {
    id = json['id'];
    client = ClientResponse.fromJson(json['client']);
    purchases = List<PurchasedResponse>.from(
      json['purchases'].map((x) => PurchasedResponse.fromJson(x)),
    );
    date = json['date'];
    total = json['total'];
  }
}
