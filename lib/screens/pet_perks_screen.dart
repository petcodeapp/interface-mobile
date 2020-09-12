import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/text_only_curved_app_bar.dart';

class PetPerksScreen extends StatefulWidget {
  @override
  _PetPerksScreenState createState() => _PetPerksScreenState();
}

class _PetPerksScreenState extends State<PetPerksScreen> {

  List discountAmount = ['50', '10', '33','40'];
  List storeName = ['PetSmart', 'Greenies', 'FunnyFur','PetCode'];
  List descriptions = ['Pet Supplies, Accessories, and Products', 'Dental Treats - Irresistable!', 'Pet Supplies, Accessories, and Products','Pet Supplies, Accessories, and Products'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void _showPetPerks(){
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
          ),
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context){
            return Container(
              height: height * 0.6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0,),
                    Align(
                      alignment: Alignment.center,
                        child: Text('Pet Perks', style: StyleConstants.blackThinTitleText,)),
                    Row(children: [
                      Text('50%', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 60.0,
                        color: StyleConstants.yellow
                      )),
                      Container(
                        height: 100.0, width: 200.0,
                          child: Image.asset('assets/images/petsmartlogo.jpg')),
                    ],
                    ),
                    Text('Discount at PetSmart', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, color: StyleConstants.blue),),
                    SizedBox(height: 20.0,),
                    Text('Details', style: StyleConstants.blackThinTitleTextMedium,),
                    Text('Back to School Sale! Get an extra 50% off regular & sale Belk exclusive & select national brands purchases (40% off select national brands; 20% off select designer brands)'),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Text('Promo Code: ', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25.0, color: StyleConstants.blue),),
                        Text('PETCODE123', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: StyleConstants.yellow),),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: height * 0.08,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: StyleConstants.blue,
                        ),
                        child: Center(
                          child: Text('Shop Now', style: StyleConstants.whiteThinTitleTextSmall,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          );
    }

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      appBar: TextOnlyCurvedAppBar(
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('Categories', style: StyleConstants.blackThinTitleTextSmall,),
            ),
            SizedBox(height:  height * 0.01,),
            Container(
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0,3),
                    blurRadius: 6.0,
                  ),
                ],
              ),
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 30.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/petperksplaceholderimg.png', fit: BoxFit.cover,),
                            height: 100.0,
                            width: 100.0,
                          ),
                          Text('Toys', style: StyleConstants.blackThinDescriptionText,),
                        ],
                      ),
                      SizedBox(width: 30.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/petperksplaceholderimg.png', fit: BoxFit.cover,),
                            height: 100.0,
                            width: 100.0,
                          ),
                          Text('Food', style: StyleConstants.blackThinDescriptionText,),
                        ],
                      ),
                      SizedBox(width: 30.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/petperksplaceholderimg.png', fit: BoxFit.cover,),
                            height: 100.0,
                            width: 100.0,
                          ),
                          Text('Medication', style: StyleConstants.blackThinDescriptionText,),
                        ],
                      ),
                      SizedBox(width: 30.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/petperksplaceholderimg.png', fit: BoxFit.cover,),
                            height: 100.0,
                            width: 100.0,
                          ),
                          Text('Clothing', style: StyleConstants.blackThinDescriptionText,),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
            SizedBox(height: height* 0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text('Food Perks', style: StyleConstants.blackThinTitleText,),
            ),
            SizedBox(height: height * 0.01,),
            Expanded(
              child: ListView.builder(
                  itemCount: storeName.length,
                itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: _showPetPerks,
                        child: Container(
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6.0,
                                offset: Offset(0,3),
                              ),
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(discountAmount[index] + '%', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, color: StyleConstants.yellow),),
                                            Text(' Discount', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: StyleConstants.blue),),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Text(storeName[index], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600, color: StyleConstants.blue),)
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 100,
                                        width: 150,
                                        child: Image.asset('assets/images/petsmartlogo.jpg',)),
                                  ],
                                ),
                                Text(descriptions[index], style: StyleConstants.blackThinDescriptionTextSmall.copyWith(color: StyleConstants.blue, fontWeight: FontWeight.w400),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                },
              ),
            ),
          ],
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
