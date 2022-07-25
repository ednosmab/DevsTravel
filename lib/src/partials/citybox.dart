import 'package:flutter/material.dart';

class CityBox extends StatelessWidget {
  CityBox({
    this.data,
    required this.onTap,
  });
  final data;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: GestureDetector(
            onTap: () {
              onTap(data);
            },
            child: Stack(
              children: [
                // Definindo tamanho da imangem
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(data['places'][0]['img'],
                          fit: BoxFit.cover),
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black])))),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Text(
                      data['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ))
              ],
            )));
  }
}
