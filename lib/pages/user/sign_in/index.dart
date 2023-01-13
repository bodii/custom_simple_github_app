import 'package:custom_simple_github_app/commons/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignInIndexView extends StatelessWidget {
  const SignInIndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Container(
        color: Colors.black87,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/fluidicon_s.png',
                  width: 60.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Sign in to GitHub',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                  ),
                ),
                const LoginFormWidget(),
                Container(
                  width: 300,
                  height: 55,
                  margin: const EdgeInsets.only(top: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: .6, color: Colors.white70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New to GitHub? ',
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        child: const Text(
                          'Greate an account',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => context.goNamed(AppRoutes.signUp),
                      ),
                      const Text(
                        '.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      width: 300.0,
      height: 240.0,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.3, color: Colors.white54),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Username or email address',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              const CustomTextFieldWidget(
                width: double.infinity,
                height: 36.0,
                visibleOff: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.goNamed(AppRoutes.forgotPassword),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomTextFieldWidget(
                    width: 220.0,
                    height: 36.0,
                    visibleOff: !passwordVisibility,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        passwordVisibility = !passwordVisibility;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green[800]),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40.0,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                onPressed: () => context.goNamed(AppRoutes.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    Key? key,
    required this.width,
    required this.height,
    this.visibleOff = true,
  }) : super(key: key);
  final double width;
  final double height;
  final bool visibleOff;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.only(top: 8.0, bottom: 15.0),
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        decoration: InputDecoration(
          // hintText: 'username',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.7),
              width: .5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.1,
            ),
          ),
          fillColor: Colors.black87,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 14.0,
          ),
        ),
        style: const TextStyle(
          fontSize: 15.0,
          color: Colors.white70,
        ),
        cursorColor: Colors.white,
        inputFormatters: [
          LengthLimitingTextInputFormatter(40),
        ],
        maxLines: 1,
        minLines: 1,
        obscureText: widget.visibleOff,
      ),
    );
  }
}
