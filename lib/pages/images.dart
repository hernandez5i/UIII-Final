import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagesPage extends StatelessWidget {
  final List<String> images = [
    'https://raw.githubusercontent.com/hernandez5i/img_IOS/main/zapato3.png', // URL de la imagen 1
    'https://raw.githubusercontent.com/hernandez5i/img_IOS/main/zapato2.png', // URL de la imagen 2
    'https://raw.githubusercontent.com/hernandez5i/img_IOS/main/zapato.png', // URL de la imagen 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrusel de Imágenes'),
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: images.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImagesPage(),
  ));
}
