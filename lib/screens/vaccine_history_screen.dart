import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class VaccineHistoryScreen extends StatefulWidget {
  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  List vaccines = ['Rabies', 'DHPP', 'Influenza', 'Lyme Disease', 'Bordetella'];
  List dates = ['6/1/20', '6/10/20', '6/20/20', '6/25/20', '7/9/2020'];
  List overdue = [false, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: Container(
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Vaccine History',
              style: StyleConstants.blackTitleTextLarge,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index){
                  return Divider(thickness: 1.0,);
                },
                itemCount: vaccines.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(
                      vaccines[index],
                      style: TextStyle(color: StyleConstants.blue),
                    ),
                    subtitle: Text(dates[index]),
                    trailing: Container(
                      width: 100.0,
                      child: overdue[index]
                          ? Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: StyleConstants.red,
                                  ),
                                  height: 20.0,
                                  width: 60.0,
                                  child: Center(
                                    child: Text(
                                      'Overdue',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            )
                          : Row(
                              children: [
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
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
}
