import 'package:flutter/material.dart';
import 'package:petcode_app/screens/setup_tag/stp_start_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class NoPetsAvailableIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: StyleConstants.yellow,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 300,
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You currently have no',
                style: StyleConstants.whiteTitleTextSmall,
              ),
              Text(
                'registered pets',
                style: StyleConstants.whiteTitleTextSmall,
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StpStartScreen()),
                ),
                child: Container(
                  width: 150.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: StyleConstants.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Register a Tag',
                      style: StyleConstants.whiteTitleTextXS,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
