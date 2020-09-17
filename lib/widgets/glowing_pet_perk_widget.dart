import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/pet_perk_widget.dart';

class GlowingPetPerkWidget extends StatefulWidget {
  GlowingPetPerkWidget({Key key, this.petPerk}) : super(key: key);

  final PetPerk petPerk;

  @override
  _GlowingPetPerkWidgetState createState() => _GlowingPetPerkWidgetState();
}

class _GlowingPetPerkWidgetState extends State<GlowingPetPerkWidget>
    with SingleTickerProviderStateMixin {
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
      child: PetPerkWidget(
        petPerk: widget.petPerk,
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
