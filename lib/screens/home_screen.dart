import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dayofyear/screens/add_task_screen.dart';
import 'package:dayofyear/widget/task_widget.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../data/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = '';
  var controller = TextEditingController();

  var box = Hive.box('names');
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    Jalali now = Jalali.now();
    String monthName = now.formatter.mN;
    int day = now.day;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/Images/avatar.jpg',
                  width: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Text(
                              'سلام، ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'حسین',
                              style: TextStyle(
                                color: Color(0xff3C8DFF),
                                fontSize: 18,
                                fontFamily: 'SHB',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/Images/waving_hand.png',
                          width: 20,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: Color.fromARGB(185, 128, 128, 128),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          monthName,
                          style: TextStyle(
                            color: Color.fromARGB(185, 128, 128, 128),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Container(
                  width: 100,
                  height: 30,
                  color: Color(0xffE2F6F1),
                  child: Center(
                    child: Text(
                      'تسکیفای',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff3C8DFF),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskBox.listenable(),
          builder: (context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notif) {
                setState(() {
                  if (notif.direction == ScrollDirection.forward) {
                    isFabVisible = true;
                  }
                  if (notif.direction == ScrollDirection.reverse) {
                    isFabVisible = false;
                  }
                });

                return true;
              },
              child: ListView.builder(
                itemCount: taskBox.values.length,
                itemBuilder: ((context, index) {
                  var task = taskBox.values.toList()[index];
                  print(task.taskType.title);
                  return getListItem(task);
                }),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(),
              ),
            );
          },
          backgroundColor: Color(0xff3C8DFF),
          child: Image.asset('assets/Images/icon_add.png'),
        ),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          task.delete();
        },
        child: TaskWidget(task: task));
  }
}
