import 'package:flutter/material.dart';

import '../../common/widgets/text_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Image.network(
                    'https://picsum.photos/300/200',
                    fit: BoxFit.cover,
                  ),
          
                  // Text(
                  //   "First see leanr flutter",
                  //   style: TextStyle(
                  //     color: Colors.blue,
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                  text24Normal(text: "First see leanr flutter"),
                ],
              ),
            ],
          ),
          // Positioned(bottom: 100, left: 20, child: Text("Welcome")),
          // Positioned(
          //   // bottom: 100,
          //   // left: 20,
          //   child: Text("Welcome"),
          // ),
        ],
      ),
    );
  }
}
