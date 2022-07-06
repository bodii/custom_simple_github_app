import 'package:custom_simple_github_app/commons/dashed_rect.dart';
import 'package:flutter/material.dart';

class VerifyImageWidget extends StatefulWidget {
  const VerifyImageWidget({
    Key? key,
    required this.imageFirstName,
    required this.imageSecondName,
  }) : super(key: key);

  final String imageFirstName;
  final String imageSecondName;

  @override
  _VerifyImageWidgetState createState() => _VerifyImageWidgetState();
}

class _VerifyImageWidgetState extends State<VerifyImageWidget> {
  bool verifyImageBorderDashed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white70,
          width: 2.0,
        ),
      ),
      child: DashedRect(
        enabled: verifyImageBorderDashed,
        color: Colors.grey,
        width: 3.0,
        space: 3.0,
        child: MouseRegion(
          onHover: (event) {
            setState(() {
              verifyImageBorderDashed = true;
            });
          },
          onExit: (event) {
            setState(() {
              verifyImageBorderDashed = false;
            });
          },
          cursor: SystemMouseCursors.click,
          child: InkWell(
            child: Image.asset(
              'assets/images/verify/${widget.imageFirstName}_${widget.imageSecondName}.jpg',
              width: 90.0,
            ),
            onTap: () {
              setState(() {
                debugPrint(
                    '${widget.imageFirstName}_${widget.imageSecondName}');
              });
            },
          ),
        ),
      ),
    );
  }
}
