import 'package:flutter/material.dart';
import 'package:shop_app/screen/sign_up.dart';

import 'login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;



    return  Scaffold(
      body:  Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(200, 227, 212, 1).withOpacity(0.5),
                      const Color.fromRGBO(135, 170, 170, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0, 1])),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: Stack(
                  alignment: Alignment.center,
                  children:[
                    Image.asset('assets/shoop.png',height: 250,width: 250,),
                    const Positioned(
                      bottom: 0,
                      child:  Text(
                        "Online Shop",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30, color: Colors.black),
                      ),),],),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(onPressed: (){
                    Navigator.of(context).pushReplacement
                      (MaterialPageRoute(builder: (_)=>const Login()));
                  }, child: const Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  const Text('OR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  FlatButton(onPressed: (){
                    Navigator.of(context).pushReplacement
                      (MaterialPageRoute(builder: (_)=>const SignUp()));
                  }, child: const Text('SignUp',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                ],
              )
            ],
          ),

        ],
      )
    );
  }
}
