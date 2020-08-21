import 'package:flutter/material.dart';

class SocialSplitScreen extends StatefulWidget {
  @override
  _SocialSplitScreenState createState() => _SocialSplitScreenState();
}

class _SocialSplitScreenState extends State<SocialSplitScreen> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.1,),
          Container(
            width: width * 0.7,
            height: height * 0.2,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
