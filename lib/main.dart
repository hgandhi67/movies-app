import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/model/tv_shows_db_model.dart';
import 'package:movies_app/src/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// init hive storage
  await Hive.initFlutter();

  Hive.registerAdapter(TvShowsDbModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
