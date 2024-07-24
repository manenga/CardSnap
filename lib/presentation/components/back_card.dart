import 'package:credit_card_capture/utils/shared_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/credit_card_entity.dart';
import '../../utils/constants.dart';

class BackCard extends StatelessWidget {
  final CreditCardEntity cardDetails;
  final VoidCallback onPressed;

  const BackCard({
    super.key,
    required this.cardDetails,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardDetails.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          image: SharedStyles.cardBackground,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.black,
                height: 45,
              ),
              // const Spacer(flex: 2),
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white10,
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(flex: 1),
                      Container(
                        color: Colors.white12,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'cvv',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: SharedStyles.getFontColorForBackground(
                                    cardDetails.cardColor
                                ),
                              ),
                            ),
                            Text(
                              cardDetails.cvvNumber,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: SharedStyles.getFontColorForBackground(
                                    cardDetails.cardColor),
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
                child: Text(
                  Strings.cardDisclaimer,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: SharedStyles.getFontColorForBackground(
                        cardDetails.cardColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
