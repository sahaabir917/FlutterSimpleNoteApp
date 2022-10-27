import 'package:http/http.dart' as http;
import 'package:noteapp/models/note_details_model.dart';
import 'package:noteapp/models/note_model.dart';

class ApiService {
  var _noteModel;
  NoteDetailsModel _noteDetailsModel = NoteDetailsModel();
  static var client = http.Client();

  Future<List<NoteModel>> getTodos(int page) async {
    try {
      var response = await client.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/todos?_page=$page&_limit=10'));
      print("response is $response");
      _noteModel = noteModelFromJson(response.body);
      return _noteModel;
    } catch (e) {
      print(e);
      return _noteModel;
    }
  }

  Future<dynamic> getTodoDetails(int id) async {
    try {
      var response = await client.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/todos/$id'));
      print("response is $response");
      _noteDetailsModel = noteDetailsModelFromJson(response.body);
      return _noteDetailsModel;
    } catch (e) {
      print(e);
      return _noteModel;
    }
  }
}
