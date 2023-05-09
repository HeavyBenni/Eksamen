import 'package:eksamen/screens/school_data/school_data_page.dart';
import 'package:flutter/material.dart';

class DrawerA extends StatelessWidget {
  const DrawerA({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Meny'),
          ),
          ListTile(
            title: const Text('Ansatte og Elever'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SchoolSystem(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
