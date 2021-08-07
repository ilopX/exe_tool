class Args {
  Args(List<String> arguments) {
    final arg = arguments.join(' ');

    final reg = RegExp(
      r'^ *(subsystem) *= *(GUI|Console) +(showInfo)? *(.+)$',
      caseSensitive: false,
    ).allMatches(arg);

    if (reg.isEmpty && reg.elementAt(0).groupCount != 4) {
      throw 'Arguments error. '
          'Example: subsystem = GUI d:\\file.exe';
    }

    final match = reg.elementAt(0);

    final flagName = (match.group(1) ?? '').toLowerCase();
    if (flagName != 'subsystem') {
      throw 'Arguments error. First argument should be "subsystem"';
    }

    _subsystem = (match.group(2) ?? '').toLowerCase();
    if (_subsystem != 'gui' && _subsystem != 'console') {
      throw 'Arguments error("$_subsystem"). '
          'Second argument should be "gui" or "console"';
    }

    _isShowInfo = (match.group(3) != null);

    _fileName = (match.group(4) ?? '');
    if (_fileName == '') {
      throw 'Arguments error. '
          'Foure argument should be a file name';
    }
  }

  String _fileName = '';
  String get fileName => _fileName;

  String _subsystem = '';
  bool get isSubsystem => _subsystem != '';
  String get subsystem => _subsystem;

  bool _isShowInfo = false;
  bool get isShowInfo => _isShowInfo;
}
