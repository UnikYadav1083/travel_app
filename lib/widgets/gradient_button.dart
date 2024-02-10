import 'package:travel_app/widgets/pallete.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onTap;

  const GradientButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         gradient: const LinearGradient(colors:[
           Pallete.gradient1 ,Pallete.gradient2 , Pallete.gradient3,
             ],
           begin: Alignment.bottomLeft ,
           end: Alignment.topRight,
         ),
         borderRadius: BorderRadius.circular(10),
       ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
          fixedSize: Size(290, 50),
              backgroundColor:Colors.transparent,
            shadowColor: Colors.transparent,
      ),
          child: const Text("Sign in",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
      ),
    );
  }
}
