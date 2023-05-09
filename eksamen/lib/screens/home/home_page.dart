import 'package:eksamen/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerA(),
      appBar: AppBar(),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}