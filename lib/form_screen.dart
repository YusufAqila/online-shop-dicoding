import 'package:flutter/material.dart';
import 'package:online_shop/model/shoes_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  final Product product;
  final int amount;
  const FormScreen({Key? key, required this.product, required this.amount})
      : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String? _name = '';
  String? _address = '';
  late int? _phone;
  String? _delivery = '';
  String? _note = '';
  late int _amount;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    _phone = 0;
    _amount = widget.amount;
    totalPrice = widget.amount * widget.product.price;
  }

  Future<void> launchWhatsapp(
      String? name,
      String? address,
      int? phone,
      String? delivery,
      String? note,
      String? title,
      int? amount,
      double? price,
      double? totalPrice) async {
    const String to = '6282322990172';
    final String url =
        'https://wa.me/$to?text=Form Pembelian\nNama: $name\nAlamat: $address\nNomor Telepon: ${phone.toString()}\nMetode Pengiriman: $delivery\nCatatan: $note\nProduk: $title (${amount}x $price) /nTotal: $totalPrice';
    Uri newUrl = Uri.parse(url);
    if (!await launchUrl(
      newUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Beli Langsung')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Shortcuts(
                shortcuts: const <ShortcutActivator, Intent>{
                  SingleActivator(LogicalKeyboardKey.space): NextFocusIntent(),
                },
                child: FocusTraversalGroup(
                  child: Form(
                    key: _formKey,
                    onChanged: () {
                      Form.of(primaryFocus!.context!).save();
                    },
                    child: Wrap(
                      children: [
                        TextFormField(
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Tulis nama penerima disini...',
                            labelText: 'Nama',
                          ),
                          onSaved: (String? value) {
                            setState(() {
                              _name = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi kolom ini';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Tulis alamat penerima disini...',
                            labelText: 'Alamat',
                          ),
                          onSaved: (String? value) {
                            setState(() {
                              _address = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi kolom ini';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Tulis nomor telepon penerima disini...',
                            labelText: 'Nomor Telepon',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSaved: (String? value) {
                            setState(() {
                              _phone =
                                  value != null ? int.tryParse(value) : null;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi kolom ini';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Pilih metode pengiriman',
                            labelText: 'Metode Pengiriman',
                          ),
                          onSaved: (String? value) {
                            setState(() {
                              _delivery = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi kolom ini';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            hintText: 'Tulis catatan untuk pengirim...',
                            labelText: 'Catatan',
                          ),
                          onSaved: (String? value) {
                            setState(() {
                              _note = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harap isi kolom ini';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Image.network(
                    widget.product.image,
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${_amount}x \$${widget.product.price.toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _amount = _amount + 1;
                              totalPrice = _amount * widget.product.price;
                            });
                          },
                          icon: const Icon(Icons.add)),
                      Text(_amount.toString()),
                      IconButton(
                          onPressed: () {
                            if (_amount > 1) {
                              setState(() {
                                _amount = _amount - 1;
                                totalPrice = _amount * widget.product.price;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove)),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      launchWhatsapp(
                          _name,
                          _address,
                          _phone,
                          _delivery,
                          _note,
                          widget.product.title,
                          _amount,
                          widget.product.price,
                          totalPrice);
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  child: const Text('Beli'))
            ],
          ),
        ),
      ),
    );
  }
}
