import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_widget.dart';

class GlowingVaccinationWidget extends StatefulWidget {
  GlowingVaccinationWidget({Key key, this.vaccination}) : super(key: key);

  final Vaccination vaccination;

  @override
  _GlowingVaccinationWidgetState createState() => _GlowingVaccinationWidgetState();
}

class _GlowingVaccinationWidgetState extends State<GlowingVaccinationWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 6.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VaccinationWidget(
        vaccination: widget.vaccination,
        updateProvider: true,
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: StyleConstants.yellow,
          blurRadius: _animation.value,
          spreadRadius: _animation.value,
        ),
      ], borderRadius: BorderRadius.circular(15.0)),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
