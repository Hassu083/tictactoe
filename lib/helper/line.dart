import 'package:flutter/material.dart';

class Lines extends StatelessWidget {

  double? width;
  double? height;
  Color color;
  double? top;
  double? left;
  double angle;

  Lines(this.width, this.height, this.color, this.top, this.left, this.angle);


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,       //width1*(4.123/5) total width
      left:left,
      child: Transform.rotate(
// 0 horizontal, 20.4 vertical, \ 35.35 and / 2.38
        angle: angle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: (height ?? 0),
          width: (width ?? 0),
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all( Radius.circular(5))
          ),
        ),
      ),
    );
  }
}
