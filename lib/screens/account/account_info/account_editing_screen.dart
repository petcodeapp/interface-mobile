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
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _emailInputController;
  TextEditingController _phoneNumberInputController;

  UserService _userService;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {

    _userService = Provider.of<UserService>(context, listen: false);

    _firstNameInputController =
        new TextEditingController(text: _userService.currentUser.firstName ?? '');
    _lastNameInputController =
        new TextEditingController(text: _userService.currentUser.lastName ?? '');
    _emailInputController =
        new TextEditingController(text: _userService.currentUser.email ?? '');
    _phoneNumberInputController =
        new TextEditingController(text: _userService.currentUser.phoneNumber ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Text('Done', style: StyleConstants.whiteDescriptionText,),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                User updatedUser = updateUser();

                DatabaseService databaseService = Provider.of<DatabaseService>(context, listen: false);
                await databaseService.updateUser(updatedUser);

                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _firstNameInputController,
              validator: (value) => ValidatorHelper.firstNameValidator(value),
            ),
            TextFormField(
              controller: _lastNameInputController,
              validator: (value) => ValidatorHelper.lastNameValidator(value),
            ),
            TextFormField(
              controller: _emailInputController,
              validator: (value) => ValidatorHelper.emailValidator(value),
            ),
            TextFormField(
              controller: _phoneNumberInputController,
              validator: (value) => ValidatorHelper.phoneNumberValidator(value),
            ),
          ],
        ),
      ),
    );
  }

  User updateUser() {
    User updatedUser = _userService.currentUser;

    updatedUser.firstName = _firstNameInputController.text;
    updatedUser.lastName = _lastNameInputController.text;
    updatedUser.email = _emailInputController.text;
    updatedUser.phoneNumber = _phoneNumberInputController.text;

    return updatedUser;
  }
}
