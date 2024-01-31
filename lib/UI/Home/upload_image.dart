import 'dart:io';

import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase/Widgets/RoundButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}



class _UploadImageScreenState extends State<UploadImageScreen> {


  bool loading = false;
  File? _image ;
  final picker = ImagePicker();




   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance ;
   DatabaseReference  databaseRef = FirebaseDatabase.instance.ref('Post');

  Future getImageGallery()async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image Picked');
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Upload_Image'),
      ),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: InkWell(
                onTap: (){

                  getImageGallery();
                },
                child: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                  child: _image != null ? Image.file(_image!.absolute) :
                  Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            RoundButton(title: 'Upload', loading:loading , onTap: () async {

              setState(() {
                loading =true;
              });
              firebase_storage.Reference ref =
              firebase_storage.FirebaseStorage.instance.ref('/SRB/'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

              await Future.value(uploadTask);

               var newUrl = await ref.getDownloadURL();


               databaseRef.child('2').set({
                 'id' : '1212',
                 'title' : newUrl.toString()
               }).then((value) {
                 setState(() {
                   loading =false;
                 });
               }).onError((error, stackTrace) {
                 setState(() {
                   loading =false;
                 });
               });

               Utils().toastMessage('Uploaded');


            })

          ],
        ),
      ),
    );
  }
}
