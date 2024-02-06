import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Notification_List extends StatefulWidget {
  const Notification_List({Key? key}) : super(key: key);

  @override
  State<Notification_List> createState() => _Notification_ListState();
}

class _Notification_ListState extends State<Notification_List> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Notification');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification List'),
        ),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                FirebaseAnimatedList(
                    query: ref,
                    defaultChild: const Center(child: Text('Loading')),
                    itemBuilder: (context, snapshot, animation, index) {

                      final productname =
                          snapshot.child('product_name').value.toString();
                      final productsize =
                          snapshot.child('product_size').value.toString();


                      return ListTile(


                        // subtitle: Text(snapshot.child('id').value.toString()),

                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.child('product_name').value.toString()),
                            Text(snapshot.child('product_size').value.toString()),
                          ],
                        ),


                      );
                    })
              ],
            ),
          )
        ]));
  }
}
