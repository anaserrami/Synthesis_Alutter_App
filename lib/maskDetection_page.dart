import 'package:flutter/material.dart';

class MaskDetectionPage extends StatelessWidget {
  const MaskDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mask Detection'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Mask Detection'),
                content: const Text('I\'m still working on this page'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text(
            'Click here to see the message',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
