import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';

class OwnerWidget extends StatelessWidget {

  final Owner owner;
  final double height;
  final double width;

  OwnerWidget({Key key, this.owner, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              HeroIcons.icon_user,
              size: 30.0,
            ),
            title: Row(
              children: [
                owner.name != null && owner.name.value.isNotEmpty
                    ? Text(owner.name.value,
                    style: StyleConstants.darkBlackDescriptionText)
                    : Text(
                  'Name',
                  style: StyleConstants.greyedOutText,
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Icon(
              HeroIcons.icon_mail,
              size: 30.0,
            ),
            title: owner.email != null && owner.email.value.isNotEmpty
                ? Text(owner.email.value,
                style: StyleConstants.darkBlackDescriptionText)
                : Text(
              'Email',
              style: StyleConstants.greyedOutText,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Icon(
              HeroIcons.icon_call,
              size: 30.0,
            ),
            title: owner.phoneNumber != null
                ? Text(owner.phoneNumber.value,
                style: StyleConstants.darkBlackDescriptionText)
                : Text(
              'Phone Number',
              style: StyleConstants.greyedOutText,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            leading: Icon(
              HeroIcons.icon_home,
              size: 30.0,
            ),
            title: owner.address != null && owner.address.value.isNotEmpty
                ? Text(owner.address.value,
                style: StyleConstants.darkBlackDescriptionText)
                : Text(
              'Address',
              style: StyleConstants.greyedOutText,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
