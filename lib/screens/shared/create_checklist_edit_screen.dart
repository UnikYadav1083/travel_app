import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateChecklistEditScreen extends StatefulWidget {
  final String? initialTitle;
  final bool? isEditing;
  final String? checklistId;

  CreateChecklistEditScreen({this.initialTitle, this.isEditing, this.checklistId});

  @override
  _CreateChecklistEditScreenState createState() => _CreateChecklistEditScreenState();
}

class _CreateChecklistEditScreenState extends State<CreateChecklistEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.initialTitle != null) {
      _titleController.text = widget.initialTitle!;
    }
  }

  Future<void> _createChecklist() async {
    if (_formKey.currentState!.validate()) {
      final user = _auth.currentUser;
      final checklist = {
        'title': _titleController.text,
        'createdBy': user!.uid,
        'createdAt': Timestamp.now(),
      };
      if (widget.isEditing == true) {
        await _firestore.collection('checklists').doc(widget.checklistId).update(checklist);
      } else {
        await _firestore.collection('checklists').add(checklist);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Checklist'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createChecklist,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF69B4),
              ),
              child: const Text('Create Checklist' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600),),
            ),
          ],
        ),
      ),
    );
  }
}

