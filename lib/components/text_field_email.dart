import 'package:flutter/material.dart';

class TextFieldEmailWidget extends StatelessWidget {
  final Stream<String?> error;
  final Function(String value) onChanged;
  final String hintText;
  TextFieldEmailWidget({
    required this.error,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: error,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: snapshot.data,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        });
  }
}
