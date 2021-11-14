
import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';

import '../../store.dart';

class EditProduct extends StatefulWidget {
  static const routName="/edit";
  const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();
  var store = Store();
  @override
  Widget build(BuildContext context) {
    String _name = "";
    String _price = "";
    String _description = "";
    String _category = "";
    String _location = "";
    Products? product = ModalRoute.of(context)!.settings.arguments as Products?;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.teal,
                              hintText: "Product Name",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "valid";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                _name = val!;
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.teal,
                              hintText: "Product Price",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "valid";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                _price = val!;
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.teal,
                              hintText: "Product Description",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "valid";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                _description = val!;
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.teal,
                              hintText: "Product Category",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "valid";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                _category = val!;
                              });
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.teal,
                              hintText: "Product Location",
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "valid";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                _location = val!;
                              });
                            },
                          ),
                          RaisedButton(
                            elevation: 2,
                            color:Colors.teal,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            onPressed: () async {
                              //final user=  FirebaseAuth.instance.currentUser!.uid;
                              //final uxer=FirebaseFirestore.instance.doc(user).id;
                              if(_formKey.currentState!.validate()){
                                FocusScope.of(context).unfocus();
                                _formKey.currentState!.save();
                               await store.editProduct({
                                 'ProductName': _name,
                                 'ProductPrice': _price,
                                 'ProductDescription': _description,
                                 'ProductCategory': _category,
                                 'ProductLocation': _location
                               }, product!.Pid);

                              }
                            },child:const  Text("Add Product"),)
                        ])))));
  }
}
