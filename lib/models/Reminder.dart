import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  //This variable is used only to keep track of the reminder
  int index;

  String name;
  String notificationMethod;
  String frequency;
  bool enabled;
  Timestamp startDate;
  Timestamp endDate;

  Reminder(
      {this.index,
      this.name,
      this.notificationMethod,
      this.frequency,
      this.enabled,
      this.startDate,
      this.endDate});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      name: json['name'] as String,
      notificationMethod: json['notificationMethod'] as String,
      frequency: json['frequency'] as String,
      enabled: json['enabled'] as bool,
      startDate: json['startDate'] as Timestamp,
      endDate: json['endDate'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => _ReminderToJson(this);

  Map<String, dynamic> _ReminderToJson(Reminder instance) => <String, dynamic>{
        'name': instance.name,
        'notificationMethod': instance.notificationMethod,
        'frequency': instance.frequency,
        'enabled': instance.enabled,
        'startDate': instance.startDate,
        'endDate': instance.endDate,
      };
}
