import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextWidget {
  static TextSpan appTextSpan(String startText, String endText) {
    return TextSpan(
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color(0xff0d1724),
      ),
      children: [
        TextSpan(
          text: startText,
        ),
        TextSpan(
          text: endText,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  static TextSpan appSmallTextSpan(String startText, String endText) {
    return TextSpan(
      style: GoogleFonts.poppins(
        fontSize: 12,
        color: const Color(0xff0d1724),
      ),
      children: [
        TextSpan(
          text: startText,
        ),
        TextSpan(
          text: endText,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
