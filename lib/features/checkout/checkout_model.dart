import 'package:equatable/equatable.dart';
import 'package:pfe/features/home/models/serveur_model.dart';

class Checkout extends Equatable {
  final String? numcard;
  final String? cardHolder;
  final String? zipCode;
  final String? ExpDate;
  final List<Serveur>? products;
  final double? total;

  const Checkout(
      {required this.numcard,
      required this.cardHolder,
      required this.zipCode,
      required this.ExpDate,
      required this.products,
      required this.total});

  @override
  List<Object?> get props =>
      [numcard, cardHolder, zipCode, ExpDate, products, total];

  Map<String, Object> toDocument() {
    Map customerAddress = {};
    customerAddress['numcard'] = numcard;
    customerAddress['cardHolder'] = cardHolder;
    customerAddress['zipCode'] = zipCode;
    customerAddress['ExpDate'] = ExpDate;

    return {
      'customernumcard': numcard!,
      'customercardHolder': cardHolder!,
      'customerzipCode': zipCode!,
      'customerExpDate': ExpDate!,
      'products': products!.map((product) => product.name).toList(),
      'total': total!
    };
  }
}
