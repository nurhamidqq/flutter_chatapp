import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/misc/constants.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const CircleAvatar(
                maxRadius: 14,
                child: Icon(
                  Icons.person_rounded,
                  color: primary,
                ),
              ),
            ),
            horizontalSpace(20),
          ],
        ),
        Text(
          'KONEK',
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.griffy().fontFamily,
            letterSpacing: 10,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          children: [
            const Icon(
              Icons.light_mode,
              color: Colors.white,
            ),
            horizontalSpace(20),
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}
