import 'dart:async';

import 'package:dbus/dbus.dart';

enum XdgAccountType {
  user,
  admin;
}

extension _XdgUserChangedSignal on DBusPropertiesChangedSignal {
  bool get userNameChanged => changedProperties.containsKey('UserName');
  bool get realNameChanged => changedProperties.containsKey('RealName');
  bool get accountTypeChanged => changedProperties.containsKey('AccountType');
  bool get homeDirChanged => changedProperties.containsKey('HomeDirectory');
  bool get shellChanged => changedProperties.containsKey('Shell');
  bool get emailChanged => changedProperties.containsKey('Email');
  bool get languageChanged => changedProperties.containsKey('Language');
}

class XdgUser extends DBusRemoteObject {
  XdgUser(
    DBusClient client,
    String destination, {
    DBusObjectPath path = const DBusObjectPath.unchecked('/'),
  }) : super(client, name: destination, path: path);

  StreamSubscription<DBusPropertiesChangedSignal>? _propertyListener;

  Future<void> init() async {
    _uid = await getUid();
    _userName = await getUserName();
    _realName = await getRealName();
    _accountType = await getAccountType();
    _homeDir = await getHomeDirectory();
    _shell = await getShell();
    _email = await getEmail();
    _language = await getLanguage();
    _propertyListener ??= propertiesChanged.listen(_updateProperties);
  }

  Future<void> _updateProperties(DBusPropertiesChangedSignal signal) async {
    if (signal.userNameChanged) {
      _updateUserName(await getUserName());
    }
    if (signal.realNameChanged) {
      _updateRealName(await getRealName());
    }
    if (signal.accountTypeChanged) {
      _updateAccountType(await getAccountType());
    }
    if (signal.homeDirChanged) {
      _updateHomeDir(await getHomeDirectory());
    }
    if (signal.shellChanged) {
      _updateShell(await getShell());
    }
    if (signal.emailChanged) {
      _updateEmail(await getEmail());
    }
    if (signal.languageChanged) {
      _updateLanguage(await getLanguage());
    }
  }

  Future<void> dispose() async {
    await _propertyListener?.cancel();
    await client.close();
  }

  // Uid
  int? _uid;
  int? get uid => _uid;

