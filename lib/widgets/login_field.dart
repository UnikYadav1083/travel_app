import 'package:travel_app/widgets/pallete.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget{
  final String hintText;
  final TextEditingController controller;
  const LoginField({super.key, required this.hintText , required this.controller});
  @override
  Widget build(BuildContext context) {
       return ConstrainedBox(
         constraints: const BoxConstraints(
           maxWidth: 290,
         ),
         child: TextField(
           controller: controller,
           decoration: InputDecoration(
             contentPadding: const EdgeInsets.all(20),
             enabledBorder: OutlineInputBorder(
               borderSide:const BorderSide(
                color: Pallete.borderColor,
                 width: 3
               ),
               borderRadius: BorderRadius.circular(15),
             ),
             focusedBorder: OutlineInputBorder(
               borderSide:const BorderSide(
                   color: Pallete.gradient2,
                   width: 3
               ),
               borderRadius: BorderRadius.circular(15),
             ),
               hintText:hintText,
           ),
         ),
       );
  }
}