import 'dart:math';

import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  final PaginationWidgetTheme paginationWidgetTheme;
  final ValueChanged<int> onChanged;
  final int max;

  const PaginationWidget(
      {super.key,
        required this.paginationWidgetTheme,
        required this.max,
        required this.onChanged});

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int select = 1;
  int start = 1, last = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      double total = size.maxWidth - (168);
      return Container(
        width: size.maxWidth,
        height: 50,
        color: widget.paginationWidgetTheme.background,
        alignment: Alignment.center,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  select = 1;
                  start = 1;
                });
                widget.onChanged(select);
              },
              child: PaginationWidgetButton(
                selected: false,
                paginationWidgetTheme: widget.paginationWidgetTheme,
                child: Icon(
                  Icons.keyboard_double_arrow_left,
                  color: widget.paginationWidgetTheme.iconColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (select == 1) {
                  return;
                }

                select--;
                if (select < start) {
                  start--;
                }
                setState(() {});
                widget.onChanged(select);
              },
              child: PaginationWidgetButton(
                  selected: false,
                  paginationWidgetTheme: widget.paginationWidgetTheme,
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: widget.paginationWidgetTheme.iconColor,
                  )),
            ),
            const SizedBox(
              width: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: total,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: min(widget.max, (total) ~/ 33),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        last = start + index;
                        if ((start + index) == widget.max) {
                          return const SizedBox(
                            width: 0,
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              select = start + index;
                            });
                            widget.onChanged(select);
                          },
                          child: PaginationWidgetButton(
                              paginationWidgetTheme:
                              widget.paginationWidgetTheme,
                              selected: select == (start + index),
                              child: Text(
                                (start + index).toString(),
                                style: TextStyle(
                                    color: select == (start + index)
                                        ? widget.paginationWidgetTheme
                                        .selectedTextColor
                                        : widget
                                        .paginationWidgetTheme.textColor),
                              )),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      select = widget.max;
                      int rend = (total) ~/ 33;
                      if (last < select - 1) {
                        start = (select) - rend;
                      }
                    });
                    widget.onChanged(select);
                  },
                  child: PaginationWidgetButton(
                      selected: select == widget.max,
                      paginationWidgetTheme: widget.paginationWidgetTheme,
                      child: Text(
                        (widget.max).toString(),
                        style: TextStyle(
                            color: (select == widget.max)
                                ? (widget
                                .paginationWidgetTheme.selectedTextColor)
                                : widget.paginationWidgetTheme.textColor),
                      )),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                if (select == widget.max) {
                  return;
                }
                if (select == widget.max - 1) {
                  select = widget.max;
                  setState(() {});
                  return;
                }
                select++;
                if (select == last) {
                  start++;
                }
                setState(() {});
                widget.onChanged(select);
              },
              child: PaginationWidgetButton(
                  selected: false,
                  paginationWidgetTheme: widget.paginationWidgetTheme,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: widget.paginationWidgetTheme.iconColor,
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  select = widget.max;
                  if (last < select - 1) {
                    int rend = (total) ~/ 33;
                    start = (select) - rend;
                  }
                });
                widget.onChanged(select);
              },
              child: PaginationWidgetButton(
                  selected: false,
                  paginationWidgetTheme: widget.paginationWidgetTheme,
                  child: Icon(
                    Icons.keyboard_double_arrow_right,
                    color: widget.paginationWidgetTheme.iconColor,
                  )),
            ),
          ],
        ),
      );
    });
  }
}

class PaginationWidgetTheme {
  Color? background,
      iconColor,
      borderColor,
      textColor,
      selectedColor = Colors.green,
      selectedTextColor;

  PaginationWidgetTheme({
    this.background = Colors.white,
    this.iconColor = Colors.black,
    this.borderColor = Colors.grey,
    this.textColor = Colors.black,
    this.selectedColor = Colors.green,
    this.selectedTextColor = Colors.white,
  });
}

class PaginationWidgetButton extends StatefulWidget {
  final PaginationWidgetTheme? paginationWidgetTheme;
  final Widget child;
  final bool selected;

  const PaginationWidgetButton(
      {Key? key,
        this.paginationWidgetTheme,
        required this.selected,
        required this.child})
      : super(key: key);

  @override
  State<PaginationWidgetButton> createState() => _PaginationWidgetButtonState();
}

class _PaginationWidgetButtonState extends State<PaginationWidgetButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: widget.selected
                  ? (widget.paginationWidgetTheme?.selectedColor ??
                  Theme.of(context).primaryColor)
                  : null,
              border: widget.selected
                  ? null
                  : Border.all(
                  color: widget.paginationWidgetTheme?.borderColor ??
                      Theme.of(context).dividerColor,
                  width: 2)),
          alignment: Alignment.center,
          child: widget.child,
        ),
        const SizedBox(
          width: 3,
        )
      ],
    );
  }
}
