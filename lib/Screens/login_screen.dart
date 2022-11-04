import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences _sharedPreferences;
  //TextEditingControllers of the textfield
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? emailValue;
  String? phoneValue;

  void _saveButton() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setString("Email", emailController.text);
    _sharedPreferences.setString("PhoneNumber", phoneNumberController.text);
    _updateText();
    emailController.clear();
    phoneNumberController.clear();
  }

  void _updateText() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      emailValue = _sharedPreferences.getString('Email')!;
      phoneValue = _sharedPreferences.getString('PhoneNumber')!;
    });
  }

  void checkData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getString('Email') == null) {
      setState(() {
        emailValue = "Please Enter A Email.";
        phoneValue = "Please Enter A PhoneNumber";
      });
    } else {
      _updateText();
    }
  }

  void _deleteInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove('Email');
    await _sharedPreferences.remove('PhoneNumber');
    setState(() {
      if (_sharedPreferences.get('Email') == null) {
        emailValue = "Enter A Email";
        phoneValue = "Enter A PhoneNumber";
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText:
                        emailValue == null ? "Enter A Email" : emailValue!,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              //textfield phoneNumber
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                width: double.infinity,
                child: TextField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: phoneValue == null
                        ? "Enter A Phone Number"
                        : phoneValue!,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              //SaveButton
              ElevatedButton(
                onPressed: _saveButton,
                child: const Text("Save"),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _deleteInfo,
                child: const Text("Delete the Information"),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
