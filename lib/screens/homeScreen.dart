import 'package:flutter/material.dart';
import 'package:travel_app/screens/shared/shared_checklist_screen.dart';
import 'personal/personal_checklist_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFE5A1D),
      appBar: AppBar(
        title: Text('Travel App' , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w700),),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalChecklistScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text('Personal Checklist' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600),),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SharedChecklistScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text('Shared Checklist' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600 , color: Colors.white),),
              ),
            ),
            // You can add a similar button for Shared Checklist
          ],
        ),
      ),
    );
  }
}

