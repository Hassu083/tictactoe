import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/model/winner.dart';


class Bar extends StatelessWidget implements PreferredSizeWidget {
  Function? onpress;

  Bar({this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onpress!();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.arrow_back_ios,
                size: 30,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 50),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LEADER",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF0D47A1),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          letterSpacing: 10
                      )
                  ),
                ),
                const SizedBox(height: 2,),
                Text(
                  "BOARD",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF0D47A1),
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          letterSpacing: 15
                      )
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(400,200);

}



class LeaderBoard extends StatelessWidget {

  Winner?  winner;

  LeaderBoard({this.winner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(
        onpress: (){
          Navigator.pop(context,winner);
        },
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
                physics: ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemCount: winner!.winners.length,
                padding: EdgeInsets.only(left: 15, right: 15),
                itemBuilder: (context, index) {
                  return (winner!.winners[index]==null) ?
                      Draw() : someOneWin(winner!.winners[index]);
                }),

    );
  }
  Widget Draw(){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(

        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        tileColor: Color(0xFFF5F5F5),
        title: Text(
          "Draw",
          style: GoogleFonts.poppins(
              color: Colors.red[900],
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        leading: Image.asset("x.png",
          width: 80,
          height: 50,),
        minLeadingWidth: 10,
        minVerticalPadding: 25,
        trailing: Image.asset("o.png",
          width: 80,
          height: 50,),

      ),
    );
  }
    Widget someOneWin(bool whoWin){
    String person = "";
    String img = "";
      if(whoWin){
        person = "Player 1";
        img  = "o.png";
      }else{
        person = "Player 2";
        img  = "x.png";
      }
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListTile(
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          tileColor: Color(0xFFF5F5F5),
          title: Text(
            person,
            style: GoogleFonts.poppins(
                color: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            ),
          ),
          leading: Image.asset(img,
            width: 80,
            height: 50,),
          minLeadingWidth: 10,
          minVerticalPadding: 25,
          trailing:Image.asset("trophy.png") ,

        ),
      );
    }

}
