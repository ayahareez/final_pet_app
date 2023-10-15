import 'package:flutter/material.dart';

class TextFormTile extends StatelessWidget {
  final TextEditingController controller ;
  final TextInputType type;
  final InputDecoration decoration;
  final Function? function;
  const TextFormTile({super.key, required this.controller, required this.type ,this.function ,required this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: decoration,
      validator: (value)=>function!(value),
    );
  }
}
