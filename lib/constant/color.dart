import 'package:flutter/material.dart';

// const blackColor = Color.fromARGB(255, 20, 20, 20);
const purpleColor = Color.fromARGB(255, 153, 141, 217);
const whiteColor = Color.fromARGB(255, 240, 240, 240);
const mainBackgroundColor = Color.fromARGB(255, 0, 5, 30);
const orangeColor = Color.fromARGB(255, 255, 92, 36);
const orangeColor2 = Color.fromARGB(255, 248, 153, 27);
// const subColor = Color.fromARGB(255, 0, 17, 45);
// const greenColor = Color.fromARGB(255, 6, 199, 85);
// const pinkColor = Color.fromARGB(255, 236, 91, 202);
// const mainGreenColor = Color.fromARGB(255, 127, 239, 191);
// const mainRedColor = Color.fromARGB(255, 253, 143, 118);
// const mainBlueColor = Color.fromARGB(255, 78, 153, 254);
// const mainYellowColor = Color.fromARGB(255, 255, 227, 130);

Gradient mainGradation({double opacity = 1}) {
  return LinearGradient(
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
    colors: [
      orangeColor.withOpacity(opacity),
      orangeColor2.withOpacity(opacity),
    ],
  );
}
