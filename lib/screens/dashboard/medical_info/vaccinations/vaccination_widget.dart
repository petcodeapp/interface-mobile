import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class VaccinationWidget extends StatefulWidget {
  VaccinationWidget(
      {Key key, this.updateProvider, this.vaccineName, this.vaccineDate})
      : super(key: key);

  final bool updateProvider;
  final String vaccineName;
  final Timestamp vaccineDate;

  @override
  _VaccinationWidgetState createState() => _VaccinationWidgetState();
}

class _VaccinationWidgetState extends State<VaccinationWidget> {
  double _height;
  double _width;

  DateTime _vaccineDate;
  bool _tapped;

  @override
  void initState() {
    if (widget.vaccineDate != null) {
      _vaccineDate = widget.vaccineDate.toDate();
    } else {
      _vaccineDate = DateTime.now();
    }

    if (widget.updateProvider != null && widget.updateProvider) {
      _tapped = true;
    } else {
      _tapped = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    bool hasDate = widget.vaccineDate != null;

    return GestureDetector(
      onTap: () {
        if (_tapped) {
          Provider.of<NotificationsProvider>(context, listen: false)
              .clearIndex();
        } else {
          _editVaccine();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: StyleConstants.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              ),
            ]),
        width: _width * 0.8,
        height: _height * 0.15,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vaccineName,
                    style: TextStyle(
                      color: StyleConstants.yellow,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(hasDate
                      ? 'Expires: ' +
                          StringHelper.getDateString(
                              widget.vaccineDate.toDate())
                      : 'No Date Given'),
                ],
              ),
              Spacer(),
              Icon(
                Icons.remove_red_eye,
                size: 30.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.file_download,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editVaccine() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: _height * 0.6,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: _width * 0.1,
                    right: _width * 0.1,
                    top: _height * 0.03,
                    bottom: _height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: _width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Vaccination',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Name',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Expiration',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringHelper.getDateStringNoYear(
                                            _vaccineDate),
                                        style:
                                            StyleConstants.blackDescriptionText,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                              .then((date) {
                                            setState(() {
                                              _vaccineDate = date;
                                              print(_vaccineDate.toString());
                                            });
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              SizedBox(
                                height: _height * 0.05,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StyleConstants.yellow,
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    height: _height * 0.06,
                                    width: _width * 0.7,
                                    child: Center(
                                        child: Text(
                                      'Change Document',
                                      style: StyleConstants
                                          .whiteThinTitleTextSmall,
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: StyleConstants.red,
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          height: _height * 0.06,
                                          width: _width * 0.35,
                                          child: Center(
                                              child: Text(
                                            'Delete',
                                            style: StyleConstants
                                                .whiteThinTitleTextSmall,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: StyleConstants.blue,
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                          ),
                                          height: _height * 0.06,
                                          width: _width * 0.35,
                                          child: Center(
                                              child: Text(
                                            'Update',
                                            style: StyleConstants
                                                .whiteThinTitleTextSmall,
                                          )),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
