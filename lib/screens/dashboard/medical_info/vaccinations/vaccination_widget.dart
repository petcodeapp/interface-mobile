import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/edit_vaccination_widget.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/preview_vaccination_widget.dart';
import 'package:petcode_app/services/download_service.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class VaccinationWidget extends StatefulWidget {
  VaccinationWidget(
      {Key key, this.updateProvider, this.vaccination, this.vaccinationIndex})
      : super(key: key);

  final bool updateProvider;
  final Vaccination vaccination;
  final int vaccinationIndex;

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
    _height = StyleConstants.height;
    _width = StyleConstants.width;

    bool hasDate = widget.vaccination.date != null;

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
            borderRadius: BorderRadius.circular(30.0),
            color: StyleConstants.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: Offset(0, 3),
              ),
            ]),
        width: _width * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _height * 0.05, horizontal: _width * 0.05),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vaccination.name,
                      style: TextStyle(
                        color: StyleConstants.lightBlack,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: null,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          hasDate
                              ? 'Expiration Date: ' +
                                  StringHelper.getDateString(
                                      widget.vaccination.date.toDate())
                              : 'No Date Given',
                          style: TextStyle(
                            color: StyleConstants.lightBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: _width * 0.02,
                        ),
                        Container(
                          height: _height * 0.01,
                          width: _height * 0.01,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: StyleConstants.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        //size: 30.0,
                      ),
                      onPressed: () {
                        if (widget.vaccination.imageUrl != null &&
                            widget.vaccination.imageUrl.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreviewVaccinationWidget(
                                      vaccinationImageUrl:
                                          widget.vaccination.imageUrl,
                                    )),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No image saved!'),
                            ),
                          );
                        }
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        HeroIcons2.download_1,
                        //size: 22.0,
                      ),
                      onPressed: () async {
                        if (widget.vaccination.imageUrl != null &&
                            widget.vaccination.imageUrl.isNotEmpty) {
                          DownloadService()
                              .downloadVaccination(widget.vaccination);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No image saved!'),
                            ),
                          );
                        }
                      },
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
            height: _height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
            ),
            child: EditVaccinationWidget(
              vaccinationName: widget.vaccination.name,
              vaccinationDate: widget.vaccination.date.toDate(),
              vaccinationIndex: widget.vaccinationIndex,
            ),
          );
        });
  }
}
