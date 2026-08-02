import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInfoField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final double? width;
  final String? Function(String?)? validator;

  const UserInfoField({
    super.key,
    required this.label,
    required this.controller,
    this.width,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * .4,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
