import 'package:flutter/material.dart';
import 'package:twodo/twodo/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "2Do",
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Create your own 2Do",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoMono',
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                color: Colors.white,
              )))
        ],
      ),
    ));
  }
}
