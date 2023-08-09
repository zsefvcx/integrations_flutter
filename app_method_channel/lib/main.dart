
import 'dart:developer' as dev;

import 'package:app_method_channel/service.dart';
import 'package:flutter/material.dart';

import 'platforn_view_mobile.dart';

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
  final _service = PlatformService();
  late TextEditingController _controller;
  String text = 'Press any button';

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

  Future<void> _getStateData() async {
    text = '';
    setState(() {

    });
    await Future.delayed(const Duration(seconds: 1));
    text = await _service.callMethodChannel(_controller.value.text);
    setState(() {
    });
  }

  Future<void> _getStateData2() async {
    text = '';
    setState(() {

    });
    await Future.delayed(const Duration(seconds: 1));
    _service.callEventChanel(_controller.value.text).listen((event) {
      dev.log(event);
      setState(() {
        text = event;
      });
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
             //_controller.clear();
             // _controller.text = 'Clear Demo Text';
              if(!(text=='' || text=='0' || text=='1'  || text=='2'))_getStateData();
            }, child: const Text('Get from MethodChannel')),
            ElevatedButton(onPressed: (){
              //_controller.clear();
              // _controller.text = 'Clear Demo Text';
              if(!(text=='' || text=='0' || text=='1'  || text=='2'))_getStateData2();
            }, child: const Text('Get from EventChannel')),
            Center(
              child: Text(text),
            ),
            if(!(text=='' || text=='0' || text=='1'  || text=='2'))SizedBox(
              height: 100,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PlatformViewMobile(data: text),
              ),
            ),
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

