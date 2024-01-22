import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase/UI/Home/add_posts.dart';
import 'package:firebase/UI/Home/page2.dart';
import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/RoundButton.dart';

bool loading = false;


class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final editController = TextEditingController();








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
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
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
      body: Column(
        children: [
















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
















          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  final  title = snapshot.child('title').value.toString();
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value:1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(title , snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              )),
                          PopupMenuItem(
                            value:1,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  ref.child(snapshot.child('id').value.toString()).remove();
                                },
                                leading: Icon(Icons.delete_outline),
                                title: Text('Delete'),
                              ))
                        ]
                    ),
                  );
                }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }




  Future<void> showMyDialog(String title, String id)async{
    editController.text = title ;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                  hintText: 'Edit',
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title' : editController.text.toLowerCase()
                }).then((value) {
                  Utils().toastMessage('Ppost Updated');

                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }, child: Text('Update')),

            ],
          );

        }
    );
}
}
