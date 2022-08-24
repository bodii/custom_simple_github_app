import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputWidget extends StatefulWidget {
  const CustomInputWidget({
    Key? key,
    this.visible = false,
    this.label = '',
    this.obscure = false,
    this.buttonVisible = true,
    required this.suffixColor,
    required this.prefix,
    this.onPressed,
    this.inputController,
    this.onChanged,
  }) : super(key: key);

  final bool visible;
  final String label;
  final bool obscure;
  final bool buttonVisible;
  final Color suffixColor;
  final Text prefix;
  final void Function()? onPressed;
  final TextEditingController? inputController;
  final void Function(String)? onChanged;

  @override
  _CustomInputWidgetState createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  late bool visiblePassword; // = widget.obscure;

  @override
  void initState() {
    super.initState();
    visiblePassword = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15.0,
          ),
          Text(
            widget.label,
            style: const TextStyle(
              color: Color.fromRGBO(59, 255, 248, 1.0),
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              widget.prefix,
              Container(
                width: 180.0,
                margin: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 5.0,
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
                    obscureText: visiblePassword,
                    cursorColor: Colors.white,
                    cursorWidth: .6,
                    controller: widget.inputController,
                    onChanged: widget.onChanged,
                  ),
                ),
              ),
              Visibility(
                visible: widget.obscure,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 3.0),
                  icon: Icon(
                    visiblePassword ? Icons.visibility : Icons.visibility_off,
                    size: 22.0,
                  ),
                  onPressed: () {
                    setState(() {
                      visiblePassword = !visiblePassword;
                    });
                  },
                ),
              ),
              Visibility(
                visible: !widget.obscure,
                child: const SizedBox(
                  width: 30.0,
                ),
              ),
              Visibility(
                visible: widget.buttonVisible,
                child: OutlinedButton(
                  onPressed: widget.onPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: .6,
                      color: widget.suffixColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: widget.suffixColor),
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
