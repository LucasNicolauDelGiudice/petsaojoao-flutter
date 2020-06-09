import 'package:flutter/material.dart';
import 'package:petsaojoao/screens/found_animal_registry/address_register.dart';
import 'dart:async';
import 'package:petsaojoao/components/foundation_form/splash_screen_foundation.dart';

//Acompanhe desing do projeto aqui --> https://www.figma.com/file/GYFrt79mzIbOUXXmFyDgwL/Material-Baseline-Design-Kit?node-id=38%3A5814

class Transition extends StatefulWidget {
  final String street;
  final String number;
  final String neighborhood;
  final String county;
  Transition({
    Key key,
    this.street,
    this.number,
    this.neighborhood,
    this.county,
  }) : super(key: key);
  @override
  _RegPetState createState() => _RegPetState();
}

class _RegPetState extends State<Transition> {
  void navigationToNextPage() {
    //Navigator.push(context, _createRoute());
    Navigator.pushReplacement(context, _createRoute());
  }

  startCadTutorTimer() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startCadTutorTimer();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent[200],
        body: SplahScreenFoundation("Guardamos suas fotos"),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddressRegister(
        street: widget.street,
        number: widget.number,
        neighborhood: widget.neighborhood,
        county: widget.county,
      ),
      transitionDuration: const Duration(milliseconds: 1800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
