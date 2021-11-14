import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/store.dart';
class OrderDetails extends StatelessWidget {
  static const routName='/details';
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _store = Store();
    Object? documentId = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(documentId),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(child: Text("Loading Order Details"),);
          }else{
            List<Products> products = [];
            for(var doc in snapshot.data!.docs){
              var data = doc;
              products.add(Products(
                pName: data['ProductName'],
                number: data['ProductNumber'],
                pCategory: data['ProductCategory'],
              ));
            }
            return  Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder:(context,index)=> Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height*.2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Name =  ${products[index].pName}",
                                style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              const SizedBox(height: 10),
                              Text("Quantity :  ${products[index].number}"
                                  ,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              const SizedBox(height: 10),
                              Text("Product Category :  ${products[index].pCategory}"
                                  ,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20))

                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: products.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(
                      child: ButtonTheme(
                        buttonColor: Colors.cyan,
                          child: RaisedButton(onPressed: (){},child:const  Text("Confirm Orders"),)),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: ButtonTheme(
                          buttonColor: Colors.cyan,
                          child: RaisedButton(onPressed: (){},child:const  Text("Delete Orders"),)),
                    )
                  ],),
                )
              ],
            );
          }
        }
      ),
    );
  }
}
