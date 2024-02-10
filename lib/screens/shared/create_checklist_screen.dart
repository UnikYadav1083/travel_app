import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/shared/shared_checklist_screen.dart';

class CreateChecklistScreen extends StatefulWidget {
  @override
  _CreateChecklistScreenState createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _createChecklist() async {
    if (_formKey.currentState!.validate()) {
      final user = _auth.currentUser;
      final checklist = {
        'title': _titleController.text,
        'createdBy': user!.uid,
        'createdAt': Timestamp.now(),
      };
      await _firestore.collection('checklists').add(checklist);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Add Item',
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Color(0xFFFFE4E1),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an item';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createChecklist,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF69B4),
              ),
              child: const Text('Create Checklist' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600 , color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
