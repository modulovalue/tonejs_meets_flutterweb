import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:modulovalue_project_widgets/all.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone.js & Flutter Web Piano Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  double width = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8.0),
          ...modulovalueTitle(
              "Tone.js & Flutter Web Piano Demo", "tonejs_meets_flutterweb"),
          SizedBox(height: 12.0),
          Text("Size: ${width.round()}"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 40.0,
              child: Slider(
                value: width,
                min: 28.0,
                max: 100.0,
                onChanged: (value) => setState(() => width = value),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(10, (octave) => Octave(width, octave)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class Octave extends StatelessWidget {
  final double width;
  final int octave;

  const Octave(this.width, this.octave);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: ["C", "D", "E", "F", "G", "A", "B"].map((char) {
            return WhiteKey(
              text: Text(
                "$char$octave",
                textAlign: TextAlign.center,
              ),
              onTap: () =>
                  js.context.callMethod("playNote", ["$char$octave", "8n"]),
              width: width,
            );
          }).toList(),
        ),
        Padding(
          padding: EdgeInsets.only(left: width / 2),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: ["C#", "D#", null, "F#", "G#", "A#"].map((char) {
                if (char == null) return SizedBox(width: width, height: 0.0);

                return BlackKey(
                  offsetToTheBottom: constraints.biggest.height * 0.3,
                  onTap: () =>
                      js.context.callMethod("playNote", ["$char$octave", "8n"]),
                  width: width,
                  text: Text(
                    "$char$octave",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}

class BlackKey extends StatelessWidget {
  final void Function() onTap;
  final Widget text;
  final double width;
  final double offsetToTheBottom;

  const BlackKey({
    @required this.onTap,
    @required this.text,
    @required this.width,
    @required this.offsetToTheBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: offsetToTheBottom),
      child: InkWell(
        onTap: onTap,
        child: Container(
          // to offset the scrollbar
          padding: EdgeInsets.only(bottom: 12.0),
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey[800]),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.2),
                offset: Offset(0.0, 5.0),
                blurRadius: 5.0,
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width / 4),
              bottomRight: Radius.circular(width / 4),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: text,
        ),
      ),
    );
  }
}

class WhiteKey extends StatelessWidget {
  final void Function() onTap;
  final Widget text;
  final double width;

  const WhiteKey({
    @required this.onTap,
    @required this.text,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          // to offset the scrollbar
          padding: EdgeInsets.only(bottom: 12.0),
          width: width,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey[800]),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width / 4),
              bottomRight: Radius.circular(width / 4),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: text,
        ),
      ),
    );
  }
}
