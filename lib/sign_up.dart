import 'package:firebase/helpers/validators.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try{
        final auth=Auth();
        await auth.signUp(emailController.text, passwordController.text);
        Navigator.pop(context);


      }catch(e){
        if(e is FirebaseAuthException){

          Fluttertoast.showToast(
              msg: e.message ?? "Unknown error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(
              left: 20 + MediaQuery.of(context).padding.left,
              right: 20 + MediaQuery.of(context).padding.right,
              top: 20,
              bottom: 20 + MediaQuery.of(context).padding.bottom),
          children: [
            ///Email
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "E-mail",
                  style: theme.textTheme.headline6,
                )),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'john@gmail.com',
              ),
              validator: (value) {
                if (value != null && Validators.email(value)) {
                  return null;
                }
                return "Invalid email!";
              },
            ),

            ///Password
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Password",
                  style: theme.textTheme.headline6,
                )),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '*******',
              ),
              validator: (value) {
                if (value != null && Validators.password(value)) {
                  return null;
                }
                return "Invalid password!";
              },
            ),

            ///Submit button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 50,
                child: TextButton(
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Sign Up',
                          style: theme.textTheme.headline3!
                              .apply(color: Colors.white),
                        ),
                  onPressed: isLoading
                      ? null
                      : () {
                          submit();
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
