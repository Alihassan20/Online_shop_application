import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/model/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Products product) async {
    await _firestore.collection('Products').add({
      'ProductName': product.pName,
      'ProductPrice': product.pPrice,
      'ProductDescription': product.pDescription,
      'ProductCategory': product.pCategory,
      'ProductLocation': product.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProduct()  {
    return  _firestore.collection('Products').snapshots();
  }
  Stream<QuerySnapshot> loadOrder()  {
    return  _firestore.collection('Orders').snapshots();
  }
  Stream<QuerySnapshot> loadOrderDetails(DocumentId)  {
    return  _firestore.collection('Orders').doc(DocumentId).collection('OrderDetails').snapshots();
  }
  deleteProduct(ProductId){
    _firestore.collection('Products').doc(ProductId).delete();
  }
  editProduct(data, documentId) {
    _firestore
        .collection('Products')
        .doc(documentId)
        .update(data);
  }
  addDataToStore(data,List<Products> products){
     var docRef =_firestore.collection('Orders').doc();
     docRef.set(data);
     for(var product in products){
       docRef.collection('OrderDetails').doc().set(
           {
             'ProductName': product.pName,
             'ProductPrice': product.pPrice,
             'ProductCategory': product.pCategory,
             'ProductLocation': product.pLocation,
             'ProductNumber':product.number,

       });

     }
  }

}
