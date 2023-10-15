import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frist_project/pets/presentation/pages/page_controller.dart';
import 'package:frist_project/pets/presentation/pages/pets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../pets/data/pets_local_datasource/pets_local_datasource.dart';
import '../../data/models/user_data.dart';
import '../../data/user_local_datasource/user_local_datasource.dart';
import '../bloc/user_bloc.dart';

class FormPage extends StatefulWidget {
  FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var formKey = GlobalKey<FormState>();

  var name = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();

  late String data;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(HasSignedUp());
    checkUserSignedUp();
  }

  Future<void> checkUserSignedUp() async {
    bool hasSignedUp = await UserLocalDataImpl().hasSignedUP();
    if (hasSignedUp) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ControllerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserUnauthorized) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double width = constraints.maxWidth;
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              TextFormField(
                                controller: name,
                                style: const TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  labelText: 'name',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'name must be entered';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: email,
                                style: const TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'email must  be entered';
                                  } else if (value.length < 5 ||
                                      value.startsWith('@') ||
                                      !value.contains("@") ||
                                      !value.endsWith('.com')) {
                                    return 'please enter the email correct';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                controller: password,
                                style: const TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password must be entered';
                                  }
                                  if (value.length < 8) {
                                    return 'password length can not be less than 8';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              SizedBox(
                                width: width / 2,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      UserData userData = UserData(
                                          name: name.text,
                                          email: email.text,
                                          password: password.text);
                                      context
                                          .read<UserBloc>()
                                          .add(SetUserData(userData: userData));
                                      // context.read<UserBloc>().add(HasSignedUp());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple),
                                  child: const Text(
                                    'login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
        listener: (BuildContext context, UserState state) {
          if (state is UserAuthorizedState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ControllerPage()));
          }
        },
      ),
    );
  }
}