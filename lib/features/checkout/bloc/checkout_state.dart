part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];

  get paymentMethod => null;
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final String? numcard;
  final String? cardHolder;
  final String? zipCode;
  final String? ExpDate;
  final String? paymentMethod; // Nouvelle propriété
  final TextInputType? keyboardType; // Nouvelle propriété
  final TextInputType? inputType; // Nouvelle propriété

  final List<Serveur>? products;
  final double? total;
  final Checkout checkout;

  CheckoutLoaded({
    this.numcard,
    this.cardHolder,
    this.ExpDate,
    this.zipCode,
    this.paymentMethod,
    this.keyboardType,
    this.inputType,
    this.products,
    this.total,
  }) : checkout = Checkout(
          ExpDate: ExpDate,
          numcard: numcard,
          cardHolder: cardHolder,
          zipCode: zipCode,
          products: products,
          total: total,
        );

  CheckoutLoaded copyWith({
    String? numcard,
    String? cardHolder,
    String? zipCode,
    String? ExpDate,
    String? paymentMethod,
    TextInputType? keyboardType,
    TextInputType? inputType,
    List<Serveur>? products,
    double? total,
  }) {
    return CheckoutLoaded(
      numcard: numcard ?? this.numcard,
      cardHolder: cardHolder ?? this.cardHolder,
      ExpDate: ExpDate ?? this.ExpDate,
      zipCode: zipCode ?? this.zipCode,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      keyboardType: keyboardType ?? this.keyboardType,
      inputType: inputType ?? this.inputType,
      products: products ?? this.products,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [
        ExpDate,
        numcard,
        cardHolder,
        zipCode,
        paymentMethod,
        keyboardType,
        inputType,
        products,
        total,
        checkout,
      ];
}
