import 'package:flutter/material.dart';

abstract class AppColors{
  static MaterialColor primaryColor = MaterialColor(0xFF003366, {
    50: const Color(0xFF003366).withOpacity(0.1),
    100: const Color(0xFF003366).withOpacity(0.2),
    200: const Color(0xFF003366).withOpacity(0.3),
    300: const Color(0xFF003366).withOpacity(0.4),
    400: const Color(0xFF003366).withOpacity(0.5),
    500: const Color(0xFF003366).withOpacity(0.6),
    600: const Color(0xFF003366).withOpacity(0.7),
    700: const Color(0xFF003366).withOpacity(0.8),
    800: const Color(0xFF003366).withOpacity(0.9),
    900: const Color(0xFF003366).withOpacity(1.0),
  });

  static const greyLogo = Color(0xFFb0b6c0);
  static const divider = Color(0xFFBCBCBC);
}