import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_app/helper/colors.dart';
import 'package:marvel_app/pages/login_page.dart';
import 'package:marvel_app/proveder/auth_provider.dart';
import 'package:marvel_app/widgets/butten.dart';
import 'package:marvel_app/widgets/text_click.dart';
import 'package:marvel_app/widgets/text_filed.dart';

import 'package:provider/provider.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  List genders = ['male', 'female', 'Gay'];
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: redColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextForm(
                    controller: _nameController,
                    labelText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextForm(controller: _phoneController, labelText: "Phone"),
                  SizedBox(
                    height: 26,
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return List<PopupMenuItem>.from(
                          genders.map((e) => PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    _genderController.text = e;
                                  });
                                },
                                child: Text(e),
                              ))).toList();
                    },
                    child: TextForm(
                      controller: _genderController,
                      labelText: "gender",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                      enabled: false,
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          _dobController.text = value.toString().split(' ')[0];
                        }
                      });
                    },
                    child: TextForm(
                      enabled: false,
                      controller: _dobController,
                      labelText: "Date of Birth",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextForm(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    controller: _passwordController,
                    labelText: "Password",
                    obscure: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextForm(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    controller: _confirmPasswordController,
                    labelText: "Confirm Password",
                    obscure: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      if (_passwordController.text != value) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 53,
                  ),
                   Mainbutton(
                      text: "Sign up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<AuthentProvider>(context, listen: false)
                              .register({
                            'name': _nameController.text,
                            'phone': _phoneController.text,
                            'gender': _genderController.text,
                            'DOB': _dobController.text,
                            'password': _passwordController.text,
                          }).then((onValue) {
                            if (onValue.first) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInPage()));
                            } else {
                               Timer(const Duration(milliseconds: 50), () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(onValue.last)));
                               }
                               
                              );
                            }
                          });
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextClickable(
                      text: "Already have an account",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInPage()));
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}