import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverContainer extends StatelessWidget {
  const GameOverContainer({required this.onRestartTap, super.key});

  final void Function() onRestartTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      left: 0,
      top: 0,
      width: screenSize.width,
      height: screenSize.height,
      child: GestureDetector(
        onTap: () {},
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 73, 73, 0.6),
          ),
          child: Center(
            child: Card(
              color: Color.fromARGB(255, 100, 23, 23),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Oh No! Checkpoint!",
                      textAlign: TextAlign.center,
                     style: GoogleFonts.cinzel(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 40,
                          height: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: onRestartTap,
                      child: Text('Play Again',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 3, 3, 3),
                          fontSize: 15,
                          height: 1,
                        ),
                      ),),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context,
                        );
                      },
                      child: Text('Back',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: const Color.fromARGB(255, 3, 3, 3),
                          fontSize: 15,
                          height: 1,
                        ),
                      ),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
