import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shringari/screens/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    _autoLoin();
    super.initState();
  }

  var _auth = FirebaseAuth.instance;
  Future<void> _autoLoin() async {
    setState(() {
      test = true;
      _isLoading = true;
    });
    try {
      var user = await _auth.currentUser();
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));

        print(user.uid);
        setState(() {
          test = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          test = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        test = false;
        _isLoading = false;
      });
      print(e.toString());
    }
  }

  var _isLoading = false;

  bool test = false;

  String email;

  String password;

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error.toString());
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Unable to login'),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                color: Colors.orange[300],
                child: Center(
                  child: Text(
                    'Shringari',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
              ),
              if (!test)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    cursorColor: Colors.orange[300],
                    decoration: InputDecoration(
                        hintText: 'Enter your Registired Email',
                        hintStyle: TextStyle(color: Colors.orange[300])),
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.orange[300]),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) => email = val,
                  ),
                ),
              SizedBox(height: 30),
              if (!test)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    cursorColor: Colors.orange[300],
                    decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(color: Colors.orange[300])),
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.orange[300]),
                    onChanged: (val) => password = val,
                    obscureText: true,
                  ),
                ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: Colors.orange[300],
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        login(email, password, context);
                        setState(() {
                          _isLoading = true;
                        });
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
