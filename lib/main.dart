import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_db/pages/home_page.dart';
import 'package:local_db/provider/donor_list_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter('hive_boxes');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DonorListProvider()),
      ],
      child: const MyApp(),
    ),
  );
  // const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Blood',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.red[100],
      ),
      home: const HomePage(),
    );
  }
}
