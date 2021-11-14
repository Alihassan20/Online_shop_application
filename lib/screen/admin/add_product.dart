import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';

import '../../store.dart';
class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  final _formKey = GlobalKey<FormState>();
  var store =Store();
  @override
  Widget build(BuildContext context) {
    String _name="";
    String _price="";
    String _description="";
    String _category="";
    String _location="";


    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.teal,
                    hintText:"Product Name" ,
                    filled: true,
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "valid";
                    }
                    return null;
                  },
                  onSaved:(val){
                    setState(() {
                      _name=val!;
                    });

                  } ,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.teal,
                    hintText:"Product Price" ,
                    filled: true,
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "valid";
                    }
                    return null;
                  },
                  onSaved:(val){
                    setState(() {
                      _price=val!;
                    });

                  } ,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.teal,
                    hintText:"Product Description" ,
                    filled: true,
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "valid";
                    }
                    return null;
                  },
                  onSaved:(val){
                    setState(() {
                      _description=val!;
                    });

                  } ,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.teal,
                    hintText:"Product Category" ,
                    filled: true,
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "valid";
                    }
                    return null;
                  },
                  onSaved:(val){
                    setState(() {
                      _category=val!;
                    });

                  } ,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.teal,
                    hintText:"Product Location" ,
                    filled: true,
                    border:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "valid";
                    }
                    return null;
                  },
                  onSaved:(val){
                    setState(() {
                      _location=val!;
                    });

                  } ,
                ),
                RaisedButton(
                  elevation: 2,
                  color:Colors.teal,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  onPressed: () {
                    //final user=  FirebaseAuth.instance.currentUser!.uid;
                    //final uxer=FirebaseFirestore.instance.doc(user).id;
                    if(_formKey.currentState!.validate()){
                      FocusScope.of(context).unfocus();
                      _formKey.currentState!.save();
                      store.addProduct(Products(
                          pName: _name,
                          pPrice: _price,
                          pDescription: _description,
                          pCategory: _category,
                          pLocation: _location,
                          ));
                    }
                  },child:const  Text("Add Product"),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}


