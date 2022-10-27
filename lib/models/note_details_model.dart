// To parse this JSON data, do
//
//     final noteDetailsModel = noteDetailsModelFromJson(jsonString);

import 'dart:convert';

NoteDetailsModel noteDetailsModelFromJson(String str) => NoteDetailsModel.fromJson(json.decode(str));

String noteDetailsModelToJson(NoteDetailsModel data) => json.encode(data.toJson());

class NoteDetailsModel {
  NoteDetailsModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory NoteDetailsModel.fromJson(Map<String, dynamic> json) => NoteDetailsModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}
