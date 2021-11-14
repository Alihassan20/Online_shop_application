import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/screen/admin/edit_product.dart';
import 'package:shop_app/store.dart';
import 'package:shop_app/widget/custom_menu.dart';

import '../../auth.dart';

class MangeProduct extends StatefulWidget {
  const MangeProduct({Key? key}) : super(key: key);

  @override
  _MangeProductState createState() => _MangeProductState();
}

class _MangeProductState extends State<MangeProduct> {
  final _store = Store();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context,snapShot) {
          List<Products> product = [];
          if(snapShot.hasData){
            for (var doc in snapShot.data!.docs) {
              var data = doc;
              product.add(Products(
                Pid:doc.id,
                pName: data['ProductName'],
                pPrice: data['ProductPrice'],
                pDescription: data['ProductDescription'],
                pCategory: data['ProductCategory'],
                pLocation: data['ProductLocation'],

              ));}
            return GridView.builder(

              itemBuilder: (context, index) => GestureDetector(
                onTapUp: (details) async {
                  double dx =details.globalPosition.dx ;
                  double dy =details.globalPosition.dy ;
                  double dx2 =MediaQuery.of(context).size.width - dx ;
                  double dy2 =MediaQuery.of(context).size.width - dy ;

                 await showMenu(context: context, position:  RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        MyPopupMenuItem(
                         onClick: (){
                           Navigator.pushNamed(context,EditProduct.routName,arguments:product[index] );
                     },
                     child: const Text("Edit")),
                        MyPopupMenuItem(onClick: (){
                          print("delete");
                          setState(() {
                            _store.deleteProduct(product[index].Pid);
                            Navigator.pop(context);
                          });
                        },
                            child:const  Text("Delete")),

                  ]);
                },
                child: Stack(
                  children: [
                    Positioned.fill(child: Image(
                        image: AssetImage(product[index].pLocation!))),
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
                            Text(product[index].pName!,style:const  TextStyle(fontWeight: FontWeight.bold),),
                            Text('\$ ${product[index].pPrice}',style:const  TextStyle(fontWeight: FontWeight.bold),),


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              itemCount: product.length,
              gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount
                (crossAxisCount: 2,childAspectRatio: 0.8,crossAxisSpacing: 5,mainAxisSpacing: 5
              ),
            );

          } else{
            return const Center(child:  Text("loading"));
          }
        }
      ),
    );
  }
}

