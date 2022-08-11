/// Common function class
class Funcs {
  ///  Converts an integer into a string in specified units
  static String intToUnit([int num = 0, int unitNum = 1, String unit = 'k']) {
    double newNum = num / unitNum;
    if (newNum < 1) {
      return '$num';
    }

    String newNumStr = newNum.toStringAsFixed(1);
    String decimal = newNumStr.substring(newNumStr.indexOf('.') + 1);
    if (decimal == '0') {
      newNumStr = newNumStr.substring(0, newNumStr.indexOf('.'));
    }

    return '$newNumStr$unit';
  }

  /// diff now date time
  static String dateDiff(String dt) {
    DateTime dtParse = DateTime.parse(dt).toLocal();
    DateTime now = DateTime.now();
    Duration diff = now.difference(dtParse);

    if (diff.inDays > 30) {
      return 'on ${dtParse.day} ${_formatMonth(dtParse.month)}';
    } else if (diff.inHours > 24) {
      return '${diff.inDays} day ago';
    } else if (diff.inMinutes > 60) {
      return '${diff.inHours} hours ago';
    } else if (diff.inSeconds > 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} seconds age';
    }

    return '';
  }

  /// Convert digital months into English abbreviations
  static String _formatMonth(int month) {
    Map<int, String> months = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    return months[month] ?? '';
  }
}
