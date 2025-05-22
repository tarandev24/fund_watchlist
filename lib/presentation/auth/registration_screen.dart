import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/bloc/login/auth_bloc.dart';
import 'package:fund_watchlist/locator.dart';
import 'package:fund_watchlist/presentation/auth/components/custom_text_feild.dart';
import 'package:fund_watchlist/services/navigation_service.dart';
import 'package:fund_watchlist/theme/app_colors.dart';
import 'package:fund_watchlist/utils/media_query.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fund_watchlist/utils/route_names.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Map<String, dynamic> form = {
    "user_name": "",
    "password": "",
    "data": {"fullName": ""},
    "mobileNumber": ""
  };
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              Fluttertoast.showToast(msg: 'Registration Unsuccessful');
            } else if (state is Authenticated) {
              Fluttertoast.showToast(msg: 'Login successful');
              locator<NavigationService>().replaceTo(RouteNames.home);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CommonMediaQuery.screenHeight / 8,
                  ),
                  Text(
                    'Create Account',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    label: 'Full Name',
                    prefixIcon: Icons.person_2,
                    initialValue: form['data']['fullName']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        form['data']['fullName'] = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Full Name";
                      }
                      final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                      if (!nameRegExp.hasMatch(value)) {
                        return "Only letters and spaces are allowed";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    label: 'Email Id',
                    prefixIcon: Icons.email,
                    initialValue: form['user_name']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        form['user_name'] = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email Id";
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    label: 'Password',
                    prefixIcon: Icons.lock,
                    initialValue: form['password']?.toString(),
                    obscureText: true,
                    showToggleVisibility: true,
                    isPasswordVisible: isPasswordVisible,
                    onToggleVisibility: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        form['password'] = value.trim();
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      final passwordRegex =
                          RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$');
                      if (!passwordRegex.hasMatch(value)) {
                        return "Password must contain 8+ characters, a capital letter, and a number.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                           if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SignUpRequested(
                              form['user_name']!,
                              form['password']!,
                              form['mobileNumber']!,
                              form['data']!));
                           }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, event) {
                            if (state is AuthLoading) {
                              return const CupertinoActivityIndicator(
                                  color: Colors.white);
                            }
                            return const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            );
                          },
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
