import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/provider/cart_item.dart';
import 'package:shop_app/screen/user/product_info.dart';
import 'package:shop_app/store.dart';
import 'package:shop_app/widget/custom_menu.dart';
class CartScreen extends StatefulWidget {
  static const routName="/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final high = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appBarHight=AppBar().preferredSize.height;
    final stutsAppBar=MediaQuery.of(context).padding.top;


    List<Products> products = Provider.of<CartItem>(context).product;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 5,
        title: const  Text("My Cart",style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
        leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder:(context,_){
              if(products.isNotEmpty){
              return Container(
                height: high-stutsAppBar-appBarHight-(high*.08),
                child: ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding:const  EdgeInsets.all(15),
                    child: GestureDetector(
                      onTapUp: (details){
                        showCustomMenu(details,context,products[index]);
                      },
                      child: Container(
                        color: Colors.grey,
                        height: high*.14,
                        width: width,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: high*.08,
                              backgroundImage:AssetImage(products[index].pLocation!),backgroundColor: Colors.white,),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(products[index].pCategory!,style: const TextStyle(fontWeight: FontWeight.bold),),
                                      Text(products[index].pPrice!,style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text(products[index].pName!,style: const TextStyle(fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(products[index].number!.toString(),style: const TextStyle(fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            )
                          ],

                        ),
                      ),
                    ),
                  );
                },itemCount: products.length,),
              );}else{
                return Container(
                  height: high-(high*.08)-appBarHight-stutsAppBar,
                  child: const Center(
                    child:  Text("Cart Is Empty"),
                  ),
                );
              }
            }
          ),
          Builder(
            builder: (context) {
              return ButtonTheme(
                shape:const  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                minWidth: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.height*0.08,
                child:RaisedButton
                        (elevation: 15,
                        color: Colors.cyan,
                        onPressed: ()
                        {
                          showDialogCustom(products,context);
                          FocusScope.of(context).unfocus();

                        },child: const Text("Order"),)
                );
            }
          ),


        ],
      ),

    );
  }

}
final _store = Store();

void showDialogCustom(List<Products>products,context)
 async {
  var  address;
  var prise=getTotalPrise(products);
   AlertDialog alertDialog = AlertDialog(
     actions: [
       MaterialButton(onPressed: (){

        try{
          _store.addDataToStore(
              {
                'TotalPrice': prise,
                'TotalAddress':address,
              }, products);
          Scaffold.of(context).showSnackBar(
              const SnackBar(duration: Duration(seconds: 2),content: Text("Orderd Successfully")));
          Navigator.of(context).pop();
        }catch(e){

        }
       },child: const Text("Confirm"),)
     ],
     content:  TextField(
       onChanged: (val){
         address=val;
       },
       decoration: const InputDecoration(
         hintText: 'Enter Your Address'
       ),
     ),
     title:  Text("Totall Price = \$ $prise"),);
   await showDialog(context: context, builder: (context){
     return alertDialog ;
   });
}

getTotalPrise(List<Products>products) {
  var price = 0;
  for( var product in products){
    price += product.number!* int.parse(product.pPrice!);
  }return price;
}

void showCustomMenu(details,context,product)async {
  double dx =details.globalPosition.dx ;
  double dy =details.globalPosition.dy ;
  double dx2 =MediaQuery.of(context).size.width - dx ;
  double dy2 =MediaQuery.of(context).size.width - dy ;

  await showMenu(context: context, position:  RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
            onClick: (){
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.routName,arguments: product);
            },
            child: const Text("Edit")),
        MyPopupMenuItem(
            onClick: (){
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);
        },
            child:const  Text("Delete")),

      ]);
}

