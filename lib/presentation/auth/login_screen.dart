import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fund_watchlist/bloc/login/auth_bloc.dart';
import 'package:fund_watchlist/locator.dart';
import 'package:fund_watchlist/services/navigation_service.dart';
import 'package:fund_watchlist/theme/app_colors.dart';
import 'package:fund_watchlist/utils/media_query.dart';
import 'package:fund_watchlist/utils/route_names.dart';

import 'components/custom_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = {
    "user_name": "",
    "password": "",
  };
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 50.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              Fluttertoast.showToast(msg: state.message);
            } else if (state is Authenticated) {
              Fluttertoast.showToast(msg: 'Login successful');
              locator<NavigationService>().replaceTo(RouteNames.home);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: CommonMediaQuery.screenHeight / 7,
                  ),
                  Image.asset('assets/icons/app_icon.png'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Login to your account',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  CustomTextFormField(
                    label: 'User Name',
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
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your Password';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Forgot Password?'),
                      )
                    ],
                  ),
                  Spacer(),
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
                            context.read<AuthBloc>().add(SignInRequested(
                                  form['user_name']!,
                                  form['password']!,
                                ));
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, event) {
                            if (state is AuthLoading) {
                              return const CupertinoActivityIndicator(
                                  color: Colors.white);
                            }
                            return const Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            );
                          },
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            locator<NavigationService>()
                                .navigateTo(RouteNames.signUp);
                          },
                          child: Text('Sign up'))
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
