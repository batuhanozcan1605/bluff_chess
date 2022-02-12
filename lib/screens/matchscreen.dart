import 'package:bluff_chess/static.dart';
import 'package:bluff_chess/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MatchScreen extends StatefulWidget {
  final int whiteScoreTaken;
  final int blackScoreTaken;
  final bool whiteStarted;
  final bool memoryFactor;

  MatchScreen({required this.whiteScoreTaken, required this.blackScoreTaken, required this.whiteStarted, required this.memoryFactor});


  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {

  late var whiteScore;
  late var blackScore;

  // 6 squares in each row
  int row = 6;
  // 36 squares in total
  int totalNumberOfSquares = 36;

  bool memoryFactor = false;
  bool whiteTurn = true;
  bool whiteStarted = true;
  bool setUpPhase = true;
  bool newWhitePieces = false;
  bool newBlackPieces = false;

  int indexOfCurrentlySelectedPiece =
      13; //Because there is no interaction on index 13 in setUp
  int indexOfSelectedPieceInSetUp = -1;
  bool allWhitePiecesAreOn = false;
  bool allBlackPiecesAreOn = false;
  bool setUpIsTapped = false;

  String colorOfCurrentlySelectedPiece = 'white';
  String currentlySelectedPiece = '';
  bool aPieceIsSelected = false;

  bool hiddenWhite = false;
  bool hiddenBlack = false;
  //Bluff Claim
  String readPieceForBluff = '';
  String readMoveType = '';

  bool bluffTime = false;
  bool killTry = false;
  bool bluffClaimed = false;
  String tempPiece = '';
  String tempColor = '';
  bool claimedKing = false;
  //

  int indexOfLastMove = -1;
  var singleReveal = List<bool>.filled(36, false, growable: false);
 // var triggerOpacity = List<bool>.filled(36, false, growable: false);

  // dead pieces
  var deadWhitePieces = [];
  var deadBlackPieces = [];
  bool whiteKingEscaped = false;
  bool blackKingEscaped = false;

  String cause = "";
  String causeEscape = '';
  bool gameOver = false;


  void showAlertDialog(BuildContext context, cause, whoLost) {
    if(whoLost == 'white' && whiteKingEscaped) {
       blackScore = 2;
       causeEscape = 'White king was escaped secretly, plus White lost the set. It means White lost the game.';
    }
    if(whoLost == 'black' && blackKingEscaped) {
      whiteScore = 2;
      causeEscape = 'Black king was escaped secretly, plus Black lost the set. It means Black lost the game.';
    }
    if(whiteScore == 2 || blackScore == 2) {
      gameOver = true;
    }

    //set up score text
    Widget scores = SizedBox(
        height: 200,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$cause\n\n$causeEscape', style: TextStyle(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text("Black: $blackScore", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ),
            Text("White: $whiteScore", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            gameOver ? Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                 child:  blackScore > whiteScore ?
                 Text("Black Wins.", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)) :
                 Text("White Wins.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
            )
                : Container(),
          ]),
    );

    // set up the button
    Widget nextSet = TextButton(
      child: Text("NEXT SET", style: TextStyle(color: Colors.white),),
      onPressed: () {
        whiteStarted = !whiteStarted;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MatchScreen(whiteScoreTaken: whiteScore, blackScoreTaken: blackScore, whiteStarted: whiteStarted, memoryFactor: memoryFactor,),
            ));
      },
    );

    Widget rematch = TextButton(
      child: Text("REMATCH", style: TextStyle(color: Colors.white),),
      onPressed: () {
        whiteScore = 0;
        blackScore = 0;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MatchScreen(whiteScoreTaken: whiteScore, blackScoreTaken: blackScore, whiteStarted: true, memoryFactor: memoryFactor),
            ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.brown[300],
      title: !gameOver ? Text("END OF SET", style: TextStyle(color: Colors.white),) :
                          Text("GAME OVER", style: TextStyle(color: Colors.white),),
      content: scores,
      actions: [
        !gameOver ? nextSet : rematch,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  var _selectedIndex = null;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  // pieces
  List pieces = [
    // [position, piece, color, selected, possible kill, move type]

    // black pieces
    [0, 'x', '', '', '', ''],
    [1, 'x', '', '', '', ''],
    [2, 'x', '', '', '', ''],
    [3, 'x', '', '', '', ''],
    [4, 'x', '', '', '', ''],
    [5, 'x', '', '', '', ''],
    [6, 'x', '', '', '', ''],
    [7, 'x', '', '', '', ''],
    [8, 'x', '', '', '', ''],
    [9, 'x', '', '', '', ''],
    [10, 'x', '', '', '', ''],
    [11, 'x', '', '', '', ''],

    // open spaces -> x = blank, o = possible move, color, k = possible kill
    [12, 'x', '', '', '', ''],
    [13, 'x', '', '', '', ''],
    [14, 'x', '', '', '', ''],
    [15, 'x', '', '', '', ''],
    [16, 'x', '', '', '', ''],
    [17, 'x', '', '', '', ''],
    [18, 'x', '', '', '', ''],
    [19, 'x', '', '', '', ''],
    [20, 'x', '', '', '', ''],
    [21, 'x', '', '', '', ''],
    [22, 'x', '', '', '', ''],
    [23, 'x', '', '', '', ''],

    // white pieces
    [24, 'x', '', '', '', ''],
    [25, 'x', '', '', '', ''],
    [26, 'x', '', '', '', ''],
    [27, 'x', '', '', '', ''],
    [28, 'x', '', '', '', ''],
    [29, 'x', '', '', '', ''],
    [30, 'x', '', '', '', ''],
    [31, 'x', '', '', '', ''],
    [32, 'x', '', '', '', ''],
    [33, 'x', '', '', '', ''],
    [34, 'x', '', '', '', ''],
    [35, 'x', '', '', '', ''],
  ];

  List setupWhitePawns = [
    ['setup', 'pawn', 'white'],
    ['setup', 'pawn', 'white'],
    ['setup', 'pawn', 'white'],
  ];
  List setupBlackPawns = [
    ['setup', 'pawn', 'black'],
    ['setup', 'pawn', 'black'],
    ['setup', 'pawn', 'black'],
  ];

  List setUpWhitePieces = [
    ['setup', 'bishop', 'white'],
    ['setup', 'king', 'white'],
    ['setup', 'knight', 'white'],
    ['setup', 'queen', 'white'],
    ['setup', 'rook', 'white'],
  ];

  List setupBlackPieces = [
    ['setup', 'bishop', 'black'],
    ['setup', 'king', 'black'],
    ['setup', 'knight', 'black'],
    ['setup', 'queen', 'black'],
    ['setup', 'rook', 'black'],
  ];

  // unselect everything
  void unselectEverything() {
    setState(() {
      //aPieceIsSelected = false;
      _selectedIndex = null;
      for (int i = 0; i < pieces.length; i++) {
        pieces[i][3] = 'unselected';
        if (pieces[i][1] == 'o') {
          pieces[i][1] = 'x';
        }
        if (pieces[i][4] == 'k') {
          pieces[i][4] = '';
        }
      }
    });
  }

  void tappedPiece(int index, listToReduce) {
    //In Setup
    if (setUpPhase == true) {
      print(currentlySelectedPiece + ', ' + colorOfCurrentlySelectedPiece);
      // If a drawn piece is selected on Setup

      // if the tapped position is an available move, move the piece to that position
      if (pieces[index][1] == 'o') {
        setState(() {
          pieces[index][1] = currentlySelectedPiece;
          pieces[index][2] =
              colorOfCurrentlySelectedPiece == 'white' ? 'white' : 'black';
          pieces[indexOfCurrentlySelectedPiece][1] = 'x';
          pieces[indexOfCurrentlySelectedPiece][2] = '';
          indexOfCurrentlySelectedPiece = 13;
        });
        if (listToReduce.isEmpty == false &&
            indexOfSelectedPieceInSetUp != -1) {
          listToReduce.removeAt(indexOfSelectedPieceInSetUp);
        }
        if (listToReduce.isEmpty == true) {
          if (whiteTurn) {
            setState(() {
              newWhitePieces = true;
            });
          } else {
            setState(() {
              newBlackPieces = true;
            });
          }
        }

        int wc = 0; //White Counter on board.
        if (newWhitePieces) {
          for (int i = 0; i < 36; i++) {
            if (pieces[i][2] == "white") {
              wc = wc + 1;
            }
          }
          if (wc == 8) {
            setState(() {
              allWhitePiecesAreOn = true;
            });
          }
        }
        int bc = 0; //Black Counter on board.
        if (newBlackPieces) {
          for (int i = 0; i < 36; i++) {
            if (pieces[i][2] == "black") {
              bc = bc + 1;
            }
          }
          if (bc == 8) {
            setState(() {
              allBlackPiecesAreOn = true;
            });
          }
        }

        unselectEverything();
      }
      // select current piece in setup
      else {
        unselectEverything();
        if (pieces[index][2] == "white" && whiteTurn) {
          if (pieces[index][1] == "pawn") {
            setState(() {
              indexOfCurrentlySelectedPiece = index;
              indexOfSelectedPieceInSetUp =
                  -1; // made -1 because tappedPiece should not remove piece from list
              currentlySelectedPiece = "pawn";
              colorOfCurrentlySelectedPiece = "white";
              for (int i = 24; i < 30; i++) {
                if (pieces[i][1] == 'x') {
                  pieces[i][1] = 'o';
                }
              }
            });
          } else {
            setState(() {
              indexOfCurrentlySelectedPiece = index;
              indexOfSelectedPieceInSetUp =
                  -1; // made -1 because tappedPiece should not remove piece from list
              currentlySelectedPiece = pieces[index][1];
              colorOfCurrentlySelectedPiece = "white";
              for (int i = 30; i < 36; i++) {
                if (pieces[i][1] == 'x') {
                  pieces[i][1] = 'o';
                }
              }
            });
          }
        }
        if (pieces[index][2] == "black" && !whiteTurn) {
          if (pieces[index][1] == "pawn") {
            setState(() {
              indexOfCurrentlySelectedPiece = index;
              indexOfSelectedPieceInSetUp =
                  -1; // made -1 because tappedPiece should not remove piece from list
              currentlySelectedPiece = "pawn";
              colorOfCurrentlySelectedPiece = "black";
              for (int i = 6; i < 12; i++) {
                if (pieces[i][1] == 'x') {
                  pieces[i][1] = 'o';
                }
              }
            });
          } else {
            setState(() {
              indexOfCurrentlySelectedPiece = index;
              indexOfSelectedPieceInSetUp =
                  -1; // made -1 because tappedPiece should not remove piece from list
              currentlySelectedPiece = pieces[index][1];
              colorOfCurrentlySelectedPiece = "black";
              for (int i = 0; i < 6; i++) {
                if (pieces[i][1] == 'x') {
                  pieces[i][1] = 'o';
                }
              }
            });
          }
        }
      }
    } //setUpPhase is true

    //Game Begins
    else {
      // if the tapped position is an available move, move the piece to that position
      if (pieces[index][1] == 'o') {
        setState(() {
          pieces[index][1] = currentlySelectedPiece;
          pieces[index][2] =
              colorOfCurrentlySelectedPiece == 'white' ? 'white' : 'black';
          pieces[indexOfCurrentlySelectedPiece][1] = 'x';
          pieces[indexOfCurrentlySelectedPiece][2] = ' ';
          readMoveType = pieces[index][5];
          indexOfLastMove = index;

        });
        setState(() {
          whiteTurn = !whiteTurn;
          readPieceForBluff = currentlySelectedPiece;
          bluffTime = true;
        });
        unselectEverything();
      }
      // if the tapped position is a kill move, move the piece to that position. (kill position)
      else if (pieces[index][4] == 'k') {
        setState(() {
          killTry = true; //shows the NO button

          //wait the killed piece on air.
          tempPiece = pieces[index][1];
          tempColor = pieces[index][2];

          pieces[index][1] = currentlySelectedPiece;
          pieces[index][2] =
              colorOfCurrentlySelectedPiece == 'white' ? 'white' : 'black';
          pieces[indexOfCurrentlySelectedPiece][1] = 'x';
          pieces[indexOfCurrentlySelectedPiece][2] = ' ';
          readMoveType = pieces[index][5];
          indexOfLastMove = index;

          readPieceForBluff = currentlySelectedPiece;
          whiteTurn = !whiteTurn;
          bluffTime = true;
        });
        unselectEverything();
      }
      // select current piece
      else {
        unselectEverything();
        setState(() {
          aPieceIsSelected = false;
          claimedKing = false;
          bluffTime = false;
          indexOfCurrentlySelectedPiece = index;
          colorOfCurrentlySelectedPiece = pieces[index][2];
          if (colorOfCurrentlySelectedPiece == "white" && whiteTurn) {
            pieces[index][3] = 'selected';
            currentlySelectedPiece = pieces[index][1];
          }
          if (colorOfCurrentlySelectedPiece == "black" && !whiteTurn) {
            pieces[index][3] = 'selected';
            currentlySelectedPiece = pieces[index][1];
          }
        });
        // check what the piece is, then show available moves for that piece
        if (pieces[index][2] == "white" && whiteTurn) {
          //White Turn
          if (pieces[index][1] != "pawn") {
            aPieceIsSelected = true;
            tappedRook(index);
            tappedKnight(index);
            tappedBishop(index);
          } else {
            unselectEverything();
          }
        }
        if (pieces[index][2] == "black" && !whiteTurn) {
          //Black turn
          if (pieces[index][1] != "pawn") {
            aPieceIsSelected = true;
            tappedRook(index);
            tappedKnight(index);
            tappedBishop(index);
          } else {
            unselectEverything();
          }
        }
      }
    }
  } //Game Begins

  void tappedRook(int index) {
    List<int> possibleMoves = [];

    // there is a max of 5 moves that a rook can go in any particular direction
    // add all the positions to possibleMoves until there is a piece in the way

    // UP
    for (int i = 1; i < 6; i++) {
      if (withinTheBoard(index - i * row)) {
        if (pieces[index - i * row][1] != 'x') {
          if (pieces[index - i * row][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - i * row][4] = 'k';
            pieces[index - i * row][5] = 'rook';
          }
          break;
        } else {
          possibleMoves.add(index - i * row);
        }
      }
    }

    // DOWN
    for (int i = 1; i < 6; i++) {
      if (withinTheBoard(index + i * row)) {
        if (pieces[index + i * row][1] != 'x') {
          if (pieces[index + i * row][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + i * row][4] = 'k';
            pieces[index + i * row][5] = 'rook';
          }
          break;
        } else {
          possibleMoves.add(index + i * row);
        }
      }
    }

    // left and right need a little extra adjustment
    // so that it doesn't flow off to the next rows

    // LEFT
    for (int i = 1; i < index % 6 + 1; i++) {
      if (withinTheBoard(index - i)) {
        if (pieces[index - i][1] != 'x') {
          if (pieces[index - i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - i][4] = 'k';
            pieces[index - i][5] = 'rook';
          }
          break;
        } else {
          possibleMoves.add(index - i);
        }
      }
    }

    // RIGHT
    for (int i = 1; i < 6 - index % 6; i++) {
      if (withinTheBoard(index + i)) {
        if (pieces[index + i][1] != 'x') {
          if (pieces[index + i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + i][4] = 'k';
            pieces[index + i][5] = 'rook';
          }
          break;
        } else {
          possibleMoves.add(index + i);
        }
      }
    }

    setState(() {
      for (int i = 0; i < possibleMoves.length; i++) {
        pieces[possibleMoves[i]][1] = 'o';
        pieces[possibleMoves[i]][5] = 'rook';
      }
    });
  }

  void tappedKnight(int index) {
    // total possible moves for knight, but we can't included everything in this
    // list depending on where we are, otherwise the move will spill over to the next column
    List<int> possibleMoves = [
      index - 2 * row - 1, // don't include if index is in first column
      index - 2 * row + 1, // don't include if index is in last column
      index + 2 * row - 1, // don't include if index is in first column
      index + 2 * row + 1, // don't include if index is in last column
      index - row + 2, // don't include if index is in 1st/2nd last column
      index - row - 2, // don't include if index is in 1st/2nd column
      index + row + 2, // don't include if index is in 1st/2nd last column
      index + row - 2, // don't include if index is in 1st/2nd column
    ];

    switch (index % 6) {
      // first column
      case 0:
        possibleMoves = [
          index - 2 * row + 1, // don't include if index is in last column
          index + 2 * row + 1, // don't include if index is in last column
          index - row + 2, // don't include if index is in 1st/2nd last column
          index + row + 2, // don't include if index is in 1st/2nd last column
        ];
        break;
      // second column
      case 1:
        possibleMoves = [
          index - 2 * row - 1, // don't include if index is in first column
          index - 2 * row + 1, // don't include if index is in last column
          index + 2 * row - 1, // don't include if index is in first column
          index + 2 * row + 1, // don't include if index is in last column
          index - row + 2, // don't include if index is in 1st/2nd last column
          index + row + 2, // don't include if index is in 1st/2nd last column
        ];
        break;
      // second last column
      case 4:
        possibleMoves = [
          index - 2 * row - 1, // don't include if index is in first column
          index - 2 * row + 1, // don't include if index is in last column
          index + 2 * row - 1, // don't include if index is in first column
          index + 2 * row + 1, // don't include if index is in last column
          index - row - 2, // don't include if index is in 1st/2nd column
          index + row - 2, // don't include if index is in 1st/2nd column
        ];
        break;
      // last column
      case 5:
        possibleMoves = [
          index - 2 * row - 1, // don't include if index is in first column
          index + 2 * row - 1, // don't include if index is in first column
          index - row - 2, // don't include if index is in 1st/2nd column
          index + row - 2, // don't include if index is in 1st/2nd column
        ];
        break;

      default:
    }

    setState(() {
      for (int i = 0; i < possibleMoves.length; i++) {
        // first check that the place you are trying to go is on the board (0 <= index <= 63)
        if (withinTheBoard(possibleMoves[i])) {
          // if the place you're trying to go to is blank (x)
          if (pieces[possibleMoves[i]][1] == 'x') {
            // then it is an available position (o)
            pieces[possibleMoves[i]][1] = 'o';
            pieces[possibleMoves[i]][5] = 'knight';
          } // if the place you're trying to go to is NOT blank and is the opponent's piece
          else if (pieces[possibleMoves[i]][1] != 'x' &&
              colorOfCurrentlySelectedPiece != pieces[possibleMoves[i]][2]) {
            // then it a possible kill move
            pieces[possibleMoves[i]][4] = 'k';
            pieces[possibleMoves[i]][5] = 'knight';
          }
        }
      }
    });
  }

  void tappedBishop(int index) {
    List<int> possibleMoves = [];

    // up left diagonal
    for (int i = 1; i < index % 6 + 1; i++) {
      if (withinTheBoard(index - i * row - i)) {
        if (pieces[index - i * row - i][1] != 'x') {
          if (pieces[index - i * row - i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - i * row - i][4] = 'k';
            pieces[index - i * row - i][5] = 'bishop';
          }
          break;
        } else {
          possibleMoves.add(index - i * row - i);
        }
      }
    }

    // up right diagonal
    for (int i = 1; i < 6 - index % 6; i++) {
      if (withinTheBoard(index - i * row + i)) {
        if (pieces[index - i * row + i][1] != 'x') {
          if (pieces[index - i * row + i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - i * row + i][4] = 'k';
            pieces[index - i * row + i][5] = 'bishop';
          }
          break;
        } else {
          possibleMoves.add(index - i * row + i);
        }
      }
    }

    // down left diagonal
    for (int i = 1; i < index % 6 + 1; i++) {
      if (withinTheBoard(index + i * row - i)) {
        if (pieces[index + i * row - i][1] != 'x') {
          if (pieces[index + i * row - i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + i * row - i][4] = 'k';
            pieces[index + i * row - i][5] = 'bishop';
          }
          break;
        } else {
          possibleMoves.add(index + i * row - i);
        }
      }
    }

    // down right diagonal
    for (int i = 1; i < 6 - index % 6; i++) {
      if (withinTheBoard(index + i * row + i)) {
        if (pieces[index + i * row + i][1] != 'x') {
          if (pieces[index + i * row + i][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + i * row + i][4] = 'k';
            pieces[index + i * row + i][5] = 'bishop';
          }
          break;
        } else {
          possibleMoves.add(index + i * row + i);
        }
      }
    }

    setState(() {
      for (int i = 0; i < possibleMoves.length; i++) {
        pieces[possibleMoves[i]][1] = 'o';
        pieces[possibleMoves[i]][5] = 'bishop';
      }
    });
  }

  void tappedKing(int index) {
    List<int> possibleMoves = [];
    //UP
    if (withinTheBoard(index - 1 * row)) {
      if (pieces[index - 1 * row][1] != 'x') {
        if (pieces[index - 1 * row][2] != colorOfCurrentlySelectedPiece) {
          pieces[index - 1 * row][4] = 'k';
          pieces[index - 1 * row][5] = 'king';
        }
      } else {
        possibleMoves.add(index - 1 * row);
      }
    }

    //DOWN
    if (withinTheBoard(index + 1 * row)) {
      if (pieces[index + 1 * row][1] != 'x') {
        if (pieces[index + 1 * row][2] != colorOfCurrentlySelectedPiece) {
          pieces[index + 1 * row][4] = 'k';
          pieces[index + 1 * row][5] = 'king';
        }
      } else {
        possibleMoves.add(index + 1 * row);
      }
    }

    //LEFT
    if(index % 6 != 0) {
      if (withinTheBoard(index - 1)) {
        if (pieces[index - 1][1] != 'x') {
          if (pieces[index - 1][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - 1][4] = 'k';
            pieces[index - 1][5] = 'king';
          }
        } else {
          possibleMoves.add(index - 1);
        }
      }
    }

    //RIGHT
    if(6 - index % 6 != 1) {
      if (withinTheBoard(index + 1)) {
        if (pieces[index + 1][1] != 'x') {
          if (pieces[index + 1][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + 1][4] = 'k';
            pieces[index + 1][5] = 'king';
          }
        } else {
          possibleMoves.add(index + 1);
        }
      }
    }

    // up left diagonal
    if (index % 6 != 0) {
      if (withinTheBoard(index - 1 * row - 1)) {
        if (pieces[index - 1 * row - 1][1] != 'x') {
          if (pieces[index - 1 * row - 1][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - 1 * row - 1][4] = 'k';
            pieces[index - 1 * row - 1][5] = 'king';
          }
        } else {
          possibleMoves.add(index - 1 * row - 1);
        }
      }
    }

    // up right diagonal
    if (6 - index % 6 != 1) {
      if (withinTheBoard(index - 1 * row + 1)) {
        if (pieces[index - 1 * row + 1][1] != 'x') {
          if (pieces[index - 1 * row + 1][2] != colorOfCurrentlySelectedPiece) {
            pieces[index - 1 * row + 1][4] = 'k';
            pieces[index - 1 * row + 1][5] = 'king';
          }
        } else {
          possibleMoves.add(index - 1 * row + 1);
        }
      }
    }

    // down left diagonal
    if (index % 6 != 0) {
      if (withinTheBoard(index + 1 * row - 1)) {
        if (pieces[index + 1 * row - 1][1] != 'x') {
          if (pieces[index + 1 * row - 1][2] != colorOfCurrentlySelectedPiece) {
            pieces[index + 1 * row - 1][4] = 'k';
            pieces[index + 1 * row - 1][5] = 'king';
          }
        } else {
          possibleMoves.add(index + 1 * row - 1);
        }
      }
    }


    setState(() {
      for (int i = 0; i < possibleMoves.length; i++) {
        pieces[possibleMoves[i]][1] = 'o';
        pieces[possibleMoves[i]][5] = 'king';
      }
    });

  }

  // returns true if a given index is between 0 ~ 35
  bool withinTheBoard(int index) {
    if (index >= 0 && index <= 35) {
      return true;
    }
    return false;
  }

  void onTappedSetup(int index, list) {
    setState(() {
      indexOfCurrentlySelectedPiece =
          13; //önce masadaki sonra setuptaki taşa basınca karışıklık olmasın diye.
    });

    //in Set Up phase, white player locates pawns
    if (list[index][2] == "white") {
      if (list[index][1] == "pawn") {
        setState(() {
          currentlySelectedPiece = "pawn";
          colorOfCurrentlySelectedPiece = "white";
          for (int i = 24; i < 30; i++) {
            if (pieces[i][1] == 'x') {
              pieces[i][1] = 'o';
            }
          }
          indexOfSelectedPieceInSetUp = index;
          setUpIsTapped = true;
        });
      } else {
        setState(() {
          currentlySelectedPiece = list[index][1];
          colorOfCurrentlySelectedPiece = list[index][2];
          for (int i = 30; i < 36; i++) {
            if (pieces[i][1] == 'x') {
              pieces[i][1] = 'o';
            }
          }
          indexOfSelectedPieceInSetUp = index;
          setUpIsTapped = true;
        });
      }
    }
    //in Set Up phase, black player locates pawns
    if (list[index][2] == "black") {
      if (list[index][1] == "pawn") {
        setState(() {
          currentlySelectedPiece = "pawn";
          colorOfCurrentlySelectedPiece = "black";
          for (int i = 6; i < 12; i++) {
            if (pieces[i][1] == 'x') {
              pieces[i][1] = 'o';
            }
          }
        });
        indexOfSelectedPieceInSetUp = index;
        setUpIsTapped = true;
      } else {
        setState(() {
          currentlySelectedPiece = list[index][1];
          colorOfCurrentlySelectedPiece = list[index][2];
          for (int i = 0; i < 6; i++) {
            if (pieces[i][1] == 'x') {
              pieces[i][1] = 'o';
            }
          }
          indexOfSelectedPieceInSetUp = index;
          setUpIsTapped = true;
        });
      }
    }
    print(currentlySelectedPiece + ', ' + colorOfCurrentlySelectedPiece);
  }

  void sacrificeBlack() {
    for (int i = 0; i < 36; i++) {
      if (pieces[i][2] == 'black') {
        setState(() {
          pieces[i][4] = 'k';
        });
      }
    }
  }

  void sacrificeWhite() {
    for (int i = 0; i < 36; i++) {
      if (pieces[i][2] == 'white') {
        setState(() {
          pieces[i][4] = 'k';
        });
      }
    }
  }

  void tapToSacrifice(index) {
    if (pieces[index][4] == 'k') {
      // record the pieces that are dead
      //for white
      if (pieces[index][2] == 'white') {
        if (pieces[index][1] != 'pawn') {
          if (readMoveType != readPieceForBluff) {
            //Bluff yaptığı için ölen taş
            deadWhitePieces.add([pieces[index][1], 'white']);
            if (killTry) {
              setState(() {
                pieces[index][1] = tempPiece;
                pieces[index][2] = tempColor;
              });
            }
          } else {
            //Ceza içeren seçim
            deadWhitePieces.add(['empty', 'white']);
            if('king' == pieces[index][1] ){
              setState(() {
                whiteKingEscaped = true;
              });
            }
            pieces[index][1] = 'x';
            pieces[index][2] = ' ';
          }
        } else {
          deadWhitePieces.add(['pawn', 'white']);
          pieces[index][1] = 'x';
          pieces[index][2] = ' ';
        }
        //for black
      } else if (pieces[index][2] == 'black') {
        if (pieces[index][1] != 'pawn') {
          if (readMoveType != readPieceForBluff) {
            //Bluff yaptığı için ölen taş
            deadBlackPieces.add([pieces[index][1], 'black']);
            if (killTry) {
              setState(() {
                pieces[index][1] = tempPiece;
                pieces[index][2] = tempColor;
              });
            }
          } else {
            //Ceza içeren seçim
            deadBlackPieces.add(['empty', 'black']);
            if('king' == pieces[index][1] ){
              setState(() {
                blackKingEscaped = true;
              });
            }
            pieces[index][1] = 'x';
            pieces[index][2] = ' ';
          }
        } else {
          deadBlackPieces.add(['pawn', 'black']);
          pieces[index][1] = 'x';
          pieces[index][2] = ' ';
        }
      }

      setState(() {
        if (killTry == false) {
          pieces[index][1] = 'x';
          pieces[index][2] = ' ';
        }
        bluffClaimed = false;
        bluffTime = false;
        singleReveal[indexOfLastMove] = false;
        indexOfLastMove = -1;
        killTry = false;
        claimedKing = false;
        aPieceIsSelected = false;
      });
      checkDeadPieceCount();
      unselectEverything();
    } else {
      return;
    }
  }

  void checkDeadPieceCount() {
    if (deadWhitePieces.length == 5) {
      blackScore = blackScore + 1;
      showAlertDialog(context, '3 White pieces left. Black scores.', 'white');
    }
    if (deadBlackPieces.length == 5) {
      whiteScore = whiteScore + 1;
      showAlertDialog(context, '3 Black pieces left. White scores.', 'black');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      whiteScore = widget.whiteScoreTaken;
      blackScore = widget.blackScoreTaken;
      whiteTurn = widget.whiteStarted;
      whiteStarted = widget.whiteStarted;
      memoryFactor = widget.memoryFactor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenInfo = MediaQuery.of(context).size;
    final screenWidth = screenInfo.width;
    final screenHeight = screenInfo.height;
    var listWhite = newWhitePieces ? setUpWhitePieces : setupWhitePawns;
    var listBlack = newBlackPieces ? setupBlackPieces : setupBlackPawns;
    var listToReduce = whiteTurn ? listWhite : listBlack;
    int denum = newWhitePieces ? 15 : 6;
    int denumB = newBlackPieces ? 15 : 6;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[300],
        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container( // Black Side
                //color: Colors.red,
                height: (screenHeight - screenWidth) / 2,
                child: setUpPhase
                    ? Container(
                        child: allBlackPiecesAreOn == false
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / denumB.toDouble()),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: screenWidth / denumB,
                                    );
                                  },
                                  itemCount: listBlack.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (whiteTurn == false) {
                                          onTappedSetup(index, listBlack);
                                          _onSelected(index);
                                        }
                                      },
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: _selectedIndex != null &&
                                                          _selectedIndex == index &&
                                                          whiteTurn == false
                                                      ? Colors.green[200]
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8))),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              child: Transform(
                                                  transform:
                                                      Matrix4.rotationX(math.pi),
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                      "images/${listBlack[index][1] + listBlack[index][2]}.png")),
                                            ),
                                          ]),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                height: screenHeight/11.44,
                                child: !whiteTurn
                                    ? Transform(
                                        transform: Matrix4.rotationY(math.pi),
                                        alignment: Alignment.center,
                                        child: Transform(
                                          transform: Matrix4.rotationX(math.pi),
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                hiddenBlack = true;
                                                whiteTurn = true;
                                                if (allWhitePiecesAreOn) {
                                                  setUpPhase = false;
                                                } //setup finished by black.
                                              });
                                            },
                                            child: Text('READY'),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                      )
                    : Transform(
                        transform: Matrix4.rotationX(math.pi),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(
                              width: screenHeight/screenWidth > 1.94 ? screenWidth / 2 : screenWidth / 2.5,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: screenHeight/32),
                                child: PlayerSideBlack(deadBlackPieces),
                              ),
                            ),
                            screenHeight/screenWidth < 1.94 ? Spacer() : Container(),
                            Container(
                              alignment: Alignment.center,
                              width: screenWidth / 2,
                              child: Padding(
                                padding: EdgeInsets.all(screenHeight/35),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Transform(
                                        transform: Matrix4.rotationY(math.pi),
                                        alignment: Alignment.center,
                                        child: showScore(blackScore)),
                                    memoryFactor == false && !whiteTurn
                                        ? showMyPieces(screenHeight, screenWidth)
                                        : Container(),
                                    !bluffTime && !whiteTurn && aPieceIsSelected && !killTry
                                        ? Transform(
                                            transform: Matrix4.rotationY(math.pi),
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                height: screenHeight/25,
                                                child: claimKing()))
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height: screenHeight/22,
                                                  child: Visibility(
                                                      child: Transform(
                                                          transform:
                                                              Matrix4.rotationY(
                                                                  math.pi),
                                                          alignment:
                                                              Alignment.center,
                                                          child: noButton()),
                                                      visible: bluffTime &&
                                                              !whiteTurn &&
                                                              killTry &&
                                                              !bluffClaimed ? true : false)),
                                              SizedBox(width: screenHeight/91.5),
                                              SizedBox(
                                                  height: screenHeight/22,
                                                  child: Visibility(
                                                      child: Transform(
                                                          transform:
                                                              Matrix4.rotationY(
                                                                  math.pi),
                                                          alignment:
                                                              Alignment.center,
                                                          child: claimBluff()),
                                                      visible: bluffTime &&
                                                              !whiteTurn &&
                                                              !bluffClaimed ? true : false)),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: screenWidth,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 36,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: row),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == pieces[index][0]) {
                      return Container(
                        color: Static.blackSquares.contains(index)
                            ? Colors.brown[300]
                            : Color(0xFFEDE9D0),
                        child: MyPiece(
                          piece: pieces[index][1],
                          color: pieces[index][2],
                          killMove: pieces[index][4],
                          hiddenWhite: hiddenWhite,
                          hiddenBlack: hiddenBlack,
                          thisPieceIsSelected: pieces[index][3],
                          singleReveal: singleReveal[index],
                          onTap: () {

                            //If you tap on a piece on board after select a piece from setup side.
                            if (pieces[index][1] != 'o' &&
                                pieces[index][1] != 'x' &&
                                pieces[index][1] != '' &&
                                setUpIsTapped == true) {
                              unselectEverything();
                              setUpIsTapped = false;
                              return;
                            }

                            setUpIsTapped = false;


                            if (bluffClaimed) {
                              tapToSacrifice(index);
                              return;
                            }

                            if(!killTry) {
                              tappedPiece(index, listToReduce);
                            }
                          },
                        ),
                      );
                    } else {
                      return Container(
                        color: Static.blackSquares.contains(index)
                            ? Colors.grey
                            : Colors.white,
                      );
                    }
                  }),
            ),
            //SizedBox(height: screenHeight / 25.48),
            Flexible(
              child: Container( //White Side
                //color: Colors.red,
                height: (screenHeight - screenWidth) / 2,
                child: setUpPhase
                    ? Container(
                        child: allWhitePiecesAreOn == false
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / denum.toDouble()),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: screenWidth / denum,
                                    );
                                  },
                                  itemCount: listWhite.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (whiteTurn) {
                                          onTappedSetup(index, listWhite);
                                          _onSelected(index);
                                        }
                                      },
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: _selectedIndex != null &&
                                                          _selectedIndex == index &&
                                                          whiteTurn
                                                      ? Colors.green[200]
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(12))),
                                            ),
                                            SizedBox(
                                                width: 50,
                                                child: Image.asset(
                                                    "images/${listWhite[index][1] + listWhite[index][2]}.png")),
                                          ]),
                                    );
                                  },
                                ))
                            : Container(
                                alignment: Alignment.center,
                                height: screenHeight/11.44,
                                child: whiteTurn
                                    ? ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            hiddenWhite = true;
                                            whiteTurn = false;
                                            if (allBlackPiecesAreOn) {
                                              setUpPhase = false;
                                            }
                                          });
                                        },
                                        child: Text('READY'))
                                    : Container(),
                              ),
                      )
                    : Row(children: [
                        SizedBox(
                            width: screenHeight/screenWidth > 1.94 ? screenWidth / 2 : screenWidth / 2.5,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: screenHeight/32),
                              child: PlayerSideWhite(deadWhitePieces),
                            )),
                         screenHeight/screenWidth < 1.94 ? Spacer() : Container(),
                        Container(
                          width: screenWidth / 2,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight/35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                showScore(whiteScore),
                                memoryFactor == false && whiteTurn
                                    ? showMyPieces(screenHeight, screenWidth)
                                    : Container(),
                                !bluffTime && whiteTurn && aPieceIsSelected && !killTry
                                    ? SizedBox(height: screenHeight/25,
                                      child: claimKing())
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: screenHeight/22,
                                              child: Visibility(
                                                  child: claimBluff(),
                                                  visible: bluffTime &&
                                                          whiteTurn &&
                                                          !bluffClaimed ? true : false)),
                                          SizedBox(width: screenHeight/91.5),
                                          SizedBox(
                                              height: screenHeight/22,
                                              child: Visibility(
                                                  child: noButton(),
                                                  visible: bluffTime &&
                                                          whiteTurn &&
                                                          killTry &&
                                                          !bluffClaimed ? true : false)),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ]),
              ),
            ),
          ],
        ),
        floatingActionButton: setUpPhase ? Center(child: whiteTurn ? buildSetRandomWhite() : buildSetRandomBlack())
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget showMyPieces(screenHeight, screenWidth) {
    return GestureDetector(
        onTapDown: (TapDownDetails tapDownDetails) {
          setState(() {
            if (whiteTurn) {
              hiddenWhite = !hiddenWhite;
            }
            if (!whiteTurn) {
              hiddenBlack = !hiddenBlack;
            }
          });
        },
        onTapCancel: () {
          setState(() {
            if (whiteTurn) {
              hiddenWhite = !hiddenWhite;
            }
            if (!whiteTurn) {
              hiddenBlack = !hiddenBlack;
            }
          });
        },
        onTapUp: (TapUpDetails tapUpDetails) {
          setState(() {
            if (whiteTurn) {
              hiddenWhite = !hiddenWhite;
            }
            if (!whiteTurn) {
              hiddenBlack = !hiddenBlack;
            }
          });
        },
        child: Container(
            height: screenHeight/22, width: screenWidth/11, child: Icon(Icons.remove_red_eye)));
  }

  Widget claimBluff() => ElevatedButton(
      onPressed: () {
        setState(() {
          bluffClaimed = true;
          singleReveal[indexOfLastMove] = true;
        });

        if (readMoveType != readPieceForBluff) {
          print('bluff yakalandı!');
          //Sacrifice works for opponent,
          if (whiteTurn) {
            //black sacrifices,
            //yakalanan taş ölüyor,
            pieces[indexOfLastMove][4] = 'k';
            if (pieces[indexOfLastMove][1] == 'king') {
              whiteScore = whiteScore + 1;
              showAlertDialog(context, 'The Black King has caught in disguise', 'black');
            }
          } else {
            //white sacrifices,
            //yakalanan taş ölüyor,
            pieces[indexOfLastMove][4] = 'k';
            if (pieces[indexOfLastMove][1] == 'king') {
              blackScore = blackScore + 1;
              showAlertDialog(context, 'The White King has caught in disguise', 'white');
            }
          }
        } else {
          print('bluff yoktu.');
          //Sacrifice works for the turn owner,
          if (whiteTurn) {
            //white sacrifices,
           if(readPieceForBluff ==  'king') {
             blackScore = blackScore + 1;
             showAlertDialog(context, 'It was really a black king. Black scores.', 'white');
           }
            if (killTry) {
              if (tempPiece == 'king') {
                blackScore = blackScore + 1;
                showAlertDialog(context, 'White King is dead', 'white');
              }
              if (tempPiece == 'queen') {
                deadBlackPieces.add([pieces[indexOfLastMove][1], pieces[indexOfLastMove][2]]);
                pieces[indexOfLastMove][1] = 'x';
                pieces[indexOfLastMove][2] = '';
              }
              deadWhitePieces.add([tempPiece, tempColor]);
            }

            checkDeadPieceCount();
            sacrificeWhite();
          } else {
            //black sacrifices,
            if(readPieceForBluff ==  'king') {
              whiteScore = whiteScore + 1;
              showAlertDialog(context, 'It was really a white king. White scores.', 'black');
            }
            if (killTry) {
              if (tempPiece == 'king') {
                whiteScore = whiteScore + 1;
                showAlertDialog(context, 'Black King is dead', 'black');
              }
              if (tempPiece == 'queen') {
                deadWhitePieces.add([pieces[indexOfLastMove][1], pieces[indexOfLastMove][2]]);
                pieces[indexOfLastMove][1] = 'x';
                pieces[indexOfLastMove][2] = '';
              }
              deadBlackPieces.add([tempPiece, tempColor]);
            }
            checkDeadPieceCount();
            sacrificeBlack();
          }
        }
      },
      child: const Text('Claim\nBluff', style: TextStyle(fontSize: 11),));

  Widget noButton() => ElevatedButton(
      onPressed: () {
        setState(() {
          if (tempColor == 'white') {
            deadWhitePieces.add([tempPiece, tempColor]);
            if (tempPiece == 'king') {
                blackScore = blackScore + 1;
              showAlertDialog(context, 'The White King is dead', 'white');
            }
            if (tempPiece == 'queen') {
              deadBlackPieces.add([pieces[indexOfLastMove][1], pieces[indexOfLastMove][2]]);
              if(pieces[indexOfLastMove][1] == 'king') {
                  whiteScore = whiteScore + 1;
                showAlertDialog(context, "Queen's revenge! Black king is dead.", 'black');
              }
              pieces[indexOfLastMove][1] = 'x';
              pieces[indexOfLastMove][2] = '';
            }
          } else if (tempColor == 'black') {
            deadBlackPieces.add([tempPiece, tempColor]);
            if (tempPiece == 'king') {
                whiteScore = whiteScore + 1;
              showAlertDialog(context, 'The Black King is dead', 'black');
            }
            if (tempPiece == 'queen') {
              deadWhitePieces.add([pieces[indexOfLastMove][1], pieces[indexOfLastMove][2]]);
              if(pieces[indexOfLastMove][1] == 'king') {
                  blackScore = blackScore + 1;
                showAlertDialog(context, "Queen's revenge! White king is dead." ,'white');
              }
              pieces[indexOfLastMove][1] = 'x';
              pieces[indexOfLastMove][2] = '';
            }
          }
          checkDeadPieceCount();
          unselectEverything();
          aPieceIsSelected = false;
          killTry = false;
          bluffTime = false;
        });
      },
      child: const Text('NO'));

  Widget claimKing() {
    return claimedKing == false
        ? ElevatedButton(
            onPressed: () {
              setState(() {
                claimedKing = true;
                unselectEverything();
                tappedKing(indexOfCurrentlySelectedPiece);
              });
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Claim King'), Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset('images/king.png'),
                )]),
          )
        : ElevatedButton(
            onPressed: () {
              setState(() {
                unselectEverything();
                claimedKing = false;
                tappedRook(indexOfCurrentlySelectedPiece);
                tappedBishop(indexOfCurrentlySelectedPiece);
                tappedKnight(indexOfCurrentlySelectedPiece);
              });
            },
            child: Text('Cancel'));
  }

 Widget showScore(score) => Text("Score: $score", style: TextStyle(color: Colors.white),);
 Widget buildSetRandomWhite() => FloatingActionButton.extended(
   backgroundColor: Color(0xFFE27046),
   label: Text('SET\nRONDOM',
       textAlign: TextAlign.center,
       style: TextStyle(color: Colors.white, fontSize: 12)),
   onPressed: () {
     print('Random White Set');
   },
 );
  Widget buildSetRandomBlack() => FloatingActionButton.extended(
    backgroundColor: Color(0xFFFFF4EC),
    label: Transform(
      transform: Matrix4.rotationX(math.pi),
      alignment: Alignment.center,
      child: Transform(
          transform: Matrix4.rotationY(math.pi),
          alignment: Alignment.center,
          child: Text('SET\nRONDOM',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 12))),
    ),
    onPressed: () {
      print('Random Black Set');
    },
  );
}
