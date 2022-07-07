import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              onTap: () => Get.toNamed(AppRoutes.home),
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
            Container(
              width: 350.0,
              height: 450.0,
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
                            color: Color.fromARGB(255, 48, 48, 48),
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(23),
                      ],
                      cursorColor: Colors.white,
                      cursorWidth: .6,
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
                  Visibility(
                    visible: true,
                    child: Container(
                      width: 330.0,
                      height: 240.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: .2, color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 0.15,
                                ),
                              ),
                              child: const Text('验证'),
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
