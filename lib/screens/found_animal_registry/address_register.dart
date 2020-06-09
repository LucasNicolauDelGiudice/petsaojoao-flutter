import 'package:flutter/material.dart';

class AddressRegister extends StatefulWidget {
  final String street;
  final String number;
  final String neighborhood;
  final String county;
  AddressRegister(
      {Key key, this.street, this.neighborhood, this.number, this.county})
      : super(key: key);
  @override
  _AddressRegisterState createState() => _AddressRegisterState();
}

class _AddressRegisterState extends State<AddressRegister> {
  bool isEditable = false;
  TextEditingController _streetController;
  TextEditingController _neighborhoodController;
  TextEditingController _countyController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// botão inferior
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            backgroundColor: Colors.blue[200],
            heroTag: "btn1",
            child: Icon(
              Icons.edit,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isEditable = !isEditable;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            child: Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
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
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 1.5)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// Detalhes do widget no final da página
            info(widget.street + ", ${widget.number}", isEditable,
                _streetController),
            SizedBox(
              height: 20,
            ),
            info(widget.neighborhood, isEditable, _neighborhoodController),
            SizedBox(
              height: 20,
            ),
            info(widget.county, isEditable, _countyController),
          ],
        ),
      ),
    );
  }

  Widget info(String texto, bool isEditable, TextEditingController controller) {
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
              controller: controller,
              enabled: isEditable,
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
