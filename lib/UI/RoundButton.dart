import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final dynamic Icons;

  final VoidCallback onTap;

  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false,
        this.Icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.w,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
             FaIcon(Icons,size: 24.sp,),
              SizedBox(width: 15.w,),
              Center(
                child: loading
                    ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,)
                    : Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
