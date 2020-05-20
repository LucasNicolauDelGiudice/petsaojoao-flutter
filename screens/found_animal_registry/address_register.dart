import 'package:flutter/material.dart';

class AddressRegister extends StatelessWidget {
  final String rua;
  final String numero;
  final String bairro;
  final String municipio;
  AddressRegister({
    this.rua,
    this.numero,
    this.bairro,
    this.municipio,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// botão inferior
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Container(
          width: 60,
          height: 60,
          color: Colors.blue,
          child: IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {}),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: EdgeInsets.only(top: 75),
              color: Colors.blue,
              child: Text(
                "Confirme o endereço",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1.5),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Esses dados serão divulgados",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black, letterSpacing: 1.5)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Detalhes do widget no final da página
            info(rua + ", $numero"),
            SizedBox(
              height: 20,
            ),
            info(bairro),
            SizedBox(
              height: 20,
            ),
            info(municipio),
          ],
        ),
      ),
    );
  }

  Widget info(String texto) {
    return Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Card(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
              initialValue: texto,
              style: TextStyle(color: Colors.black, letterSpacing: 1.5),
            ),
          ),
        ));
  }
}
