import 'package:afaq/helpers/get_size.dart';
import 'package:afaq/pages/auth/signup_screen.dart';
import 'package:afaq/widgets/buttons/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationSelectionScreen extends StatelessWidget {
  const AuthenticationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = getSize(context).width > 600;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/LetsFindTheA.png",
                      width: isLargeScreen
                          ? getSize(context).width * 0.5
                          : getSize(context).width * 0.8,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Let's find the \"A\" with us",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 32 : 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: isLargeScreen ? 24 : 16,
                      ),
                      Text(
                        "Please Sign in to view personalized recommendations",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 20 : 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MainButton(
                        text: 'Sign Up',
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>  SignUpScreen()));
                        },
                        borderRadius: 8,
                      ),
                      SizedBox(
                        height: isLargeScreen ? 16 : 8,
                      ),
                      MainButton(
                        btnColor: Colors.transparent,
                        txtColor: Theme.of(context).primaryColor,
                        text: 'Log In',
                        fontWeight: FontWeight.w400,
                        onTap: () {},
                        borderRadius: 8,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
