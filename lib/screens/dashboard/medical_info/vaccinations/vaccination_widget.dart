import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/edit_vaccination_widget.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class VaccinationWidget extends StatefulWidget {
  VaccinationWidget(
      {Key key,
      this.updateProvider,
      this.vaccineName,
      this.vaccineDate,
      this.vaccineIndex})
      : super(key: key);

  final bool updateProvider;
  final String vaccineName;
  final Timestamp vaccineDate;
  final int vaccineIndex;

  @override
  _VaccinationWidgetState createState() => _VaccinationWidgetState();
}

class _VaccinationWidgetState extends State<VaccinationWidget> {
  double _height;
  double _width;

  bool _tapped;

  @override
  void initState() {
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: _width * 0.05, vertical: _height * 0.05),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
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
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
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
          return Container(
            height: _height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
            ),
            child: EditVaccinationWidget(
              vaccinationName: widget.vaccineName,
              vaccinationDate: widget.vaccineDate.toDate(),
              vaccinationIndex: widget.vaccineIndex,
            ),
          );
        });
  }
}
