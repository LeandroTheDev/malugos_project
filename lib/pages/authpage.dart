import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                color: Colors.black,
                height: 400,
                width: 300,
                child: Text('Test'),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
