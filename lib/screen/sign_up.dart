import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/auth.dart';
import 'user/home_page.dart';
import 'admin/admin.dart';
import 'login.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}
enum SingingCharacter { Admin, User }
class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final authintication = Auth();
  String _name="";
  String _email="";
  String _password="";
  //final _passwordController = TextEditingController();
  bool _isLoading = false;


  //final FirebaseAuth _auth = FirebaseAuth.instance;

  SingingCharacter _character = SingingCharacter.Admin;
    _submit ()  async {
    final validate = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validate) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading=true;
      });
        print(_email);
        print(_password);

        final response = await authintication.signUp(_email.trim(), _password.trim());
      print(response);
        setState(() {
          _isLoading=false;
        });
      }}
  @override
  Widget build(BuildContext context) {

    final device = MediaQuery.of(context).size;

int value=1;

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
                Container(
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
                              key: const ValueKey("name"),
                              decoration:const  InputDecoration(
                                errorBorder: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "Enter Your Name",
                              ),
                              keyboardType: TextInputType.text,
                              validator: (val){
                                if(val!.isEmpty||val.length<6){
                                  return "please enter a valid name";
                                }else{return null;}
                              },
                              onSaved: (val){
                             setState(() {
                               _name=val!;
                             });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              key: const ValueKey("email"),
                              maxLength: 30,
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
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (val){
                                setState(() {
                                  _email=val!;
                                });

                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              key: const ValueKey("Password"),
                              decoration:const  InputDecoration(
                                errorBorder: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.visibility),
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "Password",
                              ),
                              obscureText: true,
                              //controller:_passwordController ,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (val){
                                if(val!.isEmpty||val.length < 5){
                                  return 'Password Is too Short';
                                }else{
                                  return null;
                                }
                              },
                              onSaved: (val){
                                setState(() {
                                  _password=val!;
                                });
                              },
                            ),
                            const SizedBox(height: 20,),
                            if(_isLoading)
                              const CircularProgressIndicator(),

                            RaisedButton(
                              elevation: 5,
                              onPressed:() async{
                                await  _submit();
                               (_character==SingingCharacter.Admin)
                                  ?
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const Admin()))
                                : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const  HomePage()));
                              },child: const Text(
                              "SIGNUP",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                              color: const Color.fromRGBO(135, 170, 170, 1),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Text(" have a account ?"),
                                FlatButton(onPressed:(){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const Login()));
                                }, child:const  Text("Login",style: TextStyle(fontWeight: FontWeight.bold)))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RadioListTile<SingingCharacter>(
                                  title: const Text('Amin'),
                                  value: SingingCharacter.Admin,
                                  groupValue: _character,
                                  onChanged: (value) { setState(() { _character = value!; }); },
                                ),
                                 ),
                                Expanded
                                  (child:  RadioListTile<SingingCharacter>(
                                  title: const Text('User'),
                                  value: SingingCharacter.User,
                                  groupValue: _character,
                                  onChanged: ( value) { setState(() { _character = value!; }); },
                                ),)
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
