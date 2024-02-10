import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'create_checklist_edit_screen.dart';
import 'create_checklist_screen.dart';

class SharedChecklistScreen extends StatefulWidget {
  @override
  _SharedChecklistScreenState createState() => _SharedChecklistScreenState();
}

class _SharedChecklistScreenState extends State<SharedChecklistScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> _editChecklist(String checklistId, String currentTitle) async {
    final updatedTitle = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateChecklistEditScreen(
          initialTitle: currentTitle,
          isEditing: true,
          checklistId: checklistId,
        ),
      ),
    );
    if (updatedTitle != null) {
      await _firestore.collection('checklists').doc(checklistId).update({
        'title': updatedTitle,
      });
    }
  }

  Future<void> _deleteChecklist(String checklistId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this checklist?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      await _firestore.collection('checklists').doc(checklistId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Checklists' , style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 25),),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('checklists').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final checklists = snapshot.data!.docs;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: checklists.length,
              itemBuilder: (context, index) {
                final checklist = checklists[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(checklist['title']),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
                              side: const BorderSide(color: Colors.orange), // Set your desired border color
                            ),
                            trailing: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editChecklist(checklist.id, checklist['title']);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteChecklist(checklist.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateChecklistScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}


