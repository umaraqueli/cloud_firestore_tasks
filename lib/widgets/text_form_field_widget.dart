import 'package:flutter/material.dart';

InputDecoration decoration(String label, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    suffixIcon: suffixIcon,
  );
}

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return 'Por favor, insira  $fieldName';
  }
  return null;
}
