import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../UI/utiles/Utils.dart';
import '../Widgets/RoundButton.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({Key? key}) : super(key: key);

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {

  final postController = TextEditingController();
  final productController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30,),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                  hintText: "What is in your mind ? ",
                  border: OutlineInputBorder()
              ),
            ),


            // TextFormField(
            //   maxLines: 4,
            //   controller: productController,
            //   decoration: InputDecoration(
            //       hintText: "Enter the Product",
            //       border: OutlineInputBorder()
            //   ),
            // ),

            SizedBox(height: 30,),

            RoundButton(title: "Add",
                loading: loading,
                onTap: () {

                  setState(() {
                    loading = true;
                  });

                  String id  = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc().set({
                    'title' : postController.text.toString(),
                    'id'  :  id
                  }).then((value) {
                    Utils().toastMessage('Post added');

                  }).onError((error, stackTrace) {

                    setState(() {
                      loading = true;
                    });
                    Utils().toastMessage(error.toString());
                  });

                } )
          ],
        ),
      ),
    );
  }







  Future<void> showMyDialog()async{
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(),
            ),
            actions: [],
          );

        }
    );
  }}
