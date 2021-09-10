import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  const ErrorMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          tr(message),
          style: const TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600,
            color: Colors.red
          ),
        ),
      ),
    );
  }
}
