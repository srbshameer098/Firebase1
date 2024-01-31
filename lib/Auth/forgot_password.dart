import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase/Widgets/RoundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text('Forgot Password',)
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            SizedBox(height: 25.h),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Email',
                  // helperText: 'enter email e.g: example@gmail.com',
                  prefixIcon: Icon(
                    Icons.alternate_email_rounded,
                    color: Colors.black,
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter email';
                }
                return null;
              },
            ),


            RoundButton1(title: 'Fogot', onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                Utils().toastMessage('We have send you email to recover password, Please cheak email');


              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());

              });
            })

          ],
        ),
      ),
    );
  }
}
