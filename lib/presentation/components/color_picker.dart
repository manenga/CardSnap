import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker(
      {super.key, required this.onSelectedColorChanged, this.selectedColor});

  final Color? selectedColor;
  final ValueChanged<Color> onSelectedColorChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentColor = Colors.amber;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _currentColor = (widget.selectedColor != null)
        ? widget.selectedColor!
        : (cardColors.toList()..shuffle()).first;
    super.initState();
  }

  void changeColor(Color color) => setState(() => _currentColor = color);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: cardColors.length,
          itemBuilder: (context, idx) {
            return GestureDetector(
              onTap: () {
                changeColor(cardColors[idx]);
                widget.onSelectedColorChanged(cardColors[idx]);
              },
              child: Container(
                width: colorPickerHeight,
                height: colorPickerHeight,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cardColors[idx],
                  border: Border.all(
                    width: cardColors[idx] == _currentColor ? 2 : 3,
                    color: cardColors[idx] == _currentColor
                        ? Colors.white70
                        : Colors.white,
                  ),
                ),
                child: cardColors[idx] == _currentColor
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
            );
          }),
    );
  }
}
