// import 'package:flutter/material.dart';
// import 'package:super_tic_tac_toe/structure/list.dart';
// import 'package:super_tic_tac_toe/ui/alert.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => TestState();
// }

// class TestState extends State<Test> {
//   void horizontal(var i) {
//     // ANGKA DARI 1 - 6
//     if (i + 1 <= 5 && i + 1 >= 1 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//     // ANGKA DARI 7 - 12
//     if (i + 1 <= 11 && i + 1 >= 7 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//     // ANGKA DARI 13 - 18
//     if (i + 1 <= 17 && i + 1 >= 13 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//     // ANGKA DARI 19 - 24
//     if (i + 1 <= 23 && i + 1 >= 19 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//     // ANGKA DARI 25 - 30
//     if (i + 1 <= 29 && i + 1 >= 25 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//     // ANGKA DARI 31 - 36
//     if (i + 1 <= 35 && i + 1 >= 31 && x.contains(i + 1) && x.contains(i + 2)) {
//       print("Kombinasi Mendatar Pada Angka ${i}, ${i + 1}, ${i + 2}");
//     }
//   }

//   void checkPoint() {
//     for (var i in x) {
//       // KOMBINASI MENDATAR
//       horizontal(i);

//       // KOMBINASI MENURUN
//       if (vertical.contains(i)) {
//         var i2 = x.contains(i + 6);
//         if (i2) {
//           var i3 = x.contains(i + 12);
//           if (i3) {
//             print("Ada kombinasi Menurun.");
//           }
//         }
//       }

//       // KOMBINASI DIAGONAL KANAN
//       if (rightDiagonal.contains(i)) {
//         var i2 = x.contains(i + 7);
//         if (i2) {
//           var i3 = x.contains(i + 14);
//           if (i3) {
//             print("Ada kombinasi diagonal kanan.");
//           }
//         }
//       }

//       // KOMBINASI DIAGONAL KIRI
//       if (leftDiagonal.contains(i)) {
//         var i2 = x.contains(i + 5);
//         if (i2) {
//           var i3 = x.contains(i + 10);
//           if (i3) {
//             print("Ada kombinasi diagonal kiri.");
//           }
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     checkPoint();
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               showGameAlert(context, "You Lose", "better luck next time jimmy");
//             },
//             child: Container(
//               width: 200,
//               height: 100,
//               color: Colors.purple[600],
//               child: Text("contoh"),
//             ),
//           ),
//           GestureDetector(
//             onTap: () async {},
//             child: Container(
//               width: 200,
//               height: 100,
//               color: Colors.purple[600],
//               child: Text("contoh"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
