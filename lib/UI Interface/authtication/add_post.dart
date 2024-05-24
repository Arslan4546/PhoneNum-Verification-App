


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:num_verify/UI%20Interface/components/roundbutton.dart';
import 'package:num_verify/UI%20Interface/components/utils.dart';

import 'login.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  bool loading = false;
  final postController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text("Add New Post", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){
              auth.signOut().then((value){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 100,),

              TextFormField(
                maxLines: 5,
                controller: postController,
                decoration: const InputDecoration(
                    hintText: "Whats in your mind",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 40,),

              RoundButton(
                text: "Add Post",
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set(
                    {
                      "id": DateTime.now().microsecondsSinceEpoch.toString(),
                      "title" : postController.text.toString(),
                    }
                  ).then((value){
                    Utils().toastMessage("Post is added successfully!");
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}


