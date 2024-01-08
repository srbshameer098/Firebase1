import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;

  final VoidCallback onTap;

  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.w,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,)
              : Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
        ),
      ),
    );
  }
}
