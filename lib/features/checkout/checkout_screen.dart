import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfe/features/checkout/bloc/checkout_bloc.dart';
import 'package:pfe/features/checkout/checkout_check.dart';

import 'package:pfe/translations/locale_keys.g.dart';
import 'package:pfe/widget/custom_text_from_field.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 38, 229),
        title: Text(
          LocaleKeys.checkout.tr(),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    LocaleKeys.payment_information.tr(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Payment Method',
                      border: OutlineInputBorder(),
                    ),
                    value: state.paymentMethod,
                    items: ['MasterCard', 'Visa']
                        .map((method) => DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            ))
                        .toList(),
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdatePaymentMethod(paymentMethod: value));
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: 'Card Number',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCardNumber(cardNumber: value));
                    },
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          title: 'CVC Code',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context
                                .read<CheckoutBloc>()
                                .add(UpdateZipCode(zipCode: value));
                          },
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          title: 'Expiration Date',
                          keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            context.read<CheckoutBloc>().add(
                                UpdateExpirationDate(expirationDate: value));
                          },
                          inputType: TextInputType.datetime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add logic for payment
                      },
                      child: const Text('Pay', style: TextStyle(fontSize: 18)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckoutcheckScreen()));
                        },
                        child: const Text("Or pay with check?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 21, 18, 176)))),
                  ]),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/lllll.jpg",
                          height: 200,
                          width: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/219_visa.jpg",
                          height: 200,
                          width: 150,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
