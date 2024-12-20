import 'package:flutter/material.dart';
import 'package:dayofyear/screens/edit_task_screen.dart';

import '../data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: getMainContent(),
        ),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      value: isBoxChecked,
                      checkColor: Colors.white,
                      activeColor: Color(0xff3C8DFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      onChanged: (isChecked) {},
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          widget.task.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      widget.task.subTitle,
                    ),
                  ),
                ),
              ),
              Spacer(),
              getTimeAndEditBadgs()
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 90,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xff3C8DFF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Row(
              children: [
                Text(
                  '${widget.task.time.hour}:${getMinUndterTen(widget.task.time)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('assets/Images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                      task: widget.task,
                    )));
          },
          child: Container(
            width: 100,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(color: Color(0xff3C8DFF)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset('assets/Images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMinUndterTen(DateTime time) {
    if (time.minute < 10) {
      //9-1
      return '0${time.minute}'; //9 09 8 08 0 00
    } else {
      return time.minute.toString();
    }
  }
}
