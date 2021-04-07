import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

import '../helpers/files.dart';
import '../helpers/sha.dart';

class SHAGenerateButton extends StatelessWidget {
  final _color = Color.fromRGBO(40, 40, 247, 0.7);
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
              'SHA',
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
            text: 'Calculate hash',
            textColor: _color,
            elevation: 20,
            radius: 15,
            onPressed: () async {
              String chosenFilePath = await Files.getPickedFilePath();
              String result = await SHA.generateHash(chosenFilePath);
              if (result != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sažetak je izračunat. [DIGEST]'),
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