import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simp_api/simp_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final simp = SimpApi.instance;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: onButtonTap,
              child: const Text('Make HTTP request!'),
            ),
            TextButton(
              onPressed: onImageButtonTap,
              child: const Text('Upload Image!'),
            ),
            TextButton(
              onPressed: onFilesButtonTap,
              child: const Text('Upload files!'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> onButtonTap() async {
    final res = await simp.sendRequest(
      requestType: RequestType.GET,
      url: 'https://catfact.ninja/fact',
    );

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Text(
            res.statusCode.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> onImageButtonTap() async {
    final res = await simp.uploadImage(
      filesRequestType: FilesRequestType.PUT,
      url: '',
      imageFile: File('image_path'),
    );

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Text(
            res.statusCode.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> onFilesButtonTap() async {
    final res = await simp.uploadFiles(
      filesRequestType: FilesRequestType.PUT,
      url: '',
      files: [
        File('file1_path'),
        File('file2_path'),
        File('file3_path'),
      ]
    );

    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          content: Text(
            res.statusCode.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
