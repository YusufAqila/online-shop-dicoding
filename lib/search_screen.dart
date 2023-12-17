import 'package:flutter/material.dart';
import 'package:online_shop/model/shoes_list.dart';
import 'package:online_shop/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String searchValue = "";
  late Future<void> delayedSearch;
  @override
  void initState() {
    super.initState();
    delayedSearch = Future<void>.delayed(const Duration(seconds: 1), () {});
  }

  void startDelayedSearch(String value) {
    delayedSearch = Future<void>.delayed(const Duration(seconds: 1), () {
      setState(() {
        searchValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var productListFiltered = productList.where((product) =>
        product.title.toLowerCase().contains(_controller.text.toLowerCase()));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SearchScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Cari sesuatu disini...',
          ),
          onChanged: (String value) {
            // cancel existing delayedSearch
            delayedSearch =
                Future<void>.delayed(const Duration(seconds: 1), () {});

            // start a new delayedSearch
            startDelayedSearch(value);
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            onPressed: () {
              // change value
              _controller.text = "";
              // setstate to tell flutter for rebuild widget
              setState(() {});
            },
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: _controller.text != ""
            ? productListFiltered.toList().isNotEmpty
                ? productListFiltered.map((product) {
                    return Card(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(0),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: const BorderSide(color: Colors.grey, width: 0.4),
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(product: product);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }).toList()
                : [
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      "Tidak dapat menemukan",
                      textAlign: TextAlign.center,
                    ),
                  ]
            : [
                const SizedBox(),
              ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
