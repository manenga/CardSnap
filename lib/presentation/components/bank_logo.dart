import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/shared_styles.dart';
import 'gradient_text.dart';

class BankLogo extends StatelessWidget {
  final Color color;

  const BankLogo({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GradientText(
          'TANGO',
          style: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          gradient: SharedStyles.cardTextGradient,
        ),
        Text(
          'Bank',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
              ),
        ),
      ],
    );
  }
}
