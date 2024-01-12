import 'package:firebase/UI/Home/page2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../RoundButton.dart';
bool loading=false;
class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text('Home')),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to flutter World',style: TextStyle(fontSize: 24),),
            // Container(width: 200,
            //     height: 200,
            //     child: Lottie.asset(
            //       'assets/animi.json',
            //       width: 200,
            //       height: 200,
            //       fit: BoxFit.fill,)
            //     ),

            LoadingButton(title: 'play', onTap: () {
              setState(() {
                loading = true;
              });
              Future.delayed(Duration(seconds: 5),(){
                setState(() {
                  loading=false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>page2()));
              });

            },)

          ],
        ),
      ),
    );
  }
}
