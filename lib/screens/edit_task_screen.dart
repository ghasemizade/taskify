import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dayofyear/widget/task_type_item.dart';
import 'package:dayofyear/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

import '../data/task.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode watcher1 = FocusNode();
  FocusNode watcher2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;
  DateTime? _time;
  final box = Hive.box<Task>('taskBox');

  int _selectedTaskTypeitem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    watcher1.addListener(() {
      setState(() {});
    });

    watcher2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskTypeitem = index;
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
                      labelText: 'توضییحات تسک',
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
                height: 200,
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
                  String taskTitle = controllerTaskTitle!.text;
                  String taskSubTitle = controllerTaskSubTitle!.text;
                  editTask(taskTitle, taskSubTitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ویرایش کردن تسک',
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

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskTypeitem];
    widget.task.save();
  }
}
