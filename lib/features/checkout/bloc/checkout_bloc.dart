import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pfe/features/cart/bloc/cart_bloc.dart';
import 'package:pfe/features/cart/cart_model.dart';
import 'package:pfe/features/checkout/checkout_model.dart';
import 'package:pfe/features/checkout/checkout_repository.dart';
import 'package:pfe/features/home/models/serveur_model.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  products: (cartBloc.state as CartLoaded).cart.serveurs,
                  total: (cartBloc.state as CartLoaded).cart.subtotal,
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          add(
            UpdateCheckout(cart: state.cart),
          );
        }
      },
    );
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          numcard: event.numcard ?? state.numcard,
          cardHolder: event.cardHolder ?? state.cardHolder,
          ExpDate: event.ExpDate ?? state.ExpDate,
          zipCode: event.zipCode ?? state.zipCode,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  void _onUpdatePaymentMethod(
    UpdatePaymentMethod event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      emit(
        (state as CheckoutLoaded).copyWith(paymentMethod: event.paymentMethod),
      );
    }
  }

  void _onUpdateCardNumber(
    UpdateCardNumber event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      emit(
        (state as CheckoutLoaded).copyWith(numcard: event.cardNumber),
      );
    }
  }

  void _onUpdateZipCode(
    UpdateZipCode event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      emit(
        (state as CheckoutLoaded).copyWith(zipCode: event.zipCode),
      );
    }
  }

  void _onUpdateExpirationDate(
    UpdateExpirationDate event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      emit(
        (state as CheckoutLoaded).copyWith(ExpDate: event.expirationDate),
      );
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
