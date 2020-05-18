import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
//Acompanhe desing do projeto aqui --> https://www.figma.com/file/GYFrt79mzIbOUXXmFyDgwL/Material-Baseline-Design-Kit?node-id=38%3A5814

class CadastroAnimalEncontrado extends StatefulWidget {
  @override
  _CadastroAnimalEncontradoState createState() =>
      _CadastroAnimalEncontradoState();
}

class _CadastroAnimalEncontradoState extends State<CadastroAnimalEncontrado> {
  File _image;
  List<File> imagens = [];
  int currentIndex = -1;
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      try {
        await ImagePicker.pickImage(
          source: ImageSource.camera,
        ).then((file) {
          if (file == null) return;

          setState(() {
            _image = file;
            imagens.add(_image);
            count++;
            currentIndex++;
            print(count);
            print(file);
          });
        });
      } catch (e) {
        print(e);
      }
    }


    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 400,
                  child: _image != null || imagens.length != 0
                      ? Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: <Widget>[
                            Image.file(imagens[currentIndex],
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover),
                            Positioned(
                              bottom: 15.0,
                              left: 0.0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagens.removeAt(currentIndex);
                                    imagens.length == 0
                                        ? _image = null
                                        : print("");
                                    print(imagens.length);
                                    count--;
                                    currentIndex = imagens.length - 1;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              left: 0.0,
                              top: MediaQuery.of(context).size.height / 4,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: currentIndex > 0 && count != 1
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: currentIndex > 0 && count != 1
                                    ? () {
                                        setState(() {
                                          currentIndex--;
                                        });
                                      }
                                    : null,
                              ),
                            ),
                            Positioned(
                              right: 0.0,
                              top: MediaQuery.of(context).size.height / 4,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: currentIndex < count - 1 && count != 1
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed:
                                    currentIndex < count - 1 && count != 1
                                        ? () {
                                            setState(() {
                                              currentIndex++;
                                            });
                                          }
                                        : null,
                              ),
                            )
                          ],
                        )
                      : Image.network(
                          "https://belatintas.fbitsstatic.net/img/p/produto-nao-possui-foto-no-momento/sem-foto.jpg?w=420&h=420&v=no-change",
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "$count " + "de 3 ",
                          style: GoogleFonts.acme(
                              fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: "fotos registradas",
                          style: GoogleFonts.oxygen(
                              fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: imagens.map((m) {
                      return imagens.length == 0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 45,
                              width: 40,
                              child: Image.file(
                                m,
                                fit: BoxFit.cover,
                              ),
                            );
                    }).toList()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: Colors.black,
                ),
                SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.blue,
                      child: IconButton(
                        icon: Icon(
                          count < 3 ? Icons.camera_alt : Icons.check,
                          color: Colors.white,
                          size: 50,
                        ),
                        onPressed: imagens.length != 3
                            ? getImage
                            : () async {
                                await (context);
                              },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
