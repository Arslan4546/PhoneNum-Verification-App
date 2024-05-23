

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:num_verify/UI%20Interface/authtication/signin_with_phone.dart';

import '../components/roundbutton.dart';
import '../components/utils.dart';
import 'Signup.dart';
import 'home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void login(){

    setState(() {
      loading = true;
    });

    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));

      setState(() {
        loading = false;
      });

    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text("Login Screen", style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        helperText: "enter email e.g john@email.com",
                        suffixIcon: Icon(Icons.email, color: Colors.deepPurple,)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30.0,),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(Icons.email, color: Colors.deepPurple,)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){}, child: Text("Forgot Password"))
              ],
            ),

            const SizedBox(height: 50.0,),

            //   Button

            RoundButton(
              text: "Login",
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  login();
                }
              },
            ),

            const SizedBox(height: 30.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                  },
                  child: const Text("Signup"),
                ),
              ],
            ),
            const SizedBox(height: 50.0,),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SigninWithPhone() ));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                    child: Text("Signin With Phone", style: TextStyle(
                      fontSize: 17,
                    ),),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}


