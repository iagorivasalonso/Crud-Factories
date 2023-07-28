import 'package:flutter/material.dart';

/// Flutter code sample for [Expanded].

void main() => runApp(const PrimeraScreen());

class PrimeraScreen extends StatelessWidget {
  const PrimeraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expanded Row Sample'),
        ),
        body: const ExpandedExample(),
      ),
    );
  }
}

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.amber,

          ),
          Container(
            color: Colors.yellow,

          ),
          Container(
            color: Colors.amber,

          ),
        ],
      ),
    );
  }

}