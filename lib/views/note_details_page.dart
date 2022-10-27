import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/todo_controller.dart';

class NoteDetailsPage extends StatefulWidget {
  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Note Details Page"),
                actions: <Widget>[
                  Obx(() {
                    return Checkbox(
                      value: Get.find<TodoController>()
                          .selectedNoteDetails
                          .value
                          .completed,
                      onChanged: onChanged(true),
                    );
                  })
                ],
              ),
              body: Obx(() {
                return todoController.isLoading.value == false?

                  Container(
                  color: Colors.yellowAccent,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 0.1.sh,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.04.sw,right: 0.04.sw),
                          child: Text(
                            todoController.selectedNoteDetails.value.title
                                .toString(),
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.03.sh,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Note Id : ${todoController.selectedNoteDetails.value.id}",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Noted By : ${todoController.selectedNoteDetails.value.userId}",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                ):Center(
                  child: CircularProgressIndicator(),
                );
              }));
        });
  }

  onChanged(bool value) {}
}
