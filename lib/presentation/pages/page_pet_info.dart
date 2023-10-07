import 'package:flutter/material.dart';
import 'package:frist_project/data/data_source/data_source.dart';
import 'package:frist_project/data/data_source/pets_local_datasource/pets_local_datasource.dart';
import 'package:frist_project/presentation/widgets/pet_info_tile.dart';

import '../../data/models/pet.dart';

class InfoPage extends StatefulWidget {
  final Pet pet;

  const InfoPage(this.pet, {super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoTile(widget.pet),
    );
  }
}