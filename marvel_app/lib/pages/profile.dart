
import 'package:flutter/material.dart';
import 'package:marvel_app/Model/user_model.dart';
import 'package:marvel_app/helper/colors.dart';
import 'package:marvel_app/proveder/auth_provider.dart';
import 'package:marvel_app/widgets/butten.dart';
import 'package:marvel_app/widgets/text_filed.dart';

import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  List genders = ['male', 'female', 'others'];
  bool edit = false;

  @override
  void initState() {
    Provider.of<AuthentProvider>(context, listen: false)
        .getUser()
        .then((onValue) {
      _nameController.text = onValue.name;
      _phoneController.text = onValue.phone;
      _dobController.text = onValue.dob.toString().substring(0, 10);
      _genderController.text = onValue.gender;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthentProvider>(builder: (context, authConsumer, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    Image.network(
                      authConsumer.userModel!.avatarUrl,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextForm(
                          enabled: edit,
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
                        TextForm(
                            enabled: edit,
                            controller: _phoneController,
                            labelText: "Phone"),
                        SizedBox(
                          height: 26,
                        ),
                        PopupMenuButton(
                          enabled: edit,
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
                            if (edit)
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((value) {
                                if (value != null) {
                                  _dobController.text =
                                      value.toString().split(' ')[0];
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
                        SizedBox(
                          height: 53,
                        ),
                        Mainbutton(
                            text: edit ? "cancel" : "Edit",
                            onPressed: () {
                              setState(() {
                                edit = !edit;
                              });
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        if (edit)
                          Mainbutton(
                              text: "Save",
                              btncolor: Colors.white,
                              txtcolor: redColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<AuthentProvider>(context,
                                          listen: false)
                                      .updateProfile(
                                    UserModel(
                                      id: authConsumer.userModel!.id,
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      serverId:
                                          authConsumer.userModel!.serverId,
                                      dob: DateTime.parse(_dobController.text),
                                      gender: _genderController.text,
                                      avatarUrl: authConsumer
                                          .userModel!.avatarUrl
                                          .toString(),
                                      createdAt:
                                          authConsumer.userModel!.createdAt,
                                      updatedAt:
                                          authConsumer.userModel!.updatedAt,
                                    ),
                                  )
                                      .then((value) {
                                    if (value.first) {
                                      setState(() {
                                        edit = false;
                                      });
                                    } else {
                                      print("Update failed");
                                    }
                                  });
                                }
                              }),
                        SizedBox(
                          height: 25,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}