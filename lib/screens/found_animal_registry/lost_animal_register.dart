import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:petsaojoao/models/back_lost_animal/locate_animal.dart';
import 'package:petsaojoao/screens/found_animal_registry/transition_page.dart';
import 'package:camera/camera.dart';
//Acompanhe desing do projeto aqui --> https://www.figma.com/file/GYFrt79mzIbOUXXmFyDgwL/Material-Baseline-Design-Kit?node-id=38%3A5814

class FoundAnimalRegister extends StatefulWidget {
  @override
  _FoundAnimalRegisterState createState() => _FoundAnimalRegisterState();
}

class _FoundAnimalRegisterState extends State<FoundAnimalRegister> {
  double latitude;
  double longitude;
  Position currentLocation;
  PickedFile _image;
  List<PickedFile> images = [];
  int currentIndex = -1;
  int count = 0;
  int numPath = 0;
  final _picker = ImagePicker();

  /// variável na muneração da pasta no storage
  List<Address> addresses = [];
  Address first;
  String street;
  String number;
  String neighborhood;
  String county;

  Future getAnimalLocation() async {
    currentLocation = await locateAnimal();
    setState(() {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
    });
    print(latitude);
    print(longitude);
  }

  Future getLocation() async {
    final coordinates = new Coordinates(latitude, longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    setState(() {
      street = first.thoroughfare;
      number = first.subThoroughfare;
      neighborhood = first.subLocality;
      county = first.subAdminArea;
    });
  }

  @override
  void initState() {
    super.initState();
    images.clear();
    getAnimalLocation().then((value) => getLocation());
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      try {
        await _picker
            .getImage(
          source: ImageSource.camera,
        )
            .then((file) {
          if (file == null) return;

          setState(() {
            _image = file;
            images.add(_image);
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

    Future uploadImage(BuildContext context) async {
      images.map((img) async {
        String urlmage = basename(img.path);
        StorageReference fireRef =
            FirebaseStorage.instance.ref().child("imagens $numPath/" + urlmage);
        StorageUploadTask uploadTask = fireRef.putFile(File(img.path));
        await uploadTask.onComplete;
      }).toList();
      setState(() {
        numPath++;
        Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text(
                "Imagens salvas com sucesso!",
              ),
              backgroundColor: Colors.green),
        );
      });
      await Future.delayed(Duration(seconds: 3)).then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Transition(
              street: street,
              number: number,
              neighborhood: neighborhood,
              county: county,
            ),
          ),
        );
      });
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
                  child: _image != null || images.isNotEmpty
                      ? Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: <Widget>[
                            Image.file(File(images[currentIndex].path),
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
                                    images.removeAt(currentIndex);
                                    images.isEmpty ? _image = null : print("");
                                    print(images.length);
                                    count--;
                                    currentIndex = images.length - 1;
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
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        TextSpan(
                          text: "fotos registradas",
                          style: TextStyle(fontSize: 15, color: Colors.black),
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
                        children: images.map((m) {
                      return images.isEmpty
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 45,
                              width: 40,
                              child: Image.file(
                                File(m.path),
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
                SizedBox(
                    height: images.isEmpty
                        ? MediaQuery.of(context).size.height / 8
                        : MediaQuery.of(context).size.height / 18),
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
                        onPressed: images.length != 3
                            ? getImage
                            : () async {
                                await uploadImage(context);
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
