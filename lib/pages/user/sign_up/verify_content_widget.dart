import 'package:custom_simple_github_app/pages/user/sign_up/verify_image_widget.dart';
import 'package:flutter/material.dart';

class VerifyContentWidget extends StatefulWidget {
  const VerifyContentWidget({Key? key}) : super(key: key);

  @override
  _VerifyContentWidgetState createState() => _VerifyContentWidgetState();
}

class _VerifyContentWidgetState extends State<VerifyContentWidget> {
  bool verifySwitchVisible = true;
  bool verifySelectVisible = false;

  final List<String> verifyFirstName = ['01', '02'];
  final List<int> verifySecondName = [1, 2, 3, 4, 5, 6];
  bool clickRefash = false;
  bool clickVerify = false;

  @override
  void initState() {
    super.initState();
    verifySecondName.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              ' Verify your account',
              style: TextStyle(
                color: Color.fromRGBO(59, 255, 248, 1.0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          width: 300.0,
          height: 320.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: .6),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              Visibility(
                visible: verifySwitchVisible,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '验证',
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const Text(
                      '请回答此问题\n以证明您是真人',
                      style: TextStyle(
                        color: Color.fromRGBO(59, 255, 248, 1.0),
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Container(
                      width: 280.0,
                      height: 35.0,
                      margin: const EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              clickVerify ? Colors.lightGreen : Colors.white38,
                          width: .6,
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: MouseRegion(
                        child: OutlinedButton(
                          child: Text('验证',
                              style: TextStyle(
                                color: clickVerify
                                    ? Colors.lightGreen
                                    : Colors.white60,
                              )),
                          onPressed: () {
                            setState(() {
                              verifySwitchVisible = false;
                              verifySelectVisible = true;
                            });
                          },
                        ),
                        onHover: (_) {
                          setState(() {
                            clickVerify = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            clickVerify = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: verifySelectVisible,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '选出旋涡星系',
                        style: TextStyle(
                          color: Color.fromRGBO(59, 255, 248, 1.0),
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 205.0,
                      child: Padding(
                        padding: const EdgeInsets.all(6.5),
                        child: Column(
                          children: [
                            for (int col = 0; col <= 1; col++)
                              Row(
                                children: [
                                  for (int n in verifySecondName.sublist(
                                      0 + (col * 3), 3 + (col * 3)))
                                    VerifyImageWidget(
                                      imageFirstName: verifyFirstName.first,
                                      imageSecondName: '$n',
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      width: 280,
                      height: 35.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              clickRefash ? Colors.lightGreen : Colors.white60,
                          width: .5,
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: MouseRegion(
                        onHover: (value) {
                          setState(() {
                            clickRefash = true;
                          });
                        },
                        onExit: (value) {
                          setState(() {
                            clickRefash = false;
                          });
                        },
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              verifyFirstName.shuffle();
                              verifySecondName.shuffle();
                            });
                          },
                          child: Icon(
                            Icons.loop,
                            color: clickRefash
                                ? Colors.lightGreen
                                : Colors.white60,
                            size: 19.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
