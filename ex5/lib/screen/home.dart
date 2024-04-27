import 'dart:convert';
import 'package:ex5/Model/productModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;
  Future<ProductsModel> getProduct() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/cdfc1910-a198-4681-af8d-244af6a66251'));
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Center(child: Text("Get Api 5")),
        backgroundColor: Colors.blue,
      ),
      body: Expanded(
        child: FutureBuilder<ProductsModel>(
          future: getProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 50),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name
                                .toString()),
                            subtitle: Text(snapshot
                                .data!.data![index].shop!.shopemail
                                .toString()),
                            leading: CircleAvatar(
                              child: Image.network(snapshot
                                  .data!.data![index].shop!.image
                                  .toString()),
                            ),
                            trailing: const Icon(
                              Icons.shop,
                              semanticLabel: "shop now",
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot
                                              .data!
                                              .data![index]
                                              .images![position]
                                              .url
                                              .toString()),
                                        ),
                                      ),
                                      child: Text(
                                        "Price:${snapshot.data!.data![index].price}",
                                        style: const TextStyle(
                                            backgroundColor: Colors.white,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Icon(snapshot.data!.data![index].inWishlist == true
                              ? (Icons.favorite)
                              : Icons.favorite_border_outlined)
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
