import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entities/credit_card_entity.dart';
import 'back_card.dart';
import 'front_card.dart';

class FlippableCard extends StatefulWidget {
  final CreditCardEntity cardDetails;

  const FlippableCard({
    super.key,
    required this.cardDetails,
  });

  @override
  State<FlippableCard> createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> {
  bool _isFront = true;
  late final Widget? frontCard = FrontCard(
      key: const Key('front'),
      cardNumber: widget.cardDetails.getPrettyCardNumber(),
      cardHolder: widget.cardDetails.getCardHolder(),
      expiryDate: widget.cardDetails.getCardExpiryDate(),
      cardIcon: widget.cardDetails.getCardIcon(),
      cardColor: widget.cardDetails.getCardColor(),
      countryCode: widget.cardDetails.getCountryCode(),
      onPressed: () {
        _onFlipCardPressed();
      });
  late final Widget? backCard = BackCard(
      key: const Key('back'),
      cardDetails: widget.cardDetails,
      onPressed: () {
        _onFlipCardPressed();
      });

  void _onFlipCardPressed() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: _isFront
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFrontOfCard = ValueKey(_isFront) == widget!.key;
        final rotationY = isFrontOfCard
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
