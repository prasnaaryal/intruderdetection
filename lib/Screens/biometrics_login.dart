import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Fingerprint extends StatefulWidget {
  const Fingerprint({Key? key}) : super(key: key);

  @override
  State<Fingerprint> createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    _checkBiometrics();
    _getAvailableBiometrics();
    _authenticateWithBiometrics();
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.only(top: 30),
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 if (_supportState == _SupportState.unknown)
//                   const CircularProgressIndicator()
//                 else if (_supportState == _SupportState.supported)
//                   const Text('This device is supported')
//                 else
//                   const Text('This device is not supported'),
//                 const Divider(height: 100),
//                 Text('Can check biometrics: $_canCheckBiometrics\n'),
//                 ElevatedButton(
//                   onPressed: _checkBiometrics,
//                   child: const Text('Check biometrics'),
//                 ),
//                 const Divider(height: 100),
//                 Text('Available biometrics: $_availableBiometrics\n'),
//                 ElevatedButton(
//                   onPressed: _getAvailableBiometrics,
//                   child: const Text('Get available biometrics'),
//                 ),
//                 const Divider(height: 100),
//                 Text('Current State: $_authorized\n'),
//                 if (_isAuthenticating)
//                   ElevatedButton(
//                     onPressed: _cancelAuthentication,
//                     // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                     // ignore: prefer_const_constructors
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const <Widget>[
//                         Text('Cancel Authentication'),
//                         Icon(Icons.cancel),
//                       ],
//                     ),
//                   )
//                 else
//                   Column(
//                     children: <Widget>[
//                       ElevatedButton(
//                         onPressed: _authenticate,
//                         // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                         // ignore: prefer_const_constructors
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: const <Widget>[
//                             Text('Authenticate'),
//                             Icon(Icons.perm_device_information),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: _authenticateWithBiometrics,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Text(_isAuthenticating
//                                 ? 'Cancel'
//                                 : 'Authenticate: biometrics only'),
//                             const Icon(Icons.fingerprint),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/fingerprint.png',
                    width: 120.0,
                  ),
                  Text(
                    'Fingerprint Auth',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Text(
                      "Authentication using your fingerprint instead of your password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _authenticate();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: 24.0),
                        child: Text(
                          "Authenticate",
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
    ));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
