import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../pages/aes_page.dart';
import '../pages/rsa_page.dart';
import '../pages/sha_page.dart';
import '../pages/signature_page.dart';


class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40,
        ),
        child: Center(
          child: CarouselSlider(
            height: 700,
            enlargeCenterPage: true,
            items: <Widget>[
              AESGenerateButton(),
              RSAGenerateButton(),
              SHAGenerateButton(),
              SignatureGenerateButton(),
            ],
          ),
        ),
      ),
    );
  }
}
