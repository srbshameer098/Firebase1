import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';




class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;

  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();


  CollectionReference ref = FirebaseFirestore.instance.collection('users');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: const Center(child: Text('firestore')),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout_outlined)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            SizedBox(height: 20.h,),
















            // Expanded(
            //     child: StreamBuilder(
            //   stream: ref.onValue,
            //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //     if (snapshot.connectionState==ConnectionState.waiting) {
            //       return Center(
            //           child: SizedBox(
            //               width: 30,
            //               height: 30,
            //               child: CircularProgressIndicator()));
            //     }
            //
            //       if (snapshot.hasData) {
            //         Map<dynamic, dynamic> map =
            //         snapshot.data!.snapshot.value as dynamic;
            //         List<dynamic> list = [];
            //         list.clear();
            //         list = map.values.toList();
            //         return ListView.builder(
            //             itemCount: snapshot.data!.snapshot.children.length,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text(list[index]['title']),
            //               );
            //             });
            //
            //     }
            //     if (snapshot.hasError) {
            //       return Center(
            //         child: Text("Error"),
            //       );
            //     }else{return SizedBox();}
            //   },
            // )),






            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if(snapshot.hasError) {
                  return const Text('Some error');
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){

                        return ListTile(
                          onTap: (){
                           // ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                           //   'title': 'create'
                           // }).then((value) {
                           //   Utils().toastMessage('updated');
                           // }).onError((error, stackTrace) {
                           //   Utils().toastMessage(error.toString());
                           // });
                            ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                           },
                          title: Text(snapshot.data!.docs[index]['title'].toString()),
                           subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }),
                );
              }
            ),





            // const Text('Welcome to flutter World',style: TextStyle(fontSize: 24),),
            // Container(width: 200,
            //     height: 200,
            //     child: Lottie.asset(
            //       'assets/animi.json',
            //       width: 200,
            //       height: 200,
            //       fit: BoxFit.fill,)
            //     ),

            // LoadingButton(title: 'play', onTap: () {
            //   setState(() {
            //     loading = true;
            //   });
            //   Future.delayed(Duration(seconds: 5),(){
            //     setState(() {
            //       loading=false;
            //     });
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context)=>page2()));
            //   });
            //
            // },)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFireStoreData()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }




  Future<void> showMyDialog(String title, String id)async{
    editController.text = title ;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: const InputDecoration(
                  hintText: 'Edit',
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);


              }, child: const Text('Update')),

            ],
          );

        }
    );
  }
}
