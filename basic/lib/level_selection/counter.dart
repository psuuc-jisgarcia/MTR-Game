import 'package:basic/level_selection/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Counter extends StatelessWidget {
  const Counter({required this.score, Key? key}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Positioned(
      left: screenSize.width / 2 - 40, // Adjusted to center horizontally
      top: screenSize.height * Constants.boundArea,
      width: 150,
      height: 150,
      child: SizedBox(
        width: double.infinity,
        height: 40, // Limit the height of the column
        child: Center( // Center the Counter horizontally
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Score: $score",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          height: 1,
                        ),
                      ),
                    ),
                  ),              
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
