import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dayofyear/widget/task_type_item.dart';
import 'package:dayofyear/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode watcher1 = FocusNode();
  FocusNode watcher2 = FocusNode();
  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selectedTaskTypeitem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watcher1.addListener(() {
      setState(() {});
    });

    watcher2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: watcher1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: watcher1.hasFocus
                            ? Color(0xff3C8DFF)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff3C8DFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskSubTitle,
                    maxLines: 2,
                    focusNode: watcher2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: watcher2.hasFocus
                            ? Color(0xff3C8DFF)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff3C8DFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: 'زمان تسک رو انتخاب کن',
                  negativeButtonText: 'حذف کن',
                  positiveButtonText: 'انتخاب زمان',
                  elevation: 2,
                  titleStyle: TextStyle(
                      color: Color(0xff3C8DFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  negativeButtonStyle: TextStyle(
                      color: Color.fromARGB(255, 218, 66, 24),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff3C8DFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  onPositivePressed: (context, time) {
                    _time = time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeitem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypeList()[index],
                        index: index,
                        selectedItemList: _selectedTaskTypeitem,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  String taskTitle = controllerTaskTitle.text;
                  String taskSubTitle = controllerTaskSubTitle.text;
                  addTask(taskTitle, taskSubTitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3C8DFF),
                  minimumSize: Size(200, 48),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  addTask(String taskTitle, String taskSubTitle) {
    var task = Task(
        title: taskTitle,
        subTitle: taskSubTitle,
        time: _time!,
        taskType: getTaskTypeList()[_selectedTaskTypeitem]);
    box.add(task);
  }
}
