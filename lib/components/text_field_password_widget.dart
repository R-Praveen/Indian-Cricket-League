import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatelessWidget {
  final Stream<String?> error;
  final Function(String value) onChanged;
  final Function onChangedPasswordVisibility;
  final String hintText;
  final Stream<bool?> obscure;
  TextFieldPasswordWidget({
    required this.error,
    required this.onChanged,
    required this.onChangedPasswordVisibility,
    required this.hintText,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: error,
        builder: (context, snapshot) {
          return StreamBuilder<bool?>(
              stream: obscure,
              builder: (context, obscureStatus) {
                return TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: onChanged,
                  obscureText: obscureStatus.data ?? false,
                  decoration: InputDecoration(
                      hintText: hintText,
                      errorText: snapshot.data,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          onChangedPasswordVisibility();
                        },
                        icon: Icon(
                          (obscureStatus.data ?? false)
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      )),
                );
              });
        });
  }
}
