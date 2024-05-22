import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pfe/features/checkout/bloc/checkout_bloc.dart';
import 'package:pfe/features/checkout/checkout_screen.dart';
import 'package:pfe/features/signup/signup_screen.dart';
import 'package:pfe/translations/locale_keys.g.dart';
import 'package:pfe/widget/custom_text_from_field.dart';

class CheckoutcheckScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  const CheckoutcheckScreen({Key? key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutcheckScreen(),
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
                    "CHECK",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    title: 'Check Number',
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
                          title: 'bank name',
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context
                                .read<CheckoutBloc>()
                                .add(UpdateZipCode(zipCode: value));
                          },
                          inputType: TextInputType.number,
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
                                      const CheckoutScreen()));
                        },
                        child: const Text("Or pay with Master card or visa",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 21, 18, 176)))),
                  ]),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
