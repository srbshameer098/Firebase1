import 'package:flutter/material.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Upload_Image'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black
                )
              ),
              child: Center(child: Icon(Icons.image)),
            ),
          )

        ],
      ),
    );
  }
}
