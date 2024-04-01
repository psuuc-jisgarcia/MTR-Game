import 'package:basic/level_selection/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LobbyScreen extends StatelessWidget {
  const LobbyScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOver,
              ),
              child: Image.asset(
                'assets/graphics/mainn.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MainPage()),
        );
      },
      icon: Icon(Icons.play_arrow_rounded),
      iconSize: 60,
      color: Color.fromARGB(255, 157, 7, 7),
    ),
    Text(
      'Start', 
      style: TextStyle(
        color: Color.fromARGB(255, 157, 7, 7), 
        fontSize: 16,
      ),
    ),
                  SizedBox(height: 10),
                  Text(
                    "Enjoy a delightful and straightforward gaming experience as you navigate through the streets, avoiding LTO's (Land Transportation Office) in your trusty tricycle. Test your reflexes and have a blast dodging obstacles in this easy and fun-filled adventure!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Go back to Home',
                          style: TextStyle(
                            color: Color.fromARGB(255, 157, 7, 7), 
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
