
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Demo Text');
    _controller.addListener(() {
      dev.log(_controller.value.text);
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _controllerClear() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                mouseCursor: SystemMouseCursors.text,
              ),
            ),
            ElevatedButton(onPressed: (){
              _controller.clear();
              _controller.text = 'Clear Demo Text';
            }, child: const Icon(Icons.abc, size: 25,)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controllerClear,
        tooltip: 'Increment',
        child: const Icon(Icons.clear_all),
      ),
    );
  }
}
