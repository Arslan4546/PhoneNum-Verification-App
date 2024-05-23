



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/roundbutton.dart';
import '../components/utils.dart';
import 'home.dart';
class VerifyOTP extends StatefulWidget {
  final String verificationId;
  const VerifyOTP({super.key, required this.verificationId});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {

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
        title: const Text("Verify OTP", style: TextStyle(color: Colors.white),),
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
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "Enter OTP",
                        helperText: "123456",
                        suffixIcon: Icon(Icons.verified, color: Colors.deepPurple,)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter OTP";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 50,),

                  RoundButton(
                      text: "Verify OTP",
                      loading: loading,
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });

                        final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: phoneController.text.toString(),
                        );

                        try{
                          await auth.signInWithCredential(credential);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                        }catch(e){
                          setState(() {
                            loading = false;
                          });
                          Utils().toastMessage(e.toString());
                        }

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
