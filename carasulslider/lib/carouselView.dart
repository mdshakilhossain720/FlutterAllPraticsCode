import 'package:flutter/material.dart';

class CarouselviewScren extends StatelessWidget {
  const CarouselviewScren({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight:180 ),
      child: CarouselView(itemExtent: 200,shrinkExtent: 200, children: List.generate(10, (index) => Container(
        margin: EdgeInsets.all(10),
        color: Colors.primaries[index % Colors.primaries.length],
      ))),

    );
  }
}
