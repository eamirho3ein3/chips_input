import 'package:chips_input/widgets/chips.dart';
import 'package:flutter/material.dart';

class ChipsInput extends StatefulWidget {
  const ChipsInput({Key? key, this.controller, this.focusNode, this.decoration})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ChipsInputDecoration? decoration;

  @override
  State<ChipsInput> createState() => _ChipsInputState();
}

class _ChipsInputState extends State<ChipsInput> {
  late TextEditingController chipController;
  late FocusNode _focus;

  List<String> chipsTitle = [];
  Color borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    chipController = widget.controller ?? TextEditingController();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if (_focus.hasFocus) {
        borderColor = Colors.blueAccent;
      } else {
        borderColor = Colors.grey;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var index = -1;
    return GestureDetector(
      onTap: () => _focus.requestFocus(),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: (chipsTitle + ['']).map((element) {
            index++;
            if (index == chipsTitle.length) {
              return IntrinsicWidth(
                child: TextField(
                  focusNode: _focus,
                  controller: chipController,
                  decoration: InputDecoration(
                    hintText: widget.decoration?.hintText,
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value.contains("-")) {
                      var newChipText = value.replaceFirst('-', '');
                      chipsTitle.add(newChipText);
                      chipController.clear();
                      setState(() {});
                    }
                  },
                ),
              );
            } else {
              return ChipsWidget(
                onDelete: (i) {
                  chipsTitle.removeAt(i);
                  setState(() {});
                },
                index: index,
                title: element,
                decoration: ChipsDecoration(chipsBacgroundColor: Colors.red),
              );
            }
          }).toList(),
        ),
      ),
    );
  }
}

class ChipsInputDecoration {
  final Color? chipsBacgroundColor;
  final Color? chipsForegroundColor;
  final TextStyle? hintStyle;
  final String? hintText;

  ChipsInputDecoration(
      {this.chipsBacgroundColor,
      this.chipsForegroundColor,
      this.hintStyle,
      this.hintText});
}
