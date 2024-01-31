import 'package:firebase/Auth/login_screen.dart';
import 'package:firebase/Widgets/RoundButton.dart';
import 'package:firebase/UI/utiles/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth= FirebaseAuth.instance;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  bool value = false;
  bool isVisible=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,

        title: const Center(child: Text('Signup')),

      ),

      body: Padding(
        padding:  EdgeInsets.only(left:20.w,top: 20.h,right: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          // helperText: 'enter email e.g: example@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email_rounded,color: Colors.black,)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter email';
                        }return null;
                      },
                    ),
                    SizedBox(height: 15.h),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          // helperText: 'enter password e.g: 123456',
                          prefixIcon: const Icon(Icons.lock_outline_rounded,color: Colors.black,),
                          suffixIcon:  GestureDetector(onTap: (){
                            setState((){
                              isVisible=!isVisible;
                            });
                          },
                            child:isVisible==false? const Icon(
                              Icons.remove_red_eye_outlined,size: 24,
                              color: Colors.grey,
                            ):const FaIcon(FontAwesomeIcons.eyeSlash,color: Colors.grey,),
                          )

                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter password';
                        }return null;
                      },
                    ),
                  ],
                )),


            SizedBox(height: 50.h),
            RoundButton1(
                title: 'Sign up',
                loading: loading,
                onTap: () {
                  if (formkey.currentState!.validate()){
                   setState(() {
                     loading =true;
                   });

                    auth.createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString()).then((value){
                      setState(() {
                        loading =false;
                      });
                    }).onError((error, stackTrace) {

      Utils().toastMessage(error.toString());
      setState(() {
        loading =false;
      });
                    });
                  }
                }

            ),
            SizedBox(height: 50.h,),
            Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account ?  ',style: TextStyle(color: Colors.black)),


                GestureDetector(onTap: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder:(context) =>const HomePage()));
                },
                    child: const Text('Login ',style: TextStyle(color: Colors.blueAccent),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
