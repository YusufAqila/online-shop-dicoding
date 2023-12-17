import 'package:flutter/material.dart';
import 'package:online_shop/model/shoes_list.dart';
import 'package:online_shop/search_screen.dart';
import 'package:online_shop/detail_screen.dart';

class MainScreen extends StatelessWidget {
  final String title;

  const MainScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MainScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchScreen(title: title);
              }));
            },
          ),
        ],
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const OnlineShopGrid(gridCount: 2);
          } else if (constraints.maxWidth <= 1200) {
            return const OnlineShopGrid(gridCount: 4);
          } else {
            return const OnlineShopGrid(gridCount: 6);
          }
        },
      ),
    );
  }
}

class OnlineShopGrid extends StatelessWidget {
  final int gridCount;

  const OnlineShopGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: gridCount,
      children: productList.map((product) {
        return Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(product: product);
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Ink.image(
                      image: NetworkImage(product.image),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
