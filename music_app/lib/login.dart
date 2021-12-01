import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/landing_page.dart';
import 'package:music_app/signup.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/style/fadeanimation.dart';

enum UserData {
  Email,
  password,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color enabled = const Color(0xFF2EE72E);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0x001d1d1d);
  bool ispasswordev = true;
  UserData? selected;

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String msg = '';
  String username = '';

  Future<List> _login() async {
    String url = "http://localhost/music_app/login.php";
    final response = await http.post(Uri.parse(url), body: {
      "email": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "\nLogin failed. Please try again.";
      });
    } else {
      if (datauser[0]['account_type'] == 'admin') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MusicApp()));
      } else if (datauser[0]['account_type'] == 'basic') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MusicApp()));
      }

      setState(() {
        username = datauser[0]['email'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xFF1D1D1D),
        body: SingleChildScrollView(
          child: Expanded(
            flex: 1,
            child: SizedBox(
              width: we,
              height: he,
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    delay: 0.8,
                    child: Image.asset('assets/logo/beatz-logo-transparent.png',
                        height: 150),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 230.0),
                      child: Text(
                        "Login",
                        style: GoogleFonts.heebo(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: he * 0.01,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 150.0),
                      child: Text(
                        "Please sign in to continue",
                        style: GoogleFonts.heebo(
                            color: Colors.grey, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: he * 0.04,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: 330,
                      height: he * 0.071,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: selected == UserData.Email
                            ? enabled
                            : backgroundColor,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: user,
                        onTap: () {
                          setState(() {
                            selected = UserData.Email;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: selected == UserData.Email
                                ? enabledtxt
                                : deaible,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: selected == UserData.Email
                                ? enabledtxt
                                : deaible,
                          ),
                        ),
                        style: TextStyle(
                            color: selected == UserData.Email
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
                          color: selected == UserData.password
                              ? enabled
                              : backgroundColor),
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: pass,
                        onTap: () {
                          setState(() {
                            selected = UserData.password;
                          });
                        },
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: selected == UserData.password
                                  ? enabledtxt
                                  : deaible,
                            ),
                            suffixIcon: IconButton(
                              icon: ispasswordev
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: selected == UserData.password
                                          ? enabledtxt
                                          : deaible,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: selected == UserData.password
                                          ? enabledtxt
                                          : deaible,
                                    ),
                              onPressed: () =>
                                  setState(() => ispasswordev = !ispasswordev),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: selected == UserData.password
                                    ? enabledtxt
                                    : deaible)),
                        obscureText: ispasswordev,
                        style: TextStyle(
                            color: selected == UserData.password
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
                    child: TextButton(
                        onPressed: () {
                          _login();
                        },
                        child: Text(
                          "Login",
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
                  SizedBox(
                    height: he * 0.01,
                  ),
                  Text(
                    msg,
                    style: const TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                  SizedBox(height: he * 0.1),
                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: GoogleFonts.heebo(
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const Signup();
                            }));
                          },
                          child: Text("Sign up",
                              style: GoogleFonts.heebo(
                                color: const Color(0xFF2EE72E).withOpacity(1.0),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
