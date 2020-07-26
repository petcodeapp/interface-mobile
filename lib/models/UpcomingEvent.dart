
import 'package:cloud_firestore/cloud_firestore.dart';

class UpcomingEvent {
  String name;
  String petName;
  Timestamp date;

  UpcomingEvent({this.name, this.petName, this.date});
}