import 'package:custom_simple_github_app/commons/verify.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/custom_input_widget.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/input_config.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/verify_content_widget.dart';
import 'package:flutter/material.dart';

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

  InputConfig emailConfig = InputConfig();
  InputConfig passwordConfig = InputConfig(obscure: true);
  InputConfig usernameConfig = InputConfig();
  InputConfig subscribeConfig = InputConfig();
  bool verifyStarWidgetVisible = false;

  String errorMsg = '';

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
          _height = 120.0;
          // _height = 520.0;
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: 382.0,
            height: _height,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(
                top: 50.0, left: 30.0, right: 30.0, bottom: 10.0),
            padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
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
                CustomInputWidget(
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
                  },
                ),
                /*
                https://github.com/password_validity_checks
    
                Password is too short
                Password needs a number and lowercase letter 
    
                 Password is strong
    
                Make sure it's at least 15 characters OR at least 8 characters including a number and a lowercase letter.
    
                 */
                CustomInputWidget(
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
                  },
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
                CustomInputWidget(
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
                        usernameConfig.buttonVisible = true;
                      });
                      errorMsg =
                          "Make sure it's at least 15 characters OR at least 8 "
                          "characters including a number and a lowercase letter.";
                    }
                  },
                ),
                CustomInputWidget(
                  visible: subscribeConfig.visible,
                  label:
                      'Would you like to receive product updates and\nannouncements via email?\nType "y" for yes or "n" for no',
                  obscure: subscribeConfig.obscure,
                  prefix: subscribeConfig.prefix,
                  suffixColor: subscribeConfig.suffixColor,
                  buttonVisible: subscribeConfig.buttonVisible,
                  onPressed: subscribeConfig.buttonOnTapCall,
                  onChanged: (value) {
                    if (value.isNotEmpty && ['y', 'n'].contains(value)) {
                      setState(() {
                        subscribeConfig.prefix = InputConfig.successPrefix;
                        subscribeConfig.suffixColor =
                            InputConfig.successSuffixColor;
                        subscribeConfig.buttonVisible = true;

                        // verifyStarWidgetVisible = true;
                        subscribeConfig.buttonOnTapCall = () => setState(() {
                              _height += 340.0;
                              subscribeConfig.buttonVisible = false;
                              verifyStarWidgetVisible = true;
                            });
                        errorMsg = '';
                      });
                      debugPrint(value);
                    } else {
                      setState(() {
                        subscribeConfig.prefix = InputConfig.defaultPrefix;
                        subscribeConfig.suffixColor =
                            InputConfig.defaultSuffixColor;
                        subscribeConfig.buttonOnTapCall = null;
                        verifyStarWidgetVisible = false;
                        errorMsg = '';
                      });
                    }
                  },
                ),
                // 回答问题，以证明是真人
                Visibility(
                  visible: verifyStarWidgetVisible,
                  child: const VerifyContentWidget(),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 320.0,
            child: Text(
              errorMsg,
              style: const TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.w100,
              ),
            ),
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
