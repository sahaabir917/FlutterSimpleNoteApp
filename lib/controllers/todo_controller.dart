import 'package:get/get.dart';
import 'package:noteapp/models/note_details_model.dart';

import '../models/note_model.dart';
import '../service/api_service.dart';

class TodoController extends GetxController {
  ApiService _apiService = ApiService();
  var pages = 0.obs;
  var sd = "".obs;
  var noteModel = <NoteModel>[].obs;
  var isLoading = false.obs;
  var selectedId = 0.obs;
  var selectedNoteDetails = NoteDetailsModel().obs;

  Future<dynamic> getTodoList(int page) async {

    pages.refresh();

    print("value of page is ${page}");
    var returnedModel = await _apiService.getTodos(page);
    print("returnedModel is $returnedModel");
    if (returnedModel is List<NoteModel>) {
      noteModel.addAll(returnedModel);
      noteModel.refresh();
      print("first note is ${noteModel.value.length}");
      for(int i=0;i<noteModel.value.length;i++)
      print("first note is ${noteModel.value[noteModel.value.length-1].title}");
    }
  }

  void setNoteId(int id) async {
    isLoading(true);
   var returnedModel =await  _apiService.getTodoDetails(id);
   if(returnedModel is NoteDetailsModel){
      selectedNoteDetails(returnedModel);
      selectedNoteDetails.refresh();
   }
   isLoading(false);
  }
}
