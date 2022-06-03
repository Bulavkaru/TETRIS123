import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class NextBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFf789b4)
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Next',
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4,),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  ),
                child: Center(
                  child: Provider.of<Data>(context).getNextBlockWidget(),

                ),
              ),
            ),
          ],
        ),
    );
  }
}
