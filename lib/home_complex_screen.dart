import 'dart:convert';

import 'package:complex_api_01/models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenComplexAPI extends StatefulWidget {
  const HomeScreenComplexAPI({super.key});

  @override
  State<HomeScreenComplexAPI> createState() => _HomeScreenComplexAPIState();
}

class _HomeScreenComplexAPIState extends State<HomeScreenComplexAPI> {
  Future<ProductsModels> getProductModelsAPI() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/d9c80216-cc6f-4fb9-906b-c2a45598fc96'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModels.fromJson(data);
    } else {
      return ProductsModels.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complex API structure'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModels>(
                  future: getProductModelsAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot
                                        .data!.data![index].shop!.name
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.data![index].shop!.shopemail
                                        .toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.data![index].shop!.image
                                          .toString()),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot
                                            .data!.data![index].images!.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 1),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .images![position]
                                                              .url
                                                              .toString()))),
                                            ),
                                          );
                                        }),
                                  ),
                                  Icon(
                                      snapshot.data!.data![index].inWishlist! ==
                                              true
                                          ? Icons.favorite
                                          : Icons.favorite_outline),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Text('loading...');
                    }
                  }))
        ],
      ),
    );
  }
}
