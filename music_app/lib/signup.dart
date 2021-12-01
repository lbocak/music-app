import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'style/fadeanimation.dart';
import 'login.dart';

enum Gender { first_name, last_name, email, password }

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Color enabled = const Color(0xFF2EE72E);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1D1D1D);
  bool ispasswordev = true;
  Gender? selected;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String msg = '';

  void _signup() async {
    String url = "http://localhost/music_app/register.php";
    final response = await http.post(Uri.parse(url), body: {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": email.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login failed. Please try again.";
      });
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: SingleChildScrollView(
        child: SizedBox(
          width: we,
          height: he,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: he * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: we * 0.04),
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
              ),
              FadeAnimation(
                delay: 0.8,
                child: Image.asset('assets/logo/beatz-logo-transparent.png',
                    height: he * 0.1),
              ),
              SizedBox(
                height: he * 0.03,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text(
                    "Create Account",
                    style: GoogleFonts.heebo(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 2),
                  ),
                ),
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 80.0),
                  child: Text(
                    "Please fill the form below",
                    style:
                        GoogleFonts.heebo(color: Colors.grey, letterSpacing: 1),
                  ),
                ),
              ),
              SizedBox(height: he * 0.07),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 330,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: selected == Gender.first_name
                        ? enabled
                        : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: firstName,
                    onTap: () {
                      setState(() {
                        selected = Gender.first_name;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color: selected == Gender.first_name
                            ? enabledtxt
                            : deaible,
                      ),
                      hintText: 'First name',
                      hintStyle: TextStyle(
                        color: selected == Gender.first_name
                            ? enabledtxt
                            : deaible,
                      ),
                    ),
                    style: TextStyle(
                        color: selected == Gender.first_name
                            ? enabledtxt
                            : deaible,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 330,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: selected == Gender.last_name
                        ? enabled
                        : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: lastName,
                    onTap: () {
                      setState(() {
                        selected = Gender.last_name;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person_outlined,
                        color:
                            selected == Gender.last_name ? enabledtxt : deaible,
                      ),
                      hintText: 'Last name',
                      hintStyle: TextStyle(
                        color:
                            selected == Gender.last_name ? enabledtxt : deaible,
                      ),
                    ),
                    style: TextStyle(
                        color:
                            selected == Gender.last_name ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 330,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: selected == Gender.email ? enabled : backgroundColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: email,
                    onTap: () {
                      setState(() {
                        selected = Gender.email;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: selected == Gender.email ? enabledtxt : deaible,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: selected == Gender.email ? enabledtxt : deaible,
                      ),
                    ),
                    style: TextStyle(
                        color: selected == Gender.email ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: Container(
                  width: 330,
                  height: he * 0.071,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: selected == Gender.password
                          ? enabled
                          : backgroundColor),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: pass,
                    onTap: () {
                      setState(() {
                        selected = Gender.password;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: selected == Gender.password
                              ? enabledtxt
                              : deaible,
                        ),
                        suffixIcon: IconButton(
                          icon: ispasswordev
                              ? Icon(
                                  Icons.visibility_off,
                                  color: selected == Gender.password
                                      ? enabledtxt
                                      : deaible,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: selected == Gender.password
                                      ? enabledtxt
                                      : deaible,
                                ),
                          onPressed: () =>
                              setState(() => ispasswordev = !ispasswordev),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: selected == Gender.password
                                ? enabledtxt
                                : deaible)),
                    obscureText: ispasswordev,
                    style: TextStyle(
                        color:
                            selected == Gender.password ? enabledtxt : deaible,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: he * 0.02,
              ),
              FadeAnimation(
                delay: 1,
                child: TextButton(
                    onPressed: () {
                      _signup();
                    },
                    child: Text(
                      "SIGN UP",
                      style: GoogleFonts.heebo(
                        color: Colors.black,
                        letterSpacing: 0.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF2EE72E),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 80),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))),
              ),
              SizedBox(height: he * 0.10),
              FadeAnimation(
                delay: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: GoogleFonts.heebo(
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text("Sign in",
                          style: GoogleFonts.heebo(
                            color: const Color(0xFF2EE72E),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          )),
                    ),
                    Text(
                      msg,
                      style: const TextStyle(fontSize: 20.0, color: Colors.red),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
