import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

import '../helpers/files.dart';
import '../helpers/rsa.dart';

class RSAGenerateButton extends StatelessWidget {
  final _color = Color.fromRGBO(40, 143, 247, 0.7);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: _color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Text(
              'RSA',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          NiceButton(
            background: Colors.white,
            text: 'Generate keys',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              RSA.generateKeys();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Privatni i javni ključ su spremljeni'),
                ),
              );
            },
          ),
          SizedBox(
            height: 50,
          ),
          NiceButton(
            background: Colors.white,
            text: 'Encrypt file',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              String chosenFilePath = await Files.getPickedFilePath();
              bool result = await RSA.encryptFile(chosenFilePath);
              if (result) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Datoteka je kriptirana [RSACrypt]'),
                ));
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
          NiceButton(
            background: Colors.white,
            text: 'Decrypt file',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              String chosenFilePath = await Files.getPickedFilePath();
              bool result = await RSA.decryptFile(chosenFilePath);
              if (result) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Datoteka je dekriptirana [RSADecrypt]'),
                ));
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
