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
  double _height = 70.0;
  bool emailVisible = false;
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

    // 监听动画的执行
    _animation = TextTween(content: _text).animate(_controller)
      ..addListener(() {
        setState(() {
          _height += 1;
        });
      });

    // 监听动画的状态
    _animation.addStatusListener((status) {
      // 如果执行完成，则显示email
      if (status == AnimationStatus.completed) {
        _height += 60.0;
        emailVisible = true;
      }
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
          margin: const EdgeInsets.all(50.0),
          padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey[850],
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
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w100,
                      height: 1.5,
                      wordSpacing: 1.2,
                      letterSpacing: 1.8,
                      // fontFamily: 'LiberationMono',
                    ),
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
                  _height += 80.0;
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
                  _height += 80.0;
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
                  _height += 130.0;
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
            _height = 70.0;
            emailVisible = false;
            passwordVisible = false;
            usernameVisible = false;
            subscribeVisible = false;
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
          const SizedBox(
            height: 15.0,
          ),
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
                width: 180.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: SizedBox(
                  height: 27.0,
                  child: TextField(
                    autofocus: true,
                    maxLines: 1,
                    minLines: 1,
                    decoration: const InputDecoration(
                      // border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 1.0,
                        vertical: 12.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: .3,
                          color: Colors.white,
                        ),
                      ),
                      // enabledBorder: InputBorder.none,
                      // enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: .3,
                          color: Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    obscureText: obscure,
                    cursorColor: Colors.white,
                    cursorWidth: .6,
                  ),
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
