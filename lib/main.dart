import 'package:book_store/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: MaterialApp(
        title: 'Book Store',
        theme: ThemeData(primaryColor: Colors.deepOrange),
        home: HomeScreen(),
      ),
    );
  }
}
