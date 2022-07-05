class Verify {
  static bool isEmail(String val) {
    return RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$')
        .hasMatch(val);
  }
}
