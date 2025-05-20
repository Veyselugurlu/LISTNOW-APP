import 'package:flutter/material.dart';

class DividerCloseButton extends StatelessWidget {
  const DividerCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: _height * 0.05,
      child: Stack(
        children: [
          Divider(
            color: Colors.black,
            thickness: 3,
            indent: _width * 0.4,
            endIndent: _width * 0.4,
          ),
          Positioned(
            top: 5,
            right: 10,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
