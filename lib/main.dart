import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'model/strategie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getStrategies(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Strategy> data = snapshot.data;
            return ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(strategy: data[index])));
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Container(
                        child: Center(
                          child: Text('${data[index].name}'),
                        ),
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                  );
                });
          }
          return SizedBox();
        },
      ),
    );
  }

  Future<List<Strategy>?> getStrategies() async {
    final jsonData = await rootBundle.rootBundle
        .loadString('jsonfile/betting_strategy.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Strategy.fromJson(e)).toList();
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.strategy}) : super(key: key);
  final Strategy strategy;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${widget.strategy.name}'),
      ),
    );
  }
}
