import 'package:flutter/material.dart';

class ShowcaseMenu extends StatefulWidget {
  const ShowcaseMenu({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  State<ShowcaseMenu> createState() => _ShowcaseMenuState();
}

class _ShowcaseMenuState extends State<ShowcaseMenu> {
  bool _showList = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _showList = !_showList;
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        if (_showList) ...[const SizedBox(height: 10), widget.child]
      ],
    );
  }
}
