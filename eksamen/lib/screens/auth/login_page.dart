import 'package:eksamen/widgets/input_fields.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final BuildContext context;
  const Login({required this.context, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/logos/flutter.png'),
              ),
              Text(
                'Velkommen',
                style: Theme.of(context).textTheme.headline1!,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField1(hintText: '', labelText: 'Brukernavn'),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextField1(hintText: '', labelText: 'Passord')),
            ],
          ),
        ),
      ),
    );
  }
}
