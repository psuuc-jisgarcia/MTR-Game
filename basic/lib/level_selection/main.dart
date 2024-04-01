import 'dart:math';
import 'package:basic/level_selection/counter.dart';
import 'package:basic/level_selection/game_over_container.dart';

import 'package:basic/level_selection/tricycle.dart';
import 'package:basic/level_selection/lto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<dynamic> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tricycle Chronicles',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController worldController;

  int score = 0; // Local variable to store the score
  double runDistance = 0;
  double runVelocity = 20;
  Duration lastUpdateCall = Duration.zero;
  List<Obstacle> obstacleList = [
    Obstacle(positionY: Random().nextDouble(), offsetX: 200)
  ];
  bool showRestart = false;

  final ninja = Ninja();
  final foreverDuration = const Duration(days: 99);

  @override
  void initState() {
    super.initState();
    worldController = AnimationController(
      vsync: this,
      duration: const Duration(days: 99),
    );
    worldController
      ..addListener(_update)
      ..forward();
  }

  void _die() {
    setState(() {
      showRestart = true;
      worldController.stop();
    });
  }

  void _update() {
    final worldControllerElapsed =
        worldController.lastElapsedDuration ?? Duration.zero;

    ninja.update(lastUpdateCall, worldControllerElapsed);

    final elapsedSeconds =
        (worldControllerElapsed - lastUpdateCall).inMilliseconds / 1000;

    runDistance += runVelocity * elapsedSeconds;

    final screenSize = MediaQuery.of(context).size;
    final ninjaRect = ninja.getRect(screenSize, runDistance);

    var shouldAdd = false;
    final toRemove = <Obstacle>[];

    for (final obstacle in obstacleList) {
      final obstacleRect = obstacle.getRect(screenSize, runDistance);

      if (ninjaRect.overlaps(obstacleRect)) {
        _die();
      }

      final leftThreshold = Random().nextInt(50);
      final rightThreshold = Random().nextInt(100) + 50;

      if (obstacleRect.right > leftThreshold &&
          obstacleRect.right < rightThreshold) {
        shouldAdd = true;
      }

      if (obstacleRect.right < 0) {
        score += 1;
        toRemove.add(obstacle);
      }
    }

    if (obstacleList.length < 5 && shouldAdd) {
      setState(() {
        obstacleList.add(
          Obstacle(
            positionY: Random().nextDouble(),
            offsetX: runDistance + Random().nextInt(150) + 50,
          ),
        );
      });
    }

    setState(() {
      obstacleList.removeWhere(toRemove.contains);
    });

    lastUpdateCall = worldControllerElapsed;
    if (elapsedSeconds != 0 && elapsedSeconds % 10 == 0) {
      runVelocity += 30;
    }
  }

  void _restart() {
    showRestart = false;
    score = 0;
    ninja.restart();
    obstacleList
      ..clear()
      ..add(Obstacle(positionY: Random().nextDouble(), offsetX: 200));
    worldController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final children = <Widget>[
      Container(
        color: Colors.blueAccent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/graphics/bggame.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(
              0.1), // Black color with 50% opacity// Your other widgets here
        ),
      )
    ];

    for (final gameObject in [...obstacleList, ninja]) {
      children.add(
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            final rect = gameObject.getRect(screenSize, runDistance);
            return Positioned(
              left: rect.left,
              top: rect.top,
              width: rect.width,
              height: rect.height,
              child: gameObject.render(),
            );
          },
        ),
      );
    }

    children..add(Counter(score: score)); // Pass the local score variable

    if (showRestart) {
      children.add(
        GameOverContainer(
          onRestartTap: _restart,
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: ninja.jump,
        child: Stack(
          alignment: Alignment.center,
          children: children,
        ),
      ),
    );
  }
}
