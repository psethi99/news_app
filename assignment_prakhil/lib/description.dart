import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DescriptionArguments args =
        ModalRoute.of(context)!.settings.arguments as DescriptionArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(args.image),
            SizedBox(height: 20),
            Text(args.description),
          ],
        ),
      ),
    );
  }
}

class DescriptionArguments {
  final String image;
  final String description;

  DescriptionArguments({required this.image, required this.description});
}
