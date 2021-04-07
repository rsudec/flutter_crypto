import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import '../helpers/signature.dart';
import '../helpers/files.dart';

class SignatureGenerateButton extends StatelessWidget {
  final _color = Color.fromRGBO(250, 42, 191, 0.7);
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
              'DIGITAL SIGNATURE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          NiceButton(
            background: Colors.white,
            text: 'Sign a document',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              String chosenFilePath = await Files.getPickedFilePath();
              String result = await SIGNATURE.signFile(chosenFilePath);
              if (result != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Datoteka je potpisana. [SIGNATURE]'),
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
            text: 'Verify a document',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              String plainTextPath = await Files.getPickedFilePath();
              String signaturePath = await Files.getPickedFilePath();
              int result =
                  await SIGNATURE.verifySignature(plainTextPath, signaturePath);
              if (result == 1) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Potpis je važeći. [SIGNATURE]'),
                  ),
                );
              } else if (result == 0) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Potpis nije važeći. [SIGNATURE]'),
                  ),
                );
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