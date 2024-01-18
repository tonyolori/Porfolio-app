import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createuserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
    print(e.message);
      });
    }
    final user = Auth().currentUser;
    //create a new firestore document with the users name
    if (user == null) {
      return;
    }

    await user.updateDisplayName(_controllerName.text);
  }

  Widget _title() {
    return const Text('firebase Auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        //reset the error message on click and either sign in or create an account
        errorMessage = '';
        isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
      },
      child: Text(isLogin ? 'login' : 'register'),
    );
  }

  Widget _buildNameTextField() {
    return _entryField('Name', _controllerName);
  }

  Widget _buildEmailTextField() {
    return _entryField('Email', _controllerEmail);
  }

  Widget _buildPasswordTextField() {
    return _entryField('Password', _controllerPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Login' : 'Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isLogin) _buildNameTextField(),
                _buildEmailTextField(),
                _buildPasswordTextField(),
                _errorMessage(),
                const SizedBox(height: 20),
                _submitButton(),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      errorMessage = '';
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin
                      ? 'Create an account'
                      : 'Already have an account?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
