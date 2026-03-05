// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:core';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _enterdEmail = '';
  var _enteredPassword = '';

  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false; // State to toggle between Login and Signup

  @override
  void dispose() {
    // 2. Always dispose controllers to save memory
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    // bool _isLoginSuccess = true;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");

      try {
        if (_isLogin) {
          await auth.signInWithEmailAndPassword(
            email: _enterdEmail,
            password: _enteredPassword,
          );
        }

        if (!_isLogin) {
          await auth.createUserWithEmailAndPassword(
            email: _enterdEmail,
            password: _enteredPassword,
          );
        }
      } on FirebaseAuthException catch (error) {
        // Handle specific Firebase errors
        String errorMessage = 'An error occurred';
        if (error.code == 'user-not-found') {
          errorMessage = 'User not found';
        } else if (error.code == 'wrong-password') {
          errorMessage = 'Wrong password';
        } else if (error.code == 'email-already-in-use') {
          errorMessage = 'Email already in use';
        } else if (error.code == 'weak-password') {
          errorMessage = 'Weak password';
        } else if (error.code == 'invalid-email') {
          errorMessage = 'Invalid email';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(errorMessage),
                duration: const Duration(seconds: 4)),
          );
        }
      } catch (error) {
        print(error);
      }

      const CircularProgressIndicator();

      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const WelcomeScreen();
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLogin ? 'Logging in...' : 'Signing up...'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 70,
                ),
                const SizedBox(
                  height: 23,
                ),
                Text(
                  _isLogin ? "Welcome Back" : "Create Account",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) =>
                      value!.contains('@') ? null : "Enter a valid email",
                  onSaved: (newValue) {
                    _enterdEmail = newValue!;
                  },
                ),
                const SizedBox(height: 15),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) =>
                      value!.length < 6 ? "Min 6 characters" : null,
                  onSaved: (value) {
                    _enteredPassword = value!;
                  },
                ),
                const SizedBox(height: 25),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(_isLogin ? "Login" : "Sign Up"),
                ),

                // Toggle Button
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? "Don't have an account? Sign Up"
                      : "Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
