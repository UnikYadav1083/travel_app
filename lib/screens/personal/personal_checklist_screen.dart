import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/checklistItem.dart';

class PersonalChecklistScreen extends StatefulWidget {
  const PersonalChecklistScreen({super.key});

  @override
  _PersonalChecklistScreenState createState() => _PersonalChecklistScreenState();
}

class _PersonalChecklistScreenState extends State<PersonalChecklistScreen> {

  List<ChecklistItem> _checklistItems = [];
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final itemStrings = prefs.getStringList('checklist');
    if (itemStrings == null) return;

    setState(() {
      _checklistItems = itemStrings
          .map((title) => ChecklistItem(id: DateFormat('yyyyMMdd').format(DateTime.now()), title: title))
          .toList();
    });
  }


  Future<void> _saveChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final itemStrings = _checklistItems.map((e) => e.title).toList();
    await prefs.setStringList('checklist', itemStrings);
  }


  Future<void> _addItem() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in something.'),
        ),
      );
      return;
    }

    setState(() {
      _checklistItems.add(ChecklistItem(
          id: DateFormat('dd-MM-yyyy').format(DateTime.now()), title:_titleController.text));
      _titleController.clear();
    });

    _formKey.currentState?.save();
    await _saveChecklist();
  }


  Future<void> _editItem(ChecklistItem item, String newTitle) async {
    setState(() {
      item.title = newTitle;
    });

    await _saveChecklist();
  }

  Future<void> _deleteItem(ChecklistItem item) async {
    setState(() {
      _checklistItems.remove(item);
    });

    await _saveChecklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Checklist' , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 25),),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const SizedBox(height:10),
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
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: _addItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF69B4), // Set the desired color
                ),
                child: const Text('Add' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w600),),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _checklistItems.length,
                itemBuilder: (context, index) {
                  ChecklistItem item = _checklistItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.edit),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit item'),
                                    content: TextFormField(
                                        controller: TextEditingController(text: item.title),
                                        onChanged: (value) {
                                          item.title = value;
                                        },
                                        maxLines: null,
                                        ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Save'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _editItem(item, item.title);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            child: Icon(Icons.delete),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete item'),
                                    content: const Text(
                                        'Are you sure you want to delete this item?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _deleteItem(item);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ));
  }
}
