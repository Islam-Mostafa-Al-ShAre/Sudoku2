import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sudoku/controllers/home_controller.dart';
import 'package:sudoku/views/widgets/custom_botton.dart';
import 'package:sudoku/views/widgets/vertical_horizontal_spance.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  // ignore: unused_field
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const VerticalSpace(120),
            const Icon(
              FontAwesomeIcons.brain,
              size: 150,
              color: primaryColor,
            ),
            const VerticalSpace(150),
            const Text(
              "Select Game Diffculity",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            const VerticalSpace(50),
            CustomBotton(
              text: "Easy",
              padding: 80,
            ),
            const VerticalSpace(10),
            CustomBotton(
              text: "Normal",
              padding: 70,
            ),
            const VerticalSpace(10),
            CustomBotton(
              text: "Hard",
              padding: 80,
            ),
          ],
        ),
      ),
    );
  }
}
