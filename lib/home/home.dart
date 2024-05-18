import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/helper/line.dart';
import 'package:tictactoe/model/winner.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Winner winners = Winner();
  double? width;
  double? height;
  Color color = Colors.white;
  late double screen_width;
  double? top;
  double? left;
  double angle = 0;
  List<List<int>> positions = [
    [-1,-1,-1],
    [-1,-1,-1],
    [-1,-1,-1]
  ];
  int count = 0;
  bool someoneWins = false;
  bool player_o_turn = true;
  @override
  Widget build(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:[
          Container(
            margin: EdgeInsets.only(top: screen_width/6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    player_o_turn? Image.asset("Capture.PNG",
                    width: 20,) :
                        Container(margin: const EdgeInsets.only(top: 20),),
                    Image.asset(
                        "player1.png",
                        width: screen_width/5.5,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Text("VS",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFDBDBDB),
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Column(
                  children: [
                    !player_o_turn? Image.asset("Capture.PNG",
                    width: 20,) :
                    Container(margin: const EdgeInsets.only(top: 20),),
                    Image.asset(
                        "player2.png",
                        width: screen_width/5.5+4.5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            color: Colors.white,
            child: AspectRatio(

                  aspectRatio: 0.9,
                  child:  Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.center,
                          children: [ //horizontal[0,1,2]=[1/8,1/2,(7/8)]
                            Positioned(
                              child:  Container(
                                  margin: EdgeInsets.only(left: 20,right: 20),
                                  child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                    ),
                                        itemCount:9,
                                        clipBehavior: Clip.antiAlias,
                                        itemBuilder: (context,index){
                                          return GestureDetector(
                                            onTap: () async {
                                              if(!someoneWins){
                                                var indexes = findIndex(index);
                                                if(findElement(index)==-1) {
                                                  if (player_o_turn) {
                                                    setState(() {
                                                      positions[indexes[0]][indexes[1]] = 3;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      positions[indexes[0]][indexes[1]] = 4;
                                                    });
                                                  }
                                                  count++;
                                                  setState(() {
                                                    player_o_turn = !player_o_turn;
                                                  });
                                                }
                                                if(count>4){
                                                  await checkWin();
                                                }
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(1),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black,
                                                      spreadRadius: 1,
                                                    ),
                                                  ]
                                              ),
                                              child:findElement(index)==3? Container(margin: const EdgeInsets.only(top: 20),child: Image.asset('o.png')) : findElement(index)==4? Container(margin: const EdgeInsets.only(top: 25),child: Image.asset('x.png')) : Container(),
                                            ),
                                          );
                                        }
                                    ),
                                ),
                            ),
                          Lines(width, height, color, top, left, angle),
                          ],
                        ),
                ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 20,bottom: 30),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/leaderboard",arguments: winners )
                          .then(
                          (value){
                            if(value is Winner){
                              winners = value;
                            }else{
                              winners = (value as Winner);
                            }
                          }
                      );
                      restart();
                    },
                    child: ListTile(
                      minLeadingWidth: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      tileColor: Color(0xFF0D47A1),
                      leading: Image.asset("list.png",
                      width: 20,
                      height: 20,),
                      title: Text("Leader board",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        )
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20,bottom: 30),
                child: GestureDetector(
                  onTap: restart,
                  child: Image.asset(
                      "restart.png",
                      width: 40,
                    ),
                ),
              ),

            ],
          )
  ],
      ),
    );
  }


  lineController(String winner,int number){
    var topOrright = {0:screen_width*(4.123/5)*(2/10),1:screen_width*(4.123/5)*(1/2),2:screen_width*(4.123/5)*(7.3/9)};
    var angles = {0:35.35,1:2.38};
    if(winner=="Horizontal"){
      setState(() {
        angle = 0.0;
        color = Colors.amber;
        top = topOrright[number];
        left = null;
        height = 10;
        width = screen_width*(4.123/6);
      });
    }else if(winner=="Vertical"){
      setState(() {
        angle = 0;
        color = Colors.amber;
        left = topOrright[number];
        top=null;
        width = 10;
        height = screen_width*(4.123/6);
      });
    }else{
      setState(() {
        angle = angles[number] as double;
        color = Colors.amber;
        height = 10;
        width = screen_width*(4.123/2);
      });

    }
  }


  List<int> findIndex(int index){
    if(index<3){
      return [0,index];
    }else if(2<index && index<6){
      return [1,index-3];
    }else{
      return [2,index-6];
    }
  }


  int findElement(int index){
    if(index<3){
      return positions[0][index];
    }else if(2<index && index<6){
      return positions[1][index-3];
    }else{
      return positions[2][index-6];
    }
  }


  restart(){
    setState(() {
      positions = [
        [-1,-1,-1],
        [-1,-1,-1],
        [-1,-1,-1]
      ];
      color = Colors.white.withOpacity(0.0);
      width = null;
      height = null;
      top = null;
      left = null;
      angle = 0;
      count=0;
      player_o_turn = true;
      someoneWins = false;
    });
  }


  checkWin() async{
    int sum = positions[0][0]+positions[1][1]+positions[2][2];
    if(sum==12){
      lineController("Diagonal", 0);
      someoneWins=true;
    }else if(sum==9){
      lineController("Diagonal", 0);
      someoneWins=true;
    }else{
      int sum = positions[0][2]+positions[1][1]+positions[2][0];
      if(sum==12){
        lineController("Diagonal", 1);
        someoneWins=true;
      }else if(sum==9){
        lineController("Diagonal", 1);
        someoneWins=true;
      }else{
        for(int index = 0 ; index < 3 ; index++) {
          int sum = positions[index][0] + positions[index][1] + positions[index][2];
          if (sum == 12) {
            //player 2 x
            lineController("Horizontal", index);
            someoneWins = true;
          } else if (sum == 9) {
            //player 1 o
            lineController("Horizontal", index);
            someoneWins = true;
          }
        }
        for(int index = 0 ; index < 3 ; index++){
          int sum = positions[0][index]+positions[1][index]+positions[2][index];
          if(sum==12){
            //player 2 x
            lineController("Vertical", index);
            someoneWins=true;
          }else if(sum==9){
            //player 1 o
            lineController("Vertical", index);
            someoneWins=true;
          }
        }
      }
    }
    if(someoneWins) {
      winners.winners.add(!player_o_turn);
      Future.delayed(Duration(seconds: 1),
              () {
            !player_o_turn ? winnerDialogue("Player 1") :
            winnerDialogue("Player 2");
          });
    }
      if(count==9 && !someoneWins){
        winners.winners.add(null);
        Future.delayed(Duration(seconds: 1),
                () {
                  drawDialogue();
                  restart();
            });

      }

      print(winners.winners);

  }

  winnerDialogue(String player) async{ showDialog(
      context: context,
      builder: (cntxt) {
        return  AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            insetPadding: const EdgeInsets.only(top: 200,bottom: 190),
            elevation: 1,
            contentPadding: EdgeInsets.zero,
            content:  Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xFF0D47A1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40,top: 40,left: 70,right: 70),
                    child: Image.asset("trophy.png",
                      width: 180,),
                  ),
                  Text(player,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )
                    ),
                  ),
                  Text("WON",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ],
              ),
            )

        );
      }
  );
  }

  drawDialogue() {
    showDialog(context: context,
        builder: (context){
          return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              insetPadding: const EdgeInsets.only(top: 200,bottom: 190),
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content:Container(
          decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFF42A5F5)
          ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40,top: 40,left: 70,right: 70),
                      child: Image.asset("logo.png",
                        width: 180,),
                    ),
                    Text("No one",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          )
                      ),
                    ),
                    Text("WIN",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ],
                ),
          )
          );
        }
    );
  }

}