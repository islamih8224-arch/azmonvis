import 'package:flutter/material.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Comming Soon', style: TextStyle(fontSize: 24)),
            BackButton(),
          ],
        ),
      ),
    );
  }
}
