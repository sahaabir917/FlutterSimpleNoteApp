import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/todo_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _controller = RefreshController(initialRefresh: true);
  TodoController todoController = Get.put(TodoController());

  var page = 1;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notes"),
            ),
            body: SmartRefresher(
              controller: _controller,
              enablePullUp: true,
              onRefresh: () {
                print("refresh function called");

                _controller.refreshCompleted();
              },
              onLoading: () {
                print("onloading function called");
                page = page + 1;
                todoController.getTodoList(page);
                _controller.loadComplete();
              },
              child: Obx(() {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: todoController.noteModel.value.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding:
                              EdgeInsets.only(left: 0.02.sw, right: 0.02.sw),
                          child: InkWell(
                              onTap: () {
                                print(todoController
                                    .noteModel.value[index].title);
                                todoController.setNoteId(
                                    todoController.noteModel.value[index].id!);
                                print(
                                    "selected id is ${todoController.selectedId.value}");

                                Navigator.pushNamed(
                                    context, "/noteDetailsPage");
                              },
                              child: ItemCardNote(context, index)));
                    });
              }),
            ),
          );
        });
  }

  @override
  void initState() {
    page = page++;
    todoController.getTodoList(page);
    super.initState();
  }

  void onChanged(bool value) {}

  onchanging(bool value) {}

  Widget ItemCardNote(BuildContext context, int index) {
    return Card(
      color: Colors.yellowAccent,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 0.03.sh,),
            Row(
              children: [
                Container(

                  color: Colors.yellowAccent,
                  padding: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw,),
                  width: 0.8.sw,
                  child: Center(
                    child: Text(
                        todoController.noteModel.value[index].title.toString()),
                  ),
                ),
                Checkbox(
                    value: todoController.noteModel.value[index].completed,
                    onChanged: onchanging(true))
              ],
            ),
            SizedBox(height: 0.03.sh,),
          ],
        ),
      ),
    );
  }
}
