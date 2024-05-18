import 'package:flutter/material.dart';
import 'package:tictactoe/home/home.dart';
import 'package:tictactoe/leader_board/leader_boarder.dart';
import 'package:tictactoe/model/winner.dart';
import 'package:tictactoe/splash%20screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      onGenerateRoute: (setting){
        var screens = {
          "/": SplashScreen(),
          "/home":HomeScreen(),
          "/leaderboard":LeaderBoard()
        };
        var screen = screens[setting.name];
        if(setting.arguments != null) {
          if(setting.arguments is Winner && setting.name == "/leaderboard"){
              screen = LeaderBoard(
                winner : setting.arguments as Winner
              );
          }
        }
          return MaterialPageRoute(
          builder: (_) => screen!,
          settings: setting
        );

      },
    );
  }
}
