import '../data/task_type.dart';
import '../data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
        image: 'assets/Images/meditate.png',
        title: 'مدیتیشن',
        taskTypeEnum: TaskTypeEnum.foucs),
    TaskType(
        image: 'assets/Images/social_frends.png',
        title: 'فراغت',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        image: 'assets/Images/workout.png',
        title: 'ورزش',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'assets/Images/hard_working.png',
        title: 'کار',
        taskTypeEnum: TaskTypeEnum.working),
  ];

  return list;
}
