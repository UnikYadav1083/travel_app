import 'dart:ui';

import 'package:travel_app/widgets/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget{
  final String iconPath;
  final String label;
  final double horizontalPadding;
  final VoidCallback onPressed;
  const SocialButton({super.key, required this.iconPath, required this.label,  this.horizontalPadding=50, required this.onPressed});

  @override
  Widget build(BuildContext context) {
     return TextButton.icon(
       onPressed:onPressed,
       icon: SvgPicture.asset(
         iconPath , width: 25,
         color: Pallete.whiteColor,
       ),
       label: Text(label , style: TextStyle(
         color: Pallete.whiteColor,
         fontSize: 17,

       ),),
     style: TextButton.styleFrom(
       padding: EdgeInsets.symmetric(vertical: 20 ,horizontal: horizontalPadding),
       shape: RoundedRectangleBorder(
         side: const BorderSide(
           color: Pallete.borderColor,
           width: 3,
         ),
         borderRadius: BorderRadius.circular(15.0),
       ),
     ),
     );
  }

}