import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/shared_styles.dart';
import 'bank_logo.dart';
import 'gradient_text.dart';

class FrontCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final Widget? cardIcon;
  final String expiryDate;
  final Color cardColor;
  final String countryCode;
  final VoidCallback onPressed;

  const FrontCard({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardColor,
    required this.countryCode,
    required this.onPressed,
    this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: SharedStyles.getGradientFor(cardColor),
          image: SharedStyles.cardBackground,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.white60.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 20.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 36,
                          child: Text(
                            countryCode,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: SharedStyles.getFontColorForBackground(
                                      cardColor),
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/chip.png',
                            width: 36.0,
                            fit: BoxFit.fitWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Credit',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color:
                                        SharedStyles.getFontColorForBackground(
                                            cardColor),
                                  ),
                            ),
                          ),
                          const Spacer(),
                          cardIcon ??
                              Image.asset(
                                'assets/images/visa.png',
                                width: 0,
                                fit: BoxFit.cover,
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 8.0, 20.0, 0.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cardNumber,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Colors.black87,
                                )),
                        Image.asset('assets/images/contactless.png',
                            width: 35.0,
                            fit: BoxFit.fitWidth,
                            color: SharedStyles.getFontColorForBackground(
                                cardColor)),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 12.0, 20.0, 16.0),
                  child: Container(
                    padding: const EdgeInsets.only(right: 13.0),
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      cardHolder,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: SharedStyles.getFontColorForBackground(
                                cardColor),
                          ),
                      gradient: SharedStyles.cardTextGradient,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0, 0, 0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'valid thru',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                              ).copyWith(
                                color: SharedStyles.getFontColorForBackground(
                                    cardColor),
                              ),
                            ),
                            Text(
                              expiryDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        SharedStyles.getFontColorForBackground(
                                            cardColor),
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        BankLogo(
                            color: SharedStyles.getFontColorForBackground(
                                cardColor))
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
