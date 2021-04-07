import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

import '../helpers/files.dart';
import '../helpers/aes.dart';

class AESGenerateButton extends StatelessWidget {
  final _color = Color.fromRGBO(143, 40, 247, 0.7);
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
              'AES',
              style: TextStyle(
                fontSize: 48,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          NiceButton(
            background: Colors.white,
            text: 'Generate key',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              await AES.generateSecret();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Tajni AES ključ je spremljen: ${await AES.readAesSecret()}'),
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
              File result = await AES.encryptFile(chosenFilePath);
              if (result != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Datoteka je kriptirana [AESCrypt]'),
                  ),
                );
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
              String result = await AES.decryptFile(chosenFilePath);
              if (result != null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Datoteka je dekriptirana [AESDecrypt]'),
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