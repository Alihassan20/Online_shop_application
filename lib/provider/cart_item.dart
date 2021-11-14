import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/product.dart';

class CartItem extends ChangeNotifier{
  List<Products> product = [];
  addProduct(Products products){
    product.add(products);
    notifyListeners();
  }
  deleteProduct(Products products){
    product.remove(products);
    notifyListeners();
  }
}