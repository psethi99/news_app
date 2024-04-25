import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'home_page.dart';
import 'description.dart';
import 'setting_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set light mode by default
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark mode theme
      ),
      home: BlocProvider(
        create: (context) => DataBloc()..add(FetchData()),
        child: MyHomePage(),
      ),
      routes: {
        '/description': (context) => DescriptionPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
