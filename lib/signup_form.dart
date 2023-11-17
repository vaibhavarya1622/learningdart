import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget{
    const SignUpForm({Key?key}):super(key:key);

    @override
    State<SignUpForm> createState()=>_SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>{
    var showError = false;
    var name = '';

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text('SignUp'),
                centerTitle: true,
            ),
            body: Form(
                autovalidateMode: showError?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
                child: SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            labelText: 'Name'
                                        ),
                                        autocorrect: false,
                                        onChanged: (value){
                                            name = value;
                                            if(showError){
                                                setState(() {
                                                  showError = false;
                                                });
                                            }
                                        },
                                        validator: (value){
                                            if(value != null && value.length<=4){
                                                return 'Name is too short';
                                            }
                                        },
                                    ),
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.email),
                                            labelText: 'Email'
                                        ),
                                        autocorrect: false,
                                        onChanged: (value){
                                            showError = false;
                                            if(showError){
                                                setState(() {
                                                  showError = false;
                                                });
                                            }
                                        },
                                        validator: (value){
                                            if(value != null && !value.contains('@')){
                                                return 'Email does not have @';
                                            }
                                        },
                                    ),
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.lock),
                                            labelText: 'Password'
                                        ),
                                        autocorrect: false,
                                        obscureText: true,
                                        onChanged: (value) {
                                            if(showError){
                                                setState(() {
                                                  showError = false;
                                                });
                                            }
                                        },
                                        validator: (value){
                                            if(value != null && value.length<6){
                                                return 'Password is too short';
                                            }
                                        },
                                    ),
                                ),
                                _submitButton(context),
                                const Divider(height: 30),
                            ],
                        ),
                    ),
                ),
            )
        );
    }
    Widget _submitButton(BuildContext context){
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
            child: TextButton(
                child: const ListTile(
                    title: Text('SignUp'),
                ),
                onPressed: () {
                    //This is to remove the keyboard from screen
                    FocusScope.of(context).requestFocus(FocusNode());
                    //This is to show the notification which comes from the bottom of the screen and stays for few seconds.
                    var snackBar = const SnackBar(content: Text('Signing Up'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                        showError=true;
                    });
                },
            ),
        );
    }
}