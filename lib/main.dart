import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'score_bar.dart';
import 'game.dart';
import 'next_block.dart';
import 'block.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => Data(),
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      home: Tetris(),
      theme: ThemeData (fontFamily: 'Kalam')
    );
  }
}

class Tetris extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  GlobalKey<GameState> _keyGame = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container (
            height: 55,
            child : Image.asset("assets/images/logo.png")
        ),
        centerTitle: true,
        flexibleSpace: const Image(
            image: AssetImage('assets/images/logotexrure.png'),
            fit: BoxFit.cover
        ),
      ),
      backgroundColor: Color(0xFFffc6de),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ScoreBar(),
            Expanded(
              child: Center(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                      child: Game(key: _keyGame),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          NextBlock(),
                          SizedBox(height: 30,),
                          RaisedButton(
                            child: Text(
                              Provider.of<Data>(context).isPlaying
                                  ? 'End' : 'Start',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[200],
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            color: Color(0xFFf789b4),
                            onPressed: () {
                              Provider.of<Data>(context,listen:false).isPlaying
                                  ? _keyGame.currentState.endGame()
                                  : _keyGame.currentState.startGame();
                            },
                          ),
                        ],
                      ),),
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Data with ChangeNotifier {
  int score = 0;
  bool isPlaying = false;
  Block nextBlock;

  void setScore(score) {
    this.score = score;
    notifyListeners();
  }

  void addScore(score) {
    this.score += score;
    notifyListeners();
  }

  void setIsPlaying(isPlaying) {
    this.isPlaying = isPlaying;
    notifyListeners();
  }

  void setNextBlock(Block nextBlock) {
    this.nextBlock = nextBlock;
    notifyListeners();
  }

  Widget getNextBlockWidget() {
    if (!isPlaying) return Container();

    var width = nextBlock.width;
    var height = nextBlock.height;
    var color;

    List<Widget> columns = [];
    for (var y = 0; y < height; ++y) {
      List<Widget> rows = [];
      for (var x = 0; x < width; ++x) {
        if (nextBlock.subBlocks
            .where((subBlock) => subBlock.x == x && subBlock.y == y)
            .length >
            0) {
          color = nextBlock.color;
        } else {
          color = Colors.transparent;
        }

        rows.add(
            Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(2))
                ),
            )
        );
      }

      columns.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: rows),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: columns,
    );
  }
}