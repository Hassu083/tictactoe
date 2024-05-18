import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {




  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    changeSreen();
  }

  changeSreen() async{
    await Future.delayed(
      const Duration(
        seconds: 2
      ),
        (){
        Navigator.pushNamed(context, "/home");
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children:[ Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF0D47A1),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF42A5F5),
              ),
            ),
          ],
        ),
          Positioned(
            top: height/3,
            child: Image.asset("logo.png",
            height: height/4,
            ),
          ),
          Positioned(
              top: height/12,
              child: Text("KATI ZERO",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                        color: Colors.white,
                        letterSpacing: 15
                    )
                ),
              )
          ),
          Positioned(
              top: height/1.2,
              child: Text("POWERED BY",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 8
                    )
                ),
              )
          ),
          Positioned(
              top: height/1.15,
              child: Text("TECH IDARA",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF0D47A1),
                    textStyle:  const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        letterSpacing: 5
                    )
                ),
              )
          ),
  ]
      ),
    );
  }
}
