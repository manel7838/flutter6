part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCheckout extends CheckoutEvent {
  final String? numcard;
  final String? cardHolder;
  final String? ExpDate;
  final Cart? cart;
  final String? zipCode;

  const UpdateCheckout(
      {this.numcard, this.cardHolder, this.ExpDate, this.zipCode, this.cart});

  @override
  List<Object?> get props => [numcard, cardHolder, ExpDate, zipCode, cart];
}

class ConfirmCheckout extends CheckoutEvent {
  final Checkout checkout;

  const ConfirmCheckout({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}

class UpdatePaymentMethod extends CheckoutEvent {
  final String? paymentMethod;

  UpdatePaymentMethod({this.paymentMethod});

  @override
  List<Object?> get props => [paymentMethod];
}

class UpdateCardNumber extends CheckoutEvent {
  final String? cardNumber;

  UpdateCardNumber({this.cardNumber});

  @override
  List<Object?> get props => [cardNumber];
}

class UpdateZipCode extends CheckoutEvent {
  final String? zipCode;

  UpdateZipCode({this.zipCode});

  @override
  List<Object?> get props => [zipCode];
}

class UpdateExpirationDate extends CheckoutEvent {
  final String? expirationDate;

  UpdateExpirationDate({this.expirationDate});

  @override
  List<Object?> get props => [expirationDate];
}
