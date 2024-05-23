

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/roundbutton.dart';
import '../components/utils.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signup(){

    setState(() {
      loading = true;
    });

    _auth.createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    ).then((value) {

      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));

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
        title: const Text("Signup Screen", style: TextStyle(color: Colors.white),),
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
              text: "Signup",
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  signup();
                }
              },
            ),

            const SizedBox(height: 30.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                  },
                  child: const Text("Login"),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}


