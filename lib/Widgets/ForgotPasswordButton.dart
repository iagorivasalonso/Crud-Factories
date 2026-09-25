
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget{
  
  final VoidCallback onPressed;
  final String action;
  
  const ForgotPasswordButton({
      super.key,
      required this.onPressed,
      required this.action
  });
  
  @override
  Widget build(BuildContext context) {
    
     return TextButton(
         onPressed: onPressed,
         child: Text(action)
     );
  }
}