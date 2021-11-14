import 'package:flutter/material.dart';
import 'package:shop_app/screen/admin/view_orders.dart';

import 'add_product.dart';
import 'manage_product.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(200, 227, 212, 1).withOpacity(0.5),
                      const Color.fromRGBO(135, 170, 170, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0, 1])),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const  AddProduct()));
                  },
                  child: const Text("Add Product"),
                  elevation: 5,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const  MangeProduct()));

                  },
                  child: const Text("Edit Product"),
                  elevation: 5,

                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ViewOrder.routName);
                  },
                  child: const Text("View Order"),
                  elevation: 5,

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
