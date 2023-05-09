import 'package:eksamen/screens/school_data/admin.dart';
import 'package:eksamen/screens/school_data/env.dart';
import 'package:eksamen/screens/school_data/it_staff.dart';
import 'package:eksamen/screens/school_data/students.dart';
import 'package:eksamen/screens/school_data/teachers.dart';
import 'package:flutter/material.dart';

class SchoolSystem extends StatelessWidget {
  const SchoolSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Katalog'),
      ),
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
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Teacher(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Miljøfagarbeidere'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EnvStaff(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Administrasjon'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Admin(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('IT-Medarbeidere'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ItStaff(),
              ),
            );
          },
        ),
      ],
    );
  }
}
