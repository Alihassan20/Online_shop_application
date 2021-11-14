import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/login.dart';
import 'package:shop_app/screen/user/product_info.dart';

import '../../auth.dart';
import '../../store.dart';
import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<HomePage> {
  final _store = Store();
  final _auth = Auth();
  int selection = 0;
  int _tabBarIndex = 0;
  int _tabBottomIndex = 0;
  List<Products> _products = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: _tabBottomIndex,
              onTap: (value) {
                setState(() {
                  _tabBottomIndex = value;
                });
              },
              fixedColor: Colors.deepPurple,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                    title: Text("Text1"), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text("Text2"), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text("Text3"), icon: Icon(Icons.person)),
              ],
            ),
            appBar: AppBar(
              elevation: 5,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Text(
                    "Jeans",
                    style: TextStyle(
                      color:
                          _tabBarIndex == 0 ? Colors.black : Colors.deepPurple,
                      fontSize: _tabBarIndex == 0 ? 20 : null,
                    ),
                  ),
                  Text("T-shirt",
                      style: TextStyle(
                        color: _tabBarIndex == 1
                            ? Colors.black
                            : Colors.deepPurple,
                        fontSize: _tabBarIndex == 1 ? 20 : null,
                      )),
                  Text("Jaket",
                      style: TextStyle(
                        color: _tabBarIndex == 2
                            ? Colors.black
                            : Colors.deepPurple,
                        fontSize: _tabBarIndex == 2 ? 20 : null,
                      )),
                  Text("Kap",
                      style: TextStyle(
                        color: _tabBarIndex == 3
                            ? Colors.black
                            : Colors.deepPurple,
                        fontSize: _tabBarIndex == 3 ? 20 : null,
                      )),
                ],
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
              ),
            ),
            body: TabBarView(
              children: [
                JenseView(),
                tShirt(),
                Jacket(),
                Cap(),
              ],
            ),
          ),
        ),
        Material(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Category",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                PopupMenuButton(
                    color: Colors.grey,
                    elevation: 20,
                    enabled: true,
                    onSelected: (val) async {
                      setState(() {
                        selection = val as int;
                      });
                      if (selection == 1) {
                        await _auth.logout();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const Login()));
                      } else {
                        Navigator.pushNamed(context, CartScreen.routName);
                      }
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: selection + 1,
                            child: const Icon(Icons.logout),
                          ),
                          PopupMenuItem(
                            value: selection,
                            child: const Icon(Icons.shopping_cart),
                          ),
                        ])
              ],
            ),
          ),
        )
      ],
    );
  }

////////////////////////////////////////
  Widget JenseView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapShot) {
          List<Products> product = [];
          if (snapShot.hasData) {
            for (var doc in snapShot.data!.docs) {
              var data = doc;
              product.add(Products(
                Pid: doc.id,
                pName: data['ProductName'],
                pPrice: data['ProductPrice'],
                pDescription: data['ProductDescription'],
                pCategory: data['ProductCategory'],
                pLocation: data['ProductLocation'],
              ));
            }
            _products = [...product];
            product.clear();
            product = getProductByCategory('Jense');

            return gridView(product);
          } else {
            return const Center(child: Text("loading"));
          }
        });
  }

  Widget tShirt() {
    List<Products> product = [];
    product = getProductByCategory('Shirt');
    return gridView(product);
  }

  Widget Jacket() {
    List<Products> product = [];
    product = getProductByCategory('Jacket');
    return gridView(product);
  }

  Widget Cap() {
    List<Products> product = [];
    product = getProductByCategory('Cap');
    return gridView(product);
  }

//////////////////////////////////////

  GridView gridView(List<Products> product) {
    return GridView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductInfo.routName,
              arguments: product[index]);
        },
        child: Stack(
          children: [
            Positioned.fill(
                child: Image(image: AssetImage(product[index].pLocation!))),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.white54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product[index].pName!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$ ${product[index].pPrice}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      itemCount: product.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
    );
  }

  List<Products> getProductByCategory(String s) {
    List<Products> products = [];
    try {
      for (var product in _products) {
        if (product.pCategory == s) {
          products.add(product);
        }
      }
    } on Error catch (ex) {}
    return products;
  }
}
