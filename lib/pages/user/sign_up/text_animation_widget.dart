import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAnimationWidget extends StatefulWidget {
  const TextAnimationWidget({Key? key}) : super(key: key);

  @override
  _TextAnimationWidgetState createState() => _TextAnimationWidgetState();
}

class _TextAnimationWidgetState extends State<TextAnimationWidget>
    with SingleTickerProviderStateMixin {
  final String _text = 'Welcome to GitHub!'
      "\nLet’s begin the adventure";

  late final AnimationController _controller;

  late final Animation<String> _animation;
  double _width = 380.0;
  double _height = 80.0;
  bool emailVisible = true;
  bool passwordVisible = false;
  bool usernameVisible = false;
  bool subscribeVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _animation = TextTween(content: _text).animate(_controller)
      ..addListener(() {
        setState(() {
          _height += 1;
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _width,
          height: _height,
          margin: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            border: Border.all(width: .4, color: Colors.white60),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    _animation.value,
                    style: const TextStyle(color: Colors.white70),
                  );
                },
              ),
              /*
              https://github.com/email_validity_checks
              -----------------------------247095972823891933632782303025
              Content-Disposition: form-data; name="authenticity_token"

              qqcTnXEDlmPlm7uC166PxDbaE+tAqKCmcJjWpGGcT69nJSOhkWSu+YOL4ZKEvqYADo3eT5TDtDzt2oKtAkCNAg==
              -----------------------------247095972823891933632782303025
              Content-Disposition: form-data; name="value"

              dsfdsfsdfsdffdsfsd@cc.cc
              -----------------------------247095972823891933632782303025--


              <p class="mb-0">Email is invalid or already taken</p>




              */
              customInputWidget(
                visible: emailVisible,
                label: 'Enter your email',
                prefix: '→',
                prefixStyle: const TextStyle(
                  color: Color.fromRGBO(235, 83, 174, 1.0),
                  fontSize: 15.0,
                ),
                obscure: false,
                onPressed: () => setState(() {
                  _height += 50.0;
                  passwordVisible = true;
                }),
              ),
              /*
              https://github.com/password_validity_checks

               Password is strong

              Make sure it's at least 15 characters OR at least 8 characters including a number and a lowercase letter.

               */
              customInputWidget(
                visible: passwordVisible,
                label: 'Create a password',
                prefix: '→',
                prefixStyle: const TextStyle(
                  color: Color.fromRGBO(235, 83, 174, 1.0),
                  fontSize: 15.0,
                ),
                obscure: true,
                onPressed: () => setState(() {
                  _height += 50.0;
                  usernameVisible = true;
                }),
              ),
              /*
              https://github.com/signup_check/username

              <div class="m-1">
                <div class="mb-1">
                  Username sdfdsf is not available.
                </div>
              </div>

              sdfdsf1 is available.

              */
              customInputWidget(
                visible: usernameVisible,
                label: 'Enter a username',
                prefix: '→',
                prefixStyle: const TextStyle(
                  color: Color.fromRGBO(235, 83, 174, 1.0),
                  fontSize: 15.0,
                ),
                obscure: false,
                onPressed: () => setState(() {
                  _height += 120.0;
                  subscribeVisible = true;
                }),
              ),
              customInputWidget(
                visible: subscribeVisible,
                label:
                    'Would you like to receive product updates and\nannouncements via email?\nType "y" for yes or "n" for no',
                prefix: '→',
                prefixStyle: const TextStyle(
                  color: Color.fromRGBO(235, 83, 174, 1.0),
                  fontSize: 15.0,
                ),
                obscure: false,
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          tooltip: '重复一次',
          onPressed: () {
            _controller.forward(from: 0);
            _height = 80.0;
          },
        ),
      ],
    );
  }

  Visibility customInputWidget({
    bool visible = false,
    String label = '',
    String prefix = '',
    TextStyle prefixStyle = const TextStyle(color: Colors.white),
    bool obscure = false,
    void Function()? onPressed,
  }) {
    return Visibility(
      visible: visible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromRGBO(59, 255, 248, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                prefix,
                style: prefixStyle,
              ),
              Container(
                width: 130.0,
                margin: const EdgeInsets.only(left: 12.0),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  minLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  obscureText: obscure,
                ),
              ),
              OutlinedButton(
                onPressed: onPressed,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: .6,
                    // 验证前或验证失败是白色,成功是绿色
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(10.0),
                ),
                child: const Text(
                  'Continue',
                  // 验证前或验证失败是白色,成功是绿色
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextTween extends Tween<String> {
  TextTween({required this.content}) : super(begin: '', end: content);

  final String content;

  @override
  String lerp(double t) {
    // 在动画过程中t的值是从0到1
    var cutoff = (content.length * t).round();
    return content.substring(0, cutoff);
  }
}
