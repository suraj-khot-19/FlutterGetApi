import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  Future<void> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex Api Without JSON Model"),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loadding...."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ReuseRow(
                              title: 'name',
                              value: data[index]['name'].toString(),
                            ),
                            ReuseRow(
                              title: 'username',
                              value: data[index]['username'].toString(),
                            ),
                            ReuseRow(
                              title: 'Zip-Code',
                              value:
                                  data[index]['address']['zipcode'].toString(),
                            ),
                            ReuseRow(
                              title: 'geo',
                              value: data[index]['address']['geo'].toString(),
                            ),
                            ReuseRow(
                              title: 'email',
                              value: data[index]['email'].toString(),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  final String title;
  final String value;
  const ReuseRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
