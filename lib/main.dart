import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dayofyear/screens/home_screen.dart';

import 'data/task.dart';
import 'data/task_type.dart';
import 'data/type_enum.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('names');
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('fa'),
      supportedLocales: [Locale('fa')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SH',
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'SHB',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
