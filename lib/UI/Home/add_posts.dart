import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase/Widgets/RoundButton.dart';
class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  final productnameController = TextEditingController();
  final productsizeController = TextEditingController();
  final productcolorController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
          
              TextFormField(
                maxLines: 4,
                controller: postController,
                decoration: const InputDecoration(
                  hintText: "Enter the Product Title ",
                  border: OutlineInputBorder()
                ),
              ),
              TextFormField(
                maxLines: 4,
                controller: productnameController,
                decoration: const InputDecoration(
                    hintText: "Enter the Product Name",
                    border: OutlineInputBorder()
                ),
              ),
          
              TextFormField(
                maxLines: 4,
                controller: productsizeController,
                decoration: const InputDecoration(
                    hintText: "Enter the Product Size",
                    border: OutlineInputBorder()
                ),
              ),
          
              TextFormField(
                maxLines: 4,
                controller: productcolorController,
                decoration: const InputDecoration(
                    hintText: "Enter the Product Color",
                    border: OutlineInputBorder()
                ),
              ),
          
              const SizedBox(height: 30,),
          
              RoundButton(title: "Add",
                  loading: loading,
                  onTap: () {
          
                setState(() {
                  loading = true;
                });
          
                String id = DateTime.now().millisecondsSinceEpoch.toString();
          
                databaseRef.child(id).set({
                  'title':postController.text.toString(),
                  'product_Name':productnameController.text.toString(),
                  'product_Size':productsizeController.text.toString(),
                  'product_Color':productcolorController.text.toString(),
                  'id':id
                }).then((value) {
                  Utils().toastMessage('Post added');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
              } )
            ],
          ),
        ),
      ),
    );
  }







  Future<void> showMyDialog()async{
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            child: const TextField(),
          ),
          actions: const [],
        );

      }
    );
  }













 }
