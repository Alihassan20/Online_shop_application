import 'package:flutter/material.dart';
import 'package:shop_app/screen/sign_up.dart';
import 'package:shop_app/screen/user/home_page.dart';

import '../auth.dart';
import 'admin/admin.dart';
class Login extends StatefulWidget {
  static const  routeName="/Login";
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
enum SingingCharacter { Admin, User }

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final authintication = Auth();
  String _email='';
  String _password='';
  SingingCharacter _character = SingingCharacter.User;

  final _passwordController = TextEditingController();
  var _isLoading = false;
  _submit () async {
    final validate = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validate) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading=true;
        });
        final response = await authintication.login(_email.trim(), _password.trim());
        setState(() {
          _isLoading=false;
        });

      }catch(e){

      }
    }}
  @override
  Widget build(BuildContext context) {


    final device = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height:device.height*0.3,
                  child: Stack(
                    alignment: Alignment.center,
                    children:[
                      Image.asset('assets/shoop.png',height: 200,width: 200,),
                      const Positioned(
                        bottom: 0,
                        child:  Text(
                          "Online Shop",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30, color: Colors.black),
                        ),),],),
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                      key: _formKey,
                      child:Column(
                          children: [
                            TextFormField(
                              decoration:const  InputDecoration(
                                errorBorder: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "E_Mail",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val){
                                if(val!.isEmpty||!val.contains('@')){
                                  return 'Valid Email Address';
                                }return null;
                              },
                              onSaved: (val){
                               _email=val!;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration:const  InputDecoration(
                                errorBorder: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.visibility),
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "Password",
                              ),
                              obscureText: true,
                              controller:_passwordController ,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (val){
                                if(val!.isEmpty||val.length < 5){
                                  return 'Password Is too Short';
                                }return null;
                              },
                              onSaved: (val){
                                _password=val!;
                              },
                            ),
                            const SizedBox(height: 20,),
                            if(_isLoading) const CircularProgressIndicator(),
                            RaisedButton(
                              elevation: 5,
                              onPressed:()async{
                                await _submit();
                                (_character==SingingCharacter.Admin)
                                    ?
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const Admin()))
                                    : Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const  HomePage()));
                              },child: const Text(
                              "LOGIN",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                              color: const Color.fromRGBO(135, 170, 170, 1),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Text("Don't have any account ?"),
                                FlatButton(onPressed:(){

                                  Navigator.of(context).pushReplacement
                                    (MaterialPageRoute(builder: (_)=>const SignUp()));
                                }, child:const  Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded
                                  (child:  RadioListTile<SingingCharacter>(
                                  title: const Text('User'),
                                  value: SingingCharacter.User,
                                  groupValue: _character,
                                  onChanged: ( value) { setState(() { _character = value!; }); },
                                ),),
                                Expanded(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Amin'),
                                    value: SingingCharacter.Admin,
                                    groupValue: _character,
                                    onChanged: (value) { setState(() { _character = value!; }); },
                                  ),
                                ),

                              ],
                            )
                          ]
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
