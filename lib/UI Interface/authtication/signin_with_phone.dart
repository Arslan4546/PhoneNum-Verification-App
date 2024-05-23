import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/roundbutton.dart';
import '../components/utils.dart';
import 'OPT_verification.dart';

class SigninWithPhone extends StatefulWidget {
  const SigninWithPhone({super.key});

  @override
  State<SigninWithPhone> createState() => _SigninWithPhoneState();
}

class _SigninWithPhoneState extends State<SigninWithPhone> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final auth = FirebaseAuth.instance;

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text("Signin With Phone", style: TextStyle(color: Colors.white),),
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: "Phone",
                        helperText: "+1 234 5678 987",
                        suffixIcon: Icon(Icons.phone, color: Colors.deepPurple,)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter phone Number";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 50,),
                  
                  RoundButton(
                    text: "Send OTP code",
                    loading: loading,
                    onTap: (){
                      setState(() {
                        loading = true;
                      });

                      auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text.toString(),
                        verificationCompleted: (_){
                          setState(() {
                            loading = false;
                          });
                        },
                        verificationFailed: (e){
                          Utils().toastMessage(e.toString());
                          setState(() {
                            loading = false;
                          });

                        },
                        codeSent: (String verificationId, int? token){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyOTP(verificationId: verificationId,)));

                          setState(() {
                            loading = false;
                          });
                        },
                        codeAutoRetrievalTimeout: (e){
                          Utils().toastMessage(e.toString());
                          setState(() {
                            loading = false;
                          });
                        }
                      );

                    }
                  ),

                  const SizedBox(height: 50,),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
