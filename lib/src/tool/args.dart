class Args {
  Args(List<String> arguments) {
    final arg = arguments.join(' ');

    final reg = RegExp(
      r'^ *(subsystem) *= *(GUI|Console) +(.+)$',
      caseSensitive: false,
    ).allMatches(arg);

    if (reg.isEmpty && reg.elementAt(0).groupCount != 3) {
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

    _fileName = (match.group(3) ?? '');
    if (_fileName == '') {
      throw 'Arguments error. '
          'Third argument should be a file name';
    }
  }

  String get fileName => _fileName;
  bool get isSubsystem => _subsystem != '';
  String get subsystem => _subsystem;

  String _fileName = '';
  String _subsystem = '';
}
