import '../dtos/Reminder.dart';

class RemindersResponse {
  bool? status;
  List<Reminder>? reminders;
  String? message;

  RemindersResponse({this.status, this.reminders, this.message});

  RemindersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      reminders = <Reminder>[];
      json['data'].forEach((v) {
        reminders!.add(Reminder.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (reminders != null) {
      data['data'] = reminders!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}


