 import 'package:flutter/material.dart';

class UserController {

  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController? passwordVerify;
  final TextEditingController? mail;
  final TextEditingController role;
  final TextEditingController active;

   UserController({
     required this.username,
     required this.password,
     this.passwordVerify,
     this.mail,
     required this.role,
     required this.active
   });
 }