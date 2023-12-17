import 'package:flutter/material.dart';
import 'package:online_shop/model/shoes_list.dart';
import 'package:online_shop/form_screen.dart';

class DetailScreen extends StatefulWidget {
  final Product product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _amount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Center(
                    child: Image.network(widget.product.image, height: 200),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.product.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _amount = _amount + 1;
                            });
                          },
                          icon: const Icon(Icons.add)),
                      Text(_amount.toString()),
                      IconButton(
                          onPressed: () {
                            if (_amount > 1) {
                              setState(() {
                                _amount = _amount - 1;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove)),
                    ],
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen(product: widget.product, amount: _amount);
                  }));
                },
                child: const Text('Buy Now'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
