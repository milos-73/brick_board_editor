import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarWallSaved extends StatelessWidget {
  const SnackBarWallSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () {
          const snackWallSaved = SnackBar(
            content: Text('Hii this is GFG\'s SnackBar'),
            backgroundColor: Colors.green,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackWallSaved);
        },
        child: const Text('Click Here'),
      ),
    );
  }
}