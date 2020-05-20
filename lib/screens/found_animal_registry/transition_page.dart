import 'package:flutter/material.dart';
import 'package:petsaojoao/screens/found_animal_registry/address_register.dart';

class Transition extends StatefulWidget {
  final String rua;
  final String numero;
  final String bairro;
  final String municipio;
  Transition({
    Key key,
    this.rua,
    this.numero,
    this.bairro,
    this.municipio,
  }) : super(key: key);
  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddressRegister(
            rua: widget.rua,
            numero: widget.numero,
            bairro: widget.bairro,
            municipio: widget.municipio,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.blue,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 12),
              child: Image.asset("assets/background/top_paws.png"),
            ),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Guardamos suas fotos ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 35, letterSpacing: 1.5),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Image.asset("assets/background/bottom_paws.png"),
            ),
          ],
        ),
      ],
    );
  }
}
