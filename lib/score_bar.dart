import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class ScoreBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScoreBarState();
}

class _ScoreBarState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFf789b4)
        ,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'NekoPoint: ${Provider.of<Data>(context,listen:true).score}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}