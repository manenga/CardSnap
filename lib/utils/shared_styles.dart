import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedStyles {
  static Color getFontColorForBackground(Color background) {
    return (background.computeLuminance() > 0.179)
        ? Colors.black
        : Colors.white;
  }

  static LinearGradient cardTextGradient = const LinearGradient(colors: [
    Colors.deepPurple,
    Colors.black,
    Colors.purpleAccent,
    Colors.black,
    Colors.deepPurple,
  ]);

  static LinearGradient getGradientFor(Color cardColor) {
    return LinearGradient(
        tileMode: TileMode.mirror,
        begin: Alignment.topLeft,
        end: const Alignment(0.8, 1),
        colors: [
          cardColor,
          cardColor.withAlpha(225),
          cardColor.withAlpha(180),
          cardColor.withAlpha(150),
          cardColor.withAlpha(56),
          cardColor.withAlpha(225),
          cardColor,
        ]);
  }

  static DecorationImage cardBackground = const DecorationImage(
    image: AssetImage("assets/images/financial-silhouettes.jpg"),
    fit: BoxFit.contain,
    repeat: ImageRepeat.repeat,
    opacity: 0.15,
  );

  static InputDecoration formFieldStyle({
    String labelText = "",
    String hintText = "",
    String helperText = "",
    String errorText = "",
    IconData icon = Icons.credit_card,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText.isNotEmpty ? helperText : null,
      errorText: errorText.isNotEmpty ? errorText : null,
      errorMaxLines: 1,
      filled: true,
      fillColor: Colors.grey.withAlpha(25),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.deepPurple,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
      suffixIcon: suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: suffixIcon,
            )
          : null,
    );
  }

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.oswald(
      fontSize: 24,
    ),
    titleMedium: GoogleFonts.oswald(
      fontSize: 18,
    ),
    titleSmall: GoogleFonts.oswald(
      fontSize: 12,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 22,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 18,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 14,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 22,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 18,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 14,
    ),
  );
}
