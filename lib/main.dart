import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/ui/profile_screen.dart';

void main(){
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfileScreen(),
    );
  }
}