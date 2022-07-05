import 'package:custom_simple_github_app/commons/verify.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/input_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAnimationWidget extends StatefulWidget {
  const TextAnimationWidget({Key? key}) : super(key: key);

  @override
  _TextAnimationWidgetState createState() => _TextAnimationWidgetState();
}

class _TextAnimationWidgetState extends State<TextAnimationWidget>
    with TickerProviderStateMixin {
  /// 文字、光标显示内容
  final String t1 = 'Welcome to GitHub!';
  final String _text = 'Welcome to GitHub!'
      "\nLet’s begin the adventure";

  /// 动画
  late final AnimationController textAnimationController;
  late final Animation<String> textAnimation;
  late final Animation<int> cursorStartAnimation;

  /// 区域宽度
  final double _width = 380.0;

  /// 区域高度: 动态
  double _height = 70.0;

  /// 光标距离左边的位置
  double cursorLeft = 0.0;

  /// 光标距离上部的位置
  double cursorTop = 0.0;

  /// 是否显示随文字出现的光标
  bool cursorVisible = true;

  /// 是否显示文字之前的光标
  bool cursorStartVisible = true;

  InputConfig emailConfig = InputConfig(visible: false);
  InputConfig passwordConfig = InputConfig(visible: false);
  InputConfig usernameConfig = InputConfig(visible: false);
  InputConfig subscribeConfig = InputConfig(visible: false);

  String errorMsg = '';

  bool verifySwitchVisible = true;
  bool verifySelectVisible = false;

  @override
  void initState() {
    super.initState();
    textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );

    // 监听光标动画
    cursorStartAnimation = IntTween(begin: 1, end: 8).animate(
      CurvedAnimation(
        parent: textAnimationController,
        curve: const Interval(0.0, 0.299, curve: Curves.linear),
      ),
    );
    cursorStartAnimation.addListener(() {
      setState(() {
        int d = cursorStartAnimation.value;
        cursorStartVisible = d % 2 != 0;
        if (d == 10) {
          cursorStartVisible = false;
        }
      });
    });

    // 监听文字动画的执行
    textAnimation = TextTween(content: _text).animate(
      CurvedAnimation(
        parent: textAnimationController,
        curve: const Interval(0.3, 1.0, curve: Curves.linear),
      ),
    );
    textAnimation.addListener(() {
      setState(() {
        int textLength = textAnimation.value.length;
        if (textAnimation.value.length > t1.length) {
          textLength -= t1.length + 2;
          cursorTop = 23.0;
        }
        if (textAnimation.value.length >= t1.length) {
          // _height = 120.0;
          _height = 620.0;
        }

        cursorLeft = textLength * 10;
      });
    });
    // 监听动画的状态
    textAnimation.addStatusListener((status) {
      // 如果执行完成，则显示email
      if (status == AnimationStatus.completed) {
        _height += 60.0;
        emailConfig.visible = true;
        cursorVisible = false;
      }
    });

    textAnimationController.forward();
  }

  @override
  void dispose() {
    textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _width,
          height: _height,
          margin: const EdgeInsets.only(
              top: 50.0, left: 50.0, right: 50.0, bottom: 10.0),
          padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            border: Border.all(width: .4, color: Colors.white60),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: textAnimation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: cursorStartVisible,
                        child: Container(
                          margin: const EdgeInsets.only(top: 6.0),
                          child: Container(
                            width: .7,
                            height: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: cursorVisible,
                        child: Positioned(
                          left: cursorLeft,
                          top: cursorTop,
                          child: Container(
                            margin: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              width: .7,
                              height: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        textAnimation.value,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w100,
                          height: 1.5,
                          wordSpacing: 1.2,
                          letterSpacing: 1.8,
                          // fontFamily: 'LiberationMono',
                        ),
                      ),
                    ],
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


              err: Email is invalid or already taken




              */
              customInputWidget(
                  visible: emailConfig.visible,
                  label: 'Enter your email',
                  obscure: emailConfig.obscure,
                  prefix: emailConfig.prefix,
                  suffixColor: emailConfig.suffixColor,
                  onPressed: emailConfig.buttonOnTapCall,
                  inputController: emailConfig.inputController,
                  buttonVisible: emailConfig.buttonVisible,
                  onChanged: (value) {
                    if (value.isNotEmpty && Verify.isEmail(value)) {
                      setState(() {
                        emailConfig.suffixColor =
                            InputConfig.successSuffixColor;
                        emailConfig.buttonOnTapCall = () => setState(() {
                              _height += 80.0;
                              emailConfig.prefix = InputConfig.successPrefix;
                              emailConfig.buttonVisible = false;
                              passwordConfig.visible = true;
                            });
                        errorMsg = '';
                      });
                      debugPrint(value);
                    } else {
                      setState(() {
                        emailConfig.prefix = InputConfig.defaultPrefix;
                        emailConfig.suffixColor =
                            InputConfig.defaultSuffixColor;
                        emailConfig.buttonOnTapCall = null;
                        emailConfig.buttonVisible = true;
                      });
                      errorMsg = 'Email is invalid or already taken';
                    }
                  }),
              /*
              https://github.com/password_validity_checks

              Password is too short
              Password needs a number and lowercase letter 

               Password is strong

              Make sure it's at least 15 characters OR at least 8 characters including a number and a lowercase letter.

               */
              customInputWidget(
                  visible: passwordConfig.visible,
                  label: 'Create a password',
                  obscure: passwordConfig.obscure,
                  onPressed: passwordConfig.buttonOnTapCall,
                  prefix: passwordConfig.prefix,
                  suffixColor: passwordConfig.suffixColor,
                  inputController: passwordConfig.inputController,
                  buttonVisible: passwordConfig.buttonVisible,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 10) {
                      setState(() {
                        passwordConfig.prefix = InputConfig.successPrefix;
                        passwordConfig.suffixColor =
                            InputConfig.successSuffixColor;
                        passwordConfig.buttonOnTapCall = () => setState(() {
                              _height += 80.0;
                              passwordConfig.buttonVisible = false;
                              usernameConfig.visible = true;
                            });
                        errorMsg = '';
                      });
                      debugPrint(value);
                    } else {
                      setState(() {
                        passwordConfig.prefix = InputConfig.defaultPrefix;
                        passwordConfig.suffixColor =
                            InputConfig.defaultSuffixColor;
                        passwordConfig.buttonOnTapCall = null;
                        passwordConfig.buttonVisible = true;
                      });
                      errorMsg =
                          "Make sure it's at least 15 characters OR at least 8 "
                          "characters including a number and a lowercase letter.";
                    }
                  }),
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
                  visible: usernameConfig.visible,
                  label: 'Enter a username',
                  obscure: usernameConfig.obscure,
                  onPressed: usernameConfig.buttonOnTapCall,
                  prefix: usernameConfig.prefix,
                  suffixColor: usernameConfig.suffixColor,
                  buttonVisible: usernameConfig.buttonVisible,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 10) {
                      setState(() {
                        usernameConfig.prefix = InputConfig.successPrefix;
                        usernameConfig.suffixColor =
                            InputConfig.successSuffixColor;
                        usernameConfig.buttonOnTapCall = () => setState(() {
                              _height += 130.0;
                              usernameConfig.buttonVisible = false;
                              subscribeConfig.visible = true;
                            });
                        errorMsg = '';
                      });
                      debugPrint(value);
                    } else {
                      setState(() {
                        usernameConfig.prefix = InputConfig.defaultPrefix;
                        usernameConfig.suffixColor =
                            InputConfig.defaultSuffixColor;
                        usernameConfig.buttonOnTapCall = null;
                      });
                      errorMsg =
                          "Make sure it's at least 15 characters OR at least 8 "
                          "characters including a number and a lowercase letter.";
                    }
                  }),
              customInputWidget(
                visible: subscribeConfig.visible,
                label:
                    'Would you like to receive product updates and\nannouncements via email?\nType "y" for yes or "n" for no',
                obscure: subscribeConfig.obscure,
                prefix: subscribeConfig.prefix,
                suffixColor: subscribeConfig.suffixColor,
              ),
              // 回答问题，以证明是真人
              Visibility(
                visible: true,
                child: Container(
                  width: _width - 30.0,
                  height: 400.0,
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        ' Verify your account',
                        style: TextStyle(
                          color: Color.fromRGBO(59, 255, 248, 1.0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Visibility(
                        visible: verifySwitchVisible,
                        child: Container(
                          width: _width - 30.0,
                          height: 380.0,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white54, width: .6),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                '验证',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0,
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
                                width: double.infinity,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white38, width: .6),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: OutlinedButton(
                                  child: const Text('验证',
                                      style: TextStyle(color: Colors.white60)),
                                  onPressed: () {
                                    setState(() {
                                      verifySwitchVisible = false;
                                      verifySelectVisible = true;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: verifySelectVisible,
                        child: Column(
                          children: [
                            const Text(
                              '选出旋涡星系',
                              style: TextStyle(
                                color: Color.fromRGBO(59, 255, 248, 1.0),
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Column(
                              children: [
                                Image.asset('assets/images/verify/01_1.jpg'),
                                Image.asset('assets/images/verify/01_2.jpg'),
                                Image.asset('assets/images/verify/01_3.jpg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          errorMsg,
          style: const TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.w100,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          tooltip: '重复一次',
          onPressed: () {
            textAnimationController.forward(from: 0);
            _height = 70.0;
            emailConfig.visible = false;
            passwordConfig.visible = false;
            usernameConfig.visible = false;
            subscribeConfig.visible = false;
            cursorLeft = 0.0;
            cursorTop = 0.0;
            cursorVisible = true;
            cursorStartVisible = true;
          },
        ),
      ],
    );
  }

  Visibility customInputWidget({
    bool visible = false,
    String label = '',
    bool obscure = false,
    bool buttonVisible = true,
    required Color suffixColor,
    required Text prefix,
    void Function()? onPressed,
    TextEditingController? inputController,
    void Function(String)? onChanged,
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
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              prefix,
              Container(
                width: 180.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: SizedBox(
                  height: 27.0,
                  child: TextFormField(
                    autofocus: true,
                    maxLines: 1,
                    minLines: 1,
                    decoration: const InputDecoration(
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
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: .3,
                          color: Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(23),
                    ],
                    obscureText: obscure,
                    cursorColor: Colors.white,
                    cursorWidth: .6,
                    controller: inputController,
                    onChanged: onChanged,
                  ),
                ),
              ),
              Visibility(
                visible: buttonVisible,
                child: OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: .6,
                      // 验证前或验证失败是白色,成功是绿色
                      // color: Colors.green,
                      color: suffixColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: Text(
                    'Continue',
                    // 验证前或验证失败是白色,成功是绿色
                    // style: TextStyle(color: Colors.green),
                    style: TextStyle(color: suffixColor),
                  ),
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