  /// Gets org.freedesktop.Accounts.User.Uid
  Future<int> getUid() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Uid',
      signature: DBusSignature('t'),
    );
    return value.asUint64();
  }

  // UserName
  final _userNameChangedController = StreamController<String>.broadcast();
  Stream<String> get userNameChanged => _userNameChangedController.stream;
  String? _userName;
  String? get userName => _userName;
  void _updateUserName(String? value) {
    if (value == null) return;
    _userName = value;
    _userNameChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.UserName
  Future<String> getUserName() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'UserName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  // RealName
  final _realNameChangedController = StreamController<String>.broadcast();
  Stream<String> get realNameChanged => _realNameChangedController.stream;
  String? _realName;
  String? get realName => _realName;
  void _updateRealName(String? value) {
    if (value == null) return;
    _realName = value;
    _realNameChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.RealName
  Future<String> getRealName() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'RealName',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  // AccountType
  final _accountTypeChangedController =
      StreamController<XdgAccountType>.broadcast();
  Stream<XdgAccountType> get accountTypeChanged =>
      _accountTypeChangedController.stream;
  XdgAccountType? _accountType;
  XdgAccountType? get accountType => _accountType;
  void _updateAccountType(XdgAccountType? value) {
    if (value == null) return;
    _accountType = value;
    _accountTypeChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.AccountType
  Future<XdgAccountType> getAccountType() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'AccountType',
      signature: DBusSignature('i'),
    );
    return value.asInt32() == 0 ? XdgAccountType.user : XdgAccountType.admin;
  }

  // HomeDirectory
  final _homeDirChangedController = StreamController<String>.broadcast();
  Stream<String> get homeDirChanged => _homeDirChangedController.stream;
  String? _homeDir;
  String? get homeDir => _homeDir;
  void _updateHomeDir(String? value) {
    if (value == null) return;
    _homeDir = value;
    _homeDirChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.HomeDirectory
  Future<String> getHomeDirectory() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'HomeDirectory',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  // Shell
  final _shellChangedController = StreamController<String>.broadcast();
  Stream<String> get shellChanged => _shellChangedController.stream;
  String? _shell;
  String? get shell => _shell;
  void _updateShell(String? value) {
    if (value == null) return;
    _shell = value;
    _shellChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.Shell
  Future<String> getShell() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Shell',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  // Email
  final _emailChangedController = StreamController<String>.broadcast();
  Stream<String> get emailChanged => _emailChangedController.stream;
  String? _email;
  String? get email => _email;
  void _updateEmail(String? value) {
    if (value == null) return;
    _email = value;
    _emailChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.Email
  Future<String> getEmail() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Email',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  // Language
  final _languageChangedController = StreamController<String>.broadcast();
  Stream<String> get languageChanged => _languageChangedController.stream;
  String? _language;
  String? get language => _language;
  void _updateLanguage(String? value) {
    if (value == null) return;
    _language = value;
    _languageChangedController.add(value);
  }

  /// Gets org.freedesktop.Accounts.User.Language
  Future<String> getLanguage() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Language',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.Session
  Future<String> getSession() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Session',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.SessionType
  Future<String> getSessionType() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'SessionType',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.FormatsLocale
  Future<String> getFormatsLocale() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'FormatsLocale',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.InputSources
  Future<List<Map<String, String>>> getInputSources() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'InputSources',
      signature: DBusSignature('aa{ss}'),
    );
    return value
        .asArray()
        .map(
          (child) => child
              .asDict()
              .map((key, value) => MapEntry(key.asString(), value.asString())),
        )
        .toList();
  }

  /// Gets org.freedesktop.Accounts.User.XSession
  Future<String> getXSession() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'XSession',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.Location
  Future<String> getLocation() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Location',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.LoginFrequency
  Future<int> getLoginFrequency() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'LoginFrequency',
      signature: DBusSignature('t'),
    );
    return value.asUint64();
  }

  /// Gets org.freedesktop.Accounts.User.LoginTime
  Future<int> getLoginTime() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'LoginTime',
      signature: DBusSignature('x'),
    );
    return value.asInt64();
  }

  /// Gets org.freedesktop.Accounts.User.LoginHistory
  // Future<List<DBusStruct>> getLoginHistory() async {
  //   var value = await getProperty(
  //       'org.freedesktop.Accounts.User', 'LoginHistory',
  //       signature: DBusSignature('a(xxa{sv})'));
  //   return value.asArray().map((child) => child.asStruct()).toList();
  // }

  /// Gets org.freedesktop.Accounts.User.XHasMessages
  Future<bool> getXHasMessages() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'XHasMessages',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.freedesktop.Accounts.User.XKeyboardLayouts
  Future<List<String>> getXKeyboardLayouts() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'XKeyboardLayouts',
      signature: DBusSignature('as'),
    );
    return value.asStringArray().toList();
  }

  /// Gets org.freedesktop.Accounts.User.BackgroundFile
  Future<String> getBackgroundFile() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'BackgroundFile',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.IconFile
  Future<String> getIconFile() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'IconFile',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.Saved
  Future<bool> getSaved() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Saved',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.freedesktop.Accounts.User.Locked
  Future<bool> getLocked() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'Locked',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.freedesktop.Accounts.User.PasswordMode
  Future<int> getPasswordMode() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'PasswordMode',
      signature: DBusSignature('i'),
    );
    return value.asInt32();
  }

  /// Gets org.freedesktop.Accounts.User.PasswordHint
  Future<String> getPasswordHint() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'PasswordHint',
      signature: DBusSignature('s'),
    );
    return value.asString();
  }

  /// Gets org.freedesktop.Accounts.User.AutomaticLogin
  Future<bool> getAutomaticLogin() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'AutomaticLogin',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.freedesktop.Accounts.User.SystemAccount
  Future<bool> getSystemAccount() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'SystemAccount',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Gets org.freedesktop.Accounts.User.LocalAccount
  Future<bool> getLocalAccount() async {
    var value = await getProperty(
      'org.freedesktop.Accounts.User',
      'LocalAccount',
      signature: DBusSignature('b'),
    );
    return value.asBoolean();
  }

  /// Invokes org.freedesktop.Accounts.User.SetUserName()
  Future<void> setUserName(
    String name, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetUserName',
      [DBusString(name)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetRealName()
  Future<void> setRealName(
    String name, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetRealName',
      [DBusString(name)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetEmail()
  Future<void> setEmail(
    String email, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetEmail',
      [DBusString(email)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetLanguage()
  Future<void> setLanguage(
    String language, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetLanguage',
      [DBusString(language)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetFormatsLocale()
  Future<void> setFormatsLocale(
    String formatsLocale, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetFormatsLocale',
      [DBusString(formatsLocale)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetInputSources()
  Future<void> setInputSources(
    List<Map<String, String>> sources, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetInputSources',
      [
        DBusArray(
          DBusSignature('a{ss}'),
          sources.map(
            (child) => DBusDict(
              DBusSignature('s'),
              DBusSignature('s'),
              child.map(
                (key, value) => MapEntry(DBusString(key), DBusString(value)),
              ),
            ),
          ),
        )
      ],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetXSession()
  Future<void> setXSession(
    String xSession, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetXSession',
      [DBusString(xSession)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetSession()
  Future<void> setSession(
    String session, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetSession',
      [DBusString(session)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetSessionType()
  Future<void> setSessionType(
    String sessionType, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetSessionType',
      [DBusString(sessionType)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetLocation()
  Future<void> setLocation(
    String location, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetLocation',
      [DBusString(location)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetHomeDirectory()
  Future<void> setHomeDirectory(
    String homedir, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetHomeDirectory',
      [DBusString(homedir)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetShell()
  Future<void> setShell(
    String shell, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetShell',
      [DBusString(shell)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetXHasMessages()
  Future<void> setXHasMessages(
    bool hasMessages, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetXHasMessages',
      [DBusBoolean(hasMessages)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetXKeyboardLayouts()
  Future<void> setXKeyboardLayouts(
    List<String> layouts, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetXKeyboardLayouts',
      [DBusArray.string(layouts)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetBackgroundFile()
  Future<void> setBackgroundFile(
    String filename, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetBackgroundFile',
      [DBusString(filename)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetIconFile()
  Future<void> setIconFile(
    String filename, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetIconFile',
      [DBusString(filename)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetLocked()
  Future<void> setLocked(
    bool locked, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetLocked',
      [DBusBoolean(locked)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetAccountType()
  Future<void> setAccountType(
    int accountType, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetAccountType',
      [DBusInt32(accountType)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetPasswordMode()
  Future<void> setPasswordMode(
    int mode, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetPasswordMode',
      [DBusInt32(mode)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetPassword()
  Future<void> setPassword(
    String password,
    String hint, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetPassword',
      [DBusString(password), DBusString(hint)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetPasswordHint()
  Future<void> setPasswordHint(
    String hint, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetPasswordHint',
      [DBusString(hint)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.SetAutomaticLogin()
  Future<void> setAutomaticLogin(
    bool enabled, {
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    await callMethod(
      'org.freedesktop.Accounts.User',
      'SetAutomaticLogin',
      [DBusBoolean(enabled)],
      replySignature: DBusSignature(''),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
  }

  /// Invokes org.freedesktop.Accounts.User.GetPasswordExpirationPolicy()
  Future<List<DBusValue>> callGetPasswordExpirationPolicy({
    bool noAutoStart = false,
    bool allowInteractiveAuthorization = false,
  }) async {
    var result = await callMethod(
      'org.freedesktop.Accounts.User',
      'GetPasswordExpirationPolicy',
      [],
      replySignature: DBusSignature('xxxxxx'),
      noAutoStart: noAutoStart,
      allowInteractiveAuthorization: allowInteractiveAuthorization,
    );
    return result.returnValues;
  }
}
