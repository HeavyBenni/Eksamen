import 'package:eksamen/screens/school_data/school_categories.dart';
import 'package:flutter/material.dart';

class SchoolSystem extends StatelessWidget {
  const SchoolSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: SchoolList(),
      ),
    );
  }
}

class SchoolList extends StatelessWidget {
  const SchoolList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Elever'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Elev(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Lærere'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Miljøfagarbeidere'),
          onTap: () {},
        ),
        ListTile(
          title: Text('Administrasjon'),
          onTap: () {},
        ),
        ListTile(
          title: Text('IT-Medarbeidere'),
          onTap: () {},
        ),
      ],
    );
  }
}
