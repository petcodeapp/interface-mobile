import 'package:flutter/material.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';

class PetInfoEditingScreen extends StatefulWidget {
  @override
  _PetInfoEditingScreenState createState() => _PetInfoEditingScreenState();
}

class _PetInfoEditingScreenState extends State<PetInfoEditingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.asset(
                      'assets/images/stockdog1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Change Pet Photo',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Breed',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Breed',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Temperament',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Temperament',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Additional Info',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Additional Info',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Animal',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      height: height * 0.07,
                      width: width * 0.7,
                      child: CircularCheckBox(
                        value: false,
                      ),
                    )
                  ],
                ),
                Divider(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Owner 1',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),

                Divider(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Owner 2',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Container(
                      //height: height * 0.07,
                      width: width * 0.7,
                      child: TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
