import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/provider/cart_item.dart';
import 'package:shop_app/screen/admin/edit_product.dart';
import 'package:shop_app/screen/admin/order_details.dart';
import 'package:shop_app/screen/admin/view_orders.dart';
import 'package:shop_app/screen/login.dart';
import 'package:shop_app/screen/user/cart_screen.dart';
import 'package:shop_app/screen/user/home_page.dart';
import 'package:shop_app/screen/user/product_info.dart';
import 'package:provider/provider.dart';

import 'screen/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartItem>(create: (_) => CartItem()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        EditProduct.routName:(context)=> const EditProduct(),
        ProductInfo.routName:(context)=> const ProductInfo(),
        CartScreen.routName:(context)=> const CartScreen(),
        ViewOrder.routName:(context)=> const ViewOrder(),
        OrderDetails.routName:(context)=>const OrderDetails(),
      },

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const HomePage();
          }
          return const AuthScreen();
        }
      ),
    );
  }
}

