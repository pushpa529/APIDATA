import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = '';

  // Function to call the API
  Future<void> _ApiData() async {
    final url = Uri.parse('https://api.github.com/users/mralexgray/repos');  // Example API
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        var data = jsonDecode(response.body);
        setState(()  {
           for (var demo = 0; demo < data.length; demo++) {
          _response += 'NAME: ${data[demo]['name']} \n';
          _response += 'AVTAR: ${data[demo]['owner']['avatar_url']} \n';
          _response += 'NODEID: ${data[demo]['node_id']} \n';
           } // Display title of the first post
          // var apiDataDecoded = json.decode(response.body).cast<Map<String,dynamic>>();
          // List<ApiData> apiDataList = await apiDataDecoded.map<ApiData>((json) => ApiData.fromJson(json)).toList();
          //
          //  print(apiDataList);

        });
      } else {
        setState(() {
          _response = 'Failed to load data';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data Fetching')
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed:_ApiData,
                child: Text('Fetch API details'),

              ),
              SizedBox(height: 20),
              Container(
                child: Column(children: [
                  Text(
                    _response ,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ApiData {
  factory ApiData.fromJson(Map<String,dynamic> json){
    return ApiData(nodeId: json['nodeId'], avtarUrl: json['avtarUrl'], name: json['name']);
  }
  ApiData({required this.nodeId,
    required this.avtarUrl,
    required this.name,
  });
  String nodeId = '';
  String name = '';
  String avtarUrl = '';
}
