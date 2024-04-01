import 'package:basic/level_selection/constants.dart';
import 'package:basic/level_selection/game_object.dart';
import 'package:flutter/material.dart';

class Obstacle extends GameObject {
  Obstacle({required this.positionY, required this.offsetX});

  double positionY;
  double offsetX;

  final double width = 60;
  final double height = 50;

  @override
  Widget render() => Image.asset(
        "assets/graphics/lto.png",
        fit: BoxFit.fill,
      );

  double _calculateTop(Size screenSize) {
    const boundArea = 0.1;
    final topBound = screenSize.height * boundArea;
    final usableArea = screenSize.height * (1 - boundArea * 2) - height;

    return topBound + usableArea * positionY;
  }

  double _calculateX(double runDistance) {
    return (offsetX - runDistance) * Constants.worldToPixelRatio;
  }

  @override
  Rect getRect(Size screenSize, double runDistance) => Rect.fromLTWH(
        _calculateX(runDistance),
        _calculateTop(screenSize),
        width,
        height,
      );
}
