import 'package:flutter/material.dart';
import 'package:marvel_app/helper/colors.dart';
import 'package:marvel_app/pages/home_page.dart';
import 'package:marvel_app/pages/sing_up.dart';
import 'package:marvel_app/proveder/auth_provider.dart';
import 'package:marvel_app/widgets/butten.dart';
import 'package:marvel_app/widgets/text_click.dart';
import 'package:marvel_app/widgets/text_filed.dart';

import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      'Login page',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: redColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                 Image.asset("assets/marvelLogo.png",width: 60,),
                    const SizedBox(height: 40),
                    TextForm(
                        controller: _phoneController,
                        labelText: "Phone",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Phone number must be at least 10 characters';
                          }
                          return null;
                        }),
                    const SizedBox(height: 29),
                    TextForm(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                      controller: _passwordController,
                      labelText: "Password",
                      obscure: _obscureText,
                    ),
                    const SizedBox(height: 10),
                    
                    const SizedBox(height: 25),
                     Mainbutton(
                        text: 'Sign in',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<AuthentProvider>(context, listen: false)
                                .login({
                              'phone': _phoneController.text,
                              'password': _passwordController.text
                            }).then((value) {
                              if (value[0]) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(value[1]['message'])));
                              }
                            });
                          }
                        }),
                    const SizedBox(height: 40),
                    TextClickable(
                        text: 'Create new account',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPages()));
                        }),
                    const SizedBox(height: 30),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}