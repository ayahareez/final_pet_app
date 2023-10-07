import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/data/models/pet.dart';

class InfoTile extends StatefulWidget {
  final Pet pet;

  const InfoTile(this.pet, {super.key});

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool isAdopted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'ID # ${widget.pet.id} ${widget.pet.name}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              widget.pet.imageUrl,
              fit: BoxFit.fill,
            ),
            Text(
              'ID: ${widget.pet.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Name: ${widget.pet.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Tips:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${widget.pet.tips}'),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await PetsLocalDataImpl().setAdoptedPet(widget.pet.id);
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Adopted",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child:
                    const Text('ADOPT', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}