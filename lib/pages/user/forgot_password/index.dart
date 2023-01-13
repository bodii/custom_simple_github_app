import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:custom_simple_github_app/commons/verify.dart';
import 'package:custom_simple_github_app/pages/user/sign_up/verify_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool startLoadImage = true;
  bool verifyHomeVisible = false;
  bool verifySelectImageVisible = false;
  final Map<String, String> selectImages = {
    'lock': '锁',
    'fence': '栅栏',
  };
  late List<String> selectEnNames = selectImages.keys.toList();
  final List<int> verifySecondName = [1, 2, 3, 4, 5, 6];

  bool notVisibleError = true;
  int successStep = 0;

  @override
  void initState() {
    super.initState();
    verifySecondName.shuffle();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        verifyHomeVisible = true;
        startLoadImage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              InkWell(
                child: SizedBox(
                  width: 46.0,
                  height: 46.0,
                  child: SvgPicture.asset('assets/images/favicon-dark.svg'),
                ),
                onTap: () => context.goNamed(AppRoutes.home),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: const Text(
                  'Reset your password',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.white70,
                  ),
                ),
              ),
              Offstage(
                offstage: notVisibleError,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(bottom: 15.0),
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.1),
                    border: Border.all(color: Colors.red, width: .15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 279.0,
                        child: Text(
                          'Unable to verify your captcha response. Please visit '
                          'https://docs.github.com/articles/troubleshooting-'
                          'connectivity-problems/#troubleshooting-the-captcha for '
                          'troubleshooting information. ',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12.0),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.topRight,
                        color: Colors.red,
                        iconSize: 14.0,
                        onPressed: () {
                          setState(() {
                            notVisibleError = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 350.0,
                height: 475.0,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black26,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Enter your user account\'s verified email'
                      ' address and we will send you a password '
                      'reset link.',
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      height: 33.0,
                      child: TextFormField(
                        autofocus: true,
                        maxLines: 1,
                        minLines: 1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 2.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: .2,
                              color: Colors.white,
                            ),
                          ),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: .3,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(32),
                        ],
                        cursorColor: Colors.white,
                        cursorWidth: .6,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (!Verify.isEmail(value)) {
                              setState(() {
                                notVisibleError = false;
                                successStep = 0;
                              });
                            } else {
                              setState(() {
                                notVisibleError = true;
                                successStep = 1;
                              });
                            }
                          } else {
                            setState(() {
                              notVisibleError = true;
                              successStep = 0;
                            });
                          }
                        },
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'Verify your account',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 330.0,
                      height: 265.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: .2, color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: startLoadImage,
                            child: Image.asset(
                              'assets/images/octocat-spinner-128.gif',
                              width: 80.0,
                            ),
                          ),
                          Visibility(
                            visible: verifyHomeVisible,
                            child: Column(
                              children: [
                                const Text(
                                  '请回答此问题\n以证明您是真人',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 30.0),
                                  width: 100.0,
                                  height: 35.0,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 0.15,
                                      ),
                                    ),
                                    child: const Text('验证'),
                                    onPressed: () {
                                      setState(() {
                                        verifyHomeVisible = false;
                                        verifySelectImageVisible = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: verifySelectImageVisible,
                            child: Column(
                              children: [
                                Text(
                                  '选出${selectImages[selectEnNames.first]}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Container(
                                  height: 198.0,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0,
                                    vertical: 2.0,
                                  ),
                                  child: Column(
                                    children: [
                                      for (int col = 0; col <= 1; col++)
                                        Row(
                                          children: [
                                            for (int n
                                                in verifySecondName.sublist(
                                                    0 + (col * 3),
                                                    3 + (col * 3)))
                                              VerifyImageWidget(
                                                imageFirstName:
                                                    selectEnNames.first,
                                                imageSecondName: '$n',
                                              ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    margin: const EdgeInsets.only(
                                      left: 12.0,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.loop,
                                        color: Colors.white,
                                        size: 19.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          verifySecondName.shuffle();
                                          selectEnNames.shuffle();
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      margin: const EdgeInsets.only(top: 18.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                        ),
                        child: const Text(
                          'Send password reset email',
                          style: TextStyle(
                            color: Colors.white54,
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
      ),
    );
  }
}
