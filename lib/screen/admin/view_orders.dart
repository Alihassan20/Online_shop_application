import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/order.dart';
import 'package:shop_app/store.dart';

import 'order_details.dart';

class ViewOrder extends StatelessWidget {
  static const routName = "/view";


  const ViewOrder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _store=Store();

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:_store.loadOrder() ,
        builder: ( context,  snapshot)
        {
          if(!snapshot.hasData){
            return Center(
              child: Text("No Exist Order"),
            );
          }else{
            List<Order> ordrs=[];
            for(var doc in snapshot.data!.docs){
              var data = doc;
              ordrs.add(
                  Order(
                      Address:data['TotalAddress'],
                      totalPrise:data['TotalPrice'],
                      documentId: data.id)
              );
            }
            return ListView.builder(
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, OrderDetails.routName,arguments: ordrs[index].documentId);
                      },
                      child: Container(
                        color: Colors.grey,
                        height: MediaQuery.of(context).size.height*.2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Price = \$ ${ordrs[index].totalPrise}",
                                style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              const SizedBox(height: 10),
                              Text("The Address Is :  ${ordrs[index].Address}"
                                  ,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20))

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            itemCount:ordrs.length ,);

          }
        },
      ),
    );
  }
}
