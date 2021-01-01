import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class AccountInfoEditingScreen extends StatefulWidget {
  AccountInfoEditingScreen({Key key}) : super(key: key);

  @override
  _AccountInfoEditingScreenState createState() =>
      _AccountInfoEditingScreenState();
}

class _AccountInfoEditingScreenState extends State<AccountInfoEditingScreen> {
  TextEditingController _fullNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _phoneNumberInputController;

  UserService _userService;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {

    _userService = Provider.of<UserService>(context, listen: false);

    _fullNameInputController =
    new TextEditingController(text: _userService.currentUser.fullName ?? '');
    _emailInputController =
        new TextEditingController(text: _userService.currentUser.email ?? '');
    _phoneNumberInputController =
        new TextEditingController(text: _userService.currentUser.phoneNumber ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  //end: Alignment(0.01, 0.01),
                  end: Alignment.bottomLeft,
                  stops: [0.01, 0.4, 0.6],
                  colors: [
                    const Color(0xffABDEED),
                    const Color(0xff51BFDA),
                    StyleConstants.blue
                  ], // whitish to gray
                  //tileMode: TileMode.repeated,
                )
            ),

            width: width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: StyleConstants.bgGradient,
                  ),

                  height: height * 0.15,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Open Sans',
                                  fontSize: height * 0.02
                              ),
                            ),
                          ),
                          Text(
                            'Update Account Info',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Open Sans',
                                fontSize: height * 0.023
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                User updatedUser = updateUser();

                                DatabaseService databaseService = Provider.of<DatabaseService>(context, listen: false);
                                await databaseService.updateUser(updatedUser);

                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Open Sans',
                                  fontSize: height * 0.02
                              ),
                            ),
                          ),

                        ],
                      )),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Container(
                                  width: width * 0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Full Name',
                                        style: StyleConstants.editTextFieldDescription,
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        child: SizedBox(
                                          height: height * 0.07,
                                          child: TextFormField(
                                            controller: _fullNameInputController,
                                            validator: (value) => ValidatorHelper.firstNameValidator(value),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.05,),
                                Container(
                                  width: width * 0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Phone Number',

                                        style: StyleConstants.editTextFieldDescription,),
                                      TextFormField(
                                        controller: _phoneNumberInputController,
                                        validator: (value) => ValidatorHelper.phoneNumberValidator(value),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.05,),
                                Container(
                                  width: width * 0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email Address',
                                        style: StyleConstants.editTextFieldDescription,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      TextFormField(
                                        controller: _emailInputController,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Open Sans',
                                          fontSize: 18.0,
                                          color: StyleConstants.lightBlack,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        validator: (value) => ValidatorHelper.emailValidator(value),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));

  }

  User updateUser() {
    User updatedUser = _userService.currentUser;

    //updatedUser.firstName = _firstNameInputController.text;
    //updatedUser.lastName = _lastNameInputController.text;
    updatedUser.fullName = _fullNameInputController.text;
    updatedUser.email = _emailInputController.text;
    updatedUser.phoneNumber = _phoneNumberInputController.text;

    return updatedUser;
  }
}
