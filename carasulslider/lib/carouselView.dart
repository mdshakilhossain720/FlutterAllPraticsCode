import 'package:flutter/material.dart';

class CarouselviewScren extends StatelessWidget {
  const CarouselviewScren({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight:80 ),
        child: CarouselView(
              itemExtent: 200,
          // scrollDirection: Axis.vertical,
        shrinkExtent: 100, children: List.generate(10, (index) => Container(
          margin: EdgeInsets.all(10),
          color: Colors.primaries[index % Colors.primaries.length],
        ))),
      
      ),
    );
  }
}
