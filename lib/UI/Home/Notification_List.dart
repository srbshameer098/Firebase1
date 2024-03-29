

import 'package:firebase/UI/Home/Notification_page.dart';
import 'package:firebase/firebase_services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notification_List extends StatefulWidget {
  const Notification_List({Key? key}) : super(key: key);

  @override
  State<Notification_List> createState() => _Notification_ListState();
}

class _Notification_ListState extends State<Notification_List> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Notification');




  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification List'),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(children: [
            Expanded(
              child: Container(
               
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    ),
                child: Column(
                  children: [
                    Expanded(
                       child:
                      // FirebaseAnimatedList(
                      //     query: ref.v,
                      //     defaultChild:  const Center(child: Text('Loading')),
                      //     itemBuilder: (context, snapshot, animation, index) {
                      //
                      //       String productname =
                      //           snapshot.child('product_Name').value.toString();
                      //       final productsize =
                      //           snapshot.child('product_Size').value.toString();
                      //
                      //
                      //       return Padding(
                      //         padding:  EdgeInsets.symmetric(vertical: 10),
                      //         child: GestureDetector(
                      //           onTap: (){
                      //             Navigator.push(context,
                      //                 MaterialPageRoute(builder: (context) => const Notification_Page(message:snapshot.child('product_Name').value.toString() )));
                      //           },
                      //           child: Container(
                      //
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 border: Border.all(color: Colors.black)),
                      //             child: ListTile(
                      //
                      //               title: Padding(
                      //                 padding:  EdgeInsets.symmetric(vertical: 10.h),
                      //                 child: Text(snapshot.child('product_Name').value.toString(),style: TextStyle(fontSize: 30.sp),),
                      //               ),
                      //
                      //               // subtitle: Text(snapshot.child('id').value.toString()),
                      //
                      //               subtitle: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //
                      //                   Text(snapshot.child('id').value.toString()),
                      //                   // Text(snapshot.child('product_name').value.toString(),style: TextStyle(),),
                      //                   Padding(
                      //                     padding:  EdgeInsets.symmetric(vertical: 10.h),
                      //                     child: SizedBox(
                      //                         height:50,
                      //                         child: Text(snapshot.child('product_name').value.toString())),
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //
                      //             ),
                      //
                      //           ),
                      //         ),
                      //       );
                      //
                      //     }),



                    StreamBuilder(
                    stream: ref.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.connectionState==ConnectionState.waiting) {
                        return const Center(
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()));
                      }

                        if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> list = [];
                          list.clear();
                          list = map.values.toList();
                          return ListView.builder(
                              itemCount: snapshot.data!.snapshot.children.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){

                                    Navigator.push(context,
                                                         MaterialPageRoute(builder: (context) =>  Notification_Page(data:list[index]['product_Name'].toString())));
                                  },
                                  child: ListTile(
                                    title: Text(list[index]['product_Name']),
                                    subtitle: Text(list[index]['product_Size']),
                                  ),
                                );
                              });

                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error"),
                        );
                      }else{return SizedBox();}
                    },

                          )



                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }
}
