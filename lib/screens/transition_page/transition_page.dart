import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petsaojoao/Cadastro_endere%C3%A7o/cadastro_endereco.dart';

class _TransitionState extends State {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CadastroEndereco(
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
              child: Image.asset("images/superior.png"),
            ),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Guardamos suas fotos ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.acme(
                      color: Colors.white, fontSize: 35, letterSpacing: 1.5),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Image.asset("images/inferior.png"),
            ),
          ],
        ),
      ],
    );
  }
}
