import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frist_project/data/data_source/data_source.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/data/data_source/user_local_datasource/user_local_datasource.dart';
import 'package:frist_project/data/models/user_data.dart';
import 'package:frist_project/presentation/pages/form_page.dart';
import 'package:frist_project/presentation/pages/page_pet_info.dart';
import 'package:frist_project/presentation/widgets/pet_grid_tile.dart';
import 'package:frist_project/presentation/widgets/text_form_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/pet.dart';

class PetPage extends StatefulWidget {
  const PetPage({super.key});

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  List<Pet> pett = [];
  String userName = '';

  getPets() async {
    List<Pet> pett = await PetsLocalDataImpl().getPets();
    print(pett);
  }

  getUserData() async {
    if (await UserLocalDataImpl().hasSignedUP()) {
      UserData userData = await UserLocalDataImpl().getUser();
      print(userData);
      String name = userData.name;
      userName = name;
      print(userName);
      return userName;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPets();
    getUserData();
  }

  bool isShowBottomSheet = false;

  IconData icon = Icons.edit;

  late Pet pet;

  var nameController = TextEditingController();

  var imageUrlController = TextEditingController();

  var idController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        leading: Icon(Icons.settings),
        title: Text(
          userName,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // final pref = await SharedPreferences.getInstance();
              // pref.remove('SignedUp user');
              await UserLocalDataImpl().logOut();
              await UserLocalDataImpl()
                  .hasSignedUP()
                  .then((value) => print(value));
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => FormPage()));
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            style: TextButton.styleFrom(backgroundColor: Color(0xff7209b7)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: PetsLocalDataImpl().getPets(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (BuildContext context, int index) => PetItem(
                        pet: snapshot.data![index],
                        onFavState: () {},
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (isShowBottomSheet) {
              if (formKey.currentState!.validate()) {
                Pet pet = Pet(
                    id: idController.text,
                    name: nameController.text,
                    imageUrl: 'assets/images/istockphoto-455208643-612x612.jpg',
                    tips: 'any thing');
                //pets.add(pet);
                Navigator.pop(context);
                isShowBottomSheet = false;
                setState(() {
                  icon = Icons.edit;
                });
                await PetsLocalDataImpl().setPet(pet);
                await PetsLocalDataImpl().getPets().then((value) {
                  pett = value;
                  print(value);
                  setState(() {});
                });
              }
            } else {
              scaffoldKey.currentState!.showBottomSheet(
                (context) => Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormTile(
                                controller: nameController,
                                type: TextInputType.text,
                                function: (value) {
                                  if (value!.isEmpty) {
                                    return 'pet name must be entered';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Enter The pet Name",
                                  border: OutlineInputBorder(),
                                  prefix: Icon(
                                    Icons.title,
                                  ),
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            // TextFormTile(
                            //     controller: imageUrlController,
                            //     type: TextInputType.text,
                            //     decoration:const InputDecoration(
                            //       labelText: "enter the Image URL",
                            //       border: OutlineInputBorder(),
                            //       prefix: Icon(
                            //         Icons.watch_later,
                            //       ),
                            //     )),
                            // const SizedBox(
                            //    height: 8,
                            //  ),
                            TextFormTile(
                                controller: idController,
                                type: TextInputType.number,
                                function: (value) {
                                  if (value!.isEmpty) {
                                    //this msg must be unique
                                    return 'pet id must be entered';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: "enter the pet id",
                                  border: OutlineInputBorder(),
                                  prefix: Icon(
                                    Icons.watch_later,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
              isShowBottomSheet = true;
              setState(() {
                icon = Icons.add;
              });
            }
          },
          child: Icon(icon)),
    );
  }
}