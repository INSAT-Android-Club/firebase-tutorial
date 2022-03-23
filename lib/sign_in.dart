import 'package:firebase/helpers/validators.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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

        await auth.signIn(emailController.text, passwordController.text);

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
          "Sign In",
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
                          'Sign In',
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

            ///Don’t have an account?
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: theme.textTheme.headline6,
                    ),
                    TextSpan(
                      text: "Sign Up",
                      style:
                          theme.textTheme.headline5!.apply(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUp();
                          }));
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
