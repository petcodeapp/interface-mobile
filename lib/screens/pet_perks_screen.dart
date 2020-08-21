import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class PetPerksScreen extends StatefulWidget {
  @override
  _PetPerksScreenState createState() => _PetPerksScreenState();
}

class _PetPerksScreenState extends State<PetPerksScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: StyleConstants.blue,
        title: Container(
          //color: Colors.white,
            height: 75,
            //width: 200,
            child: Image.asset(
              'assets/images/appbarlogoyellow.png',
              fit: BoxFit.cover,
            )),
      ),
      body: Container(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05,),
              Text('Pet Perks', style: StyleConstants.blackThinTitleText,),
              SizedBox(height: height * 0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 125, width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/dogtoyscover.png'),
                          fit: BoxFit.cover
                        ),
                      ),
                      child: Center(
                        child: Text('Toys', style: StyleConstants.whiteThinTitleTextSmall,),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 125, width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/dogfoodcover.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: Center(
                        child: Text('Food', style: StyleConstants.whiteThinTitleTextSmall,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 125, width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/dogmedicationcover.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: Center(
                        child: Text('Medication', style: StyleConstants.whiteThinTitleTextSmall,),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 125, width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/dogclothingcover.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: Center(
                        child: Text('Clothing', style: StyleConstants.whiteThinTitleTextSmall,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 125, width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/dogsuppliescover.png'),
                            fit: BoxFit.cover
                        ),
                      ),
                      child: Center(
                        child: Text('Supples', style: StyleConstants.whiteThinTitleTextSmall,),
                      ),
                    ),
                  ),
                  comingSoonWidget(),
                ],
              ),
              SizedBox(height: height * 0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  comingSoonWidget(),
                  comingSoonWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget comingSoonWidget(){

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 125, width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: StyleConstants.lightGrey,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('More', style: StyleConstants.whiteThinTitleTextSmall,),
              Text('Coming', style: StyleConstants.whiteThinTitleTextSmall,),
              Text('Soon!', style: StyleConstants.whiteThinTitleTextSmall,),
            ],
          ),
        ),
      ),
    );
  }
}
