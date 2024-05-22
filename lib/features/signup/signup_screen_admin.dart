import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:pfe/features/cubits/signup/signup_cubit.dart';
import 'package:pfe/features/cubits/signupadmin/signupadmin_cubit.dart';
import 'package:pfe/features/services/storage_service.dart';
import 'package:pfe/widget/custom_buttom.dart';

class SignupAdminScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupAdminScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SignupAdminScreen(),
    );
  }

  @override
  State<SignupAdminScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupAdminScreen> {
  StorageRepository storage = StorageRepository();

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 38, 229),
      ),
      // bottomNavigationBar: CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SignupAdminCubit, SignupAdminState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: _buildInputDecoration("Email", Icons.email),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignupAdminCubit>().userChanged(
                              state.admin!.copyWith(email: value),
                            );
                      },
                    ),

                    // _PasswordInput(),
                    const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (password) {
                        context
                            .read<SignupAdminCubit>()
                            .passwordChanged(password);
                      },
                      decoration: _buildInputDecoration(
                          "Password", Icons.password_rounded),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    //

                    CustomButton(
                      title: "Admin Signup",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<SignupAdminCubit>()
                              .signUpWithCredentials();
                        }
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color.fromARGB(255, 252, 255, 254),
        enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 124, 137, 136)),
            borderRadius: BorderRadius.circular(30.0)),
        filled: true,
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Colors.black,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)));
  }
}
