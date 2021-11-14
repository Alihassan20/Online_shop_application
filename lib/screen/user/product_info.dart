import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/provider/cart_item.dart';

import 'cart_screen.dart';

class ProductInfo extends StatefulWidget {
  static const routName="/info";

  const ProductInfo({Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int numOfProduct=1;
  add(val){
    setState(() {
      numOfProduct=val;
    });
    numOfProduct++;
  }

  sub(val){

    if(numOfProduct>0){
      setState(() {
        numOfProduct=val;
      });
      numOfProduct--;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Products? product = ModalRoute.of(context)!.settings.arguments as Products?;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
               image: AssetImage(product!.pLocation!),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:   [
                IconButton(icon:const Icon(Icons.arrow_back_ios,size: 20,),onPressed: (){
                  Navigator.of(context).pop();
                }, ),
                GestureDetector(child: const Icon( Icons.shopping_cart,size: 35,),onTap: (){
                  Navigator.pushNamed(context, CartScreen.routName);
                },)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width*0.43,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(product.pName!,style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 8),
                            Text('\$ ${product.pPrice!}',style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 8),
                            Text(product.pCategory!,style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(heroTag: 'tag1',onPressed: ()=>add(numOfProduct),backgroundColor: Colors.cyan,child:
                                  const Text("+",style: TextStyle(fontSize: 50,color: Colors.black)),),
                                Text(numOfProduct.toString(),style:const  TextStyle(fontSize: 50,color: Colors.black),),
                                FloatingActionButton(heroTag: 'tag2',onPressed: ()=>sub(numOfProduct),backgroundColor: Colors.cyan,child:
                                const Text("-",style: TextStyle(fontSize: 50,color: Colors.black))),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    minWidth: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height*0.1,
                    child: Builder(
                      builder: (context) {
                        return RaisedButton
                          (elevation: 15,
                          color: Colors.cyan,
                          onPressed: ()
                          {
                            CartItem cartItem =Provider.of<CartItem>(context,listen: false);
                            product.number = numOfProduct;
                            bool exist = false;
                            var productInCarts= cartItem.product;
                            for(var productInCart in productInCarts ){
                              if(productInCart.pLocation==product.pLocation){
                                exist=true;
                              }
                            }
                            if(exist){
                              Scaffold.of(context).showSnackBar(const SnackBar(content:  Text("This Item Added To Chart Before")));
                            }else{
                              cartItem.addProduct(product);
                              Scaffold.of(context).showSnackBar(const SnackBar(content:  Text("Added To Chart")));
                            }
                          },child: const Text("Add To Chart"),);
                      }
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
