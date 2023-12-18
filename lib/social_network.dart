import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:application_1/AllPages/RegisteraionPages/Controllers/RegistrationController.dart';
import 'package:application_1/resources/repositories/service_repository.dart';
import 'package:application_1/utils/app_dialog_utils.dart';

import 'model/apple_credentials.dart';

class SocialNetwork extends GetxController {
  final _storage = const FlutterSecureStorage();
  ServiceReposiotry _reposiotry = ServiceReposiotry();
  RegistrationController _registrationController =
      Get.put(RegistrationController());
  static final FacebookLogin facebookSignIn = FacebookLogin();

  facebookLogin() async {
    try {
      facebookSignIn.loginBehavior = FacebookLoginBehavior.webOnly;
      final FacebookLoginResult result = await facebookSignIn.logIn([
        'email',
        'public_profile',
      ]);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          print('''
           Logged in!

           Token: ${accessToken.token}
           User id: ${accessToken.userId}
           Expires: ${accessToken.expires}
           Permissions: ${accessToken.permissions}
           Declined permissions: ${accessToken.declinedPermissions}
           ''');
          // var graphResponse = await GetConnect().get(
          //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
          // var profile = json.decode(graphResponse.body);
          // print(profile.toString());

          // Map _body = <String, String>{
          //   "name": "${profile['first_name']} ${profile['last_name']}",
          //   "email": profile['email'],
          //   "social_id": profile['id'],
          //   "social_type": "facebook",
          //   "user_type": "PROVIDER",
          // };
          Map<String, dynamic> body = {"token": accessToken.token};

          _reposiotry.socialLogin("facebook", body).then((value) {
            if (value.error) {
              AppDialogUtils.errorDialog(value.messageStr);
            } else {
              _registrationController.saveSocialData(value);
            }
          });

          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    } on Exception catch (e) {
      print("$e");
    }
//////////////////
    try {
      // Trigger the sign-in flow
      // final LoginResult loginResult = await FacebookAuth.instance.login();

      // LoginStatus status = loginResult.status;
      // print("abc ${status.name}");

      // if (status == LoginStatus.success) {
      // Map<String, dynamic> body = {"token": loginResult.accessToken!.token};
      // _reposiotry.socialLogin("facebook", body).then((value) {
      //   if (value.error) {
      //     AppDialogUtils.errorDialog(value.messageStr);
      //   } else {
      //     _registrationController.saveSocialData(value);
      //   }
      // });
      // }

      // Create a credential from the access token
      // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    } on Exception catch (e) {
      print("$e");
      AppDialogUtils.dismiss();
    }
  }

  void googleLogin() async {
    try {
      GoogleSignIn _googleSignIn = await GoogleSignIn(
        scopes: [
          'email',
          // 'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      // await _googleSignIn.signIn().then((value) {
      //   print(value);
      // });

      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        if (account != null) {
          print("result: $account");
          AppDialogUtils.dialogLoading();
          Map<String, dynamic> body = {
            "first_name": getName(account.displayName!, "first_name"),
            "last_name": getName(account.displayName!, "last_name"),
            "email": account.email,
            "id": account.id
          };

          _reposiotry.socialLogin("google", body).then((value) {
            if (value.error) {
              AppDialogUtils.errorDialog(value.messageStr);
            } else {
              _registrationController.saveSocialData(value);
            }
          });
          _googleSignIn.disconnect();

          // if (account != null) {
          //   Get.to(
          //     () => Details(),
          //     arguments: account,
          //   );
          // }
        }
      });

      var res = await _googleSignIn.signIn();
      if (res == null) {
        _googleSignIn.disconnect();
      }
      print("ereor");
    } on Exception catch (e) {
      print("errorr $e");
      AppDialogUtils.dismiss();
    }
  }

  void appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      var storageData =
          await _storage.read(key: credential.userIdentifier!) ?? "";
      if (storageData.isEmpty) {
        String? givenName = credential.givenName!.toString().capitalizeFirst;
        String? familyName = credential.familyName!.toString().capitalizeFirst;
        String? email = credential.email!;
        String? id = credential.userIdentifier!;
        AppleCredentials cred = AppleCredentials(
          name: "$givenName $familyName",
          email: email,
          id: id,
        );
        var encodedData = json.encode(cred.toJson());
        _storage.write(key: credential.userIdentifier!, value: encodedData);
        appleLoginToServer(cred.toJson());
      } else {
        var decData = json.decode(storageData);
        AppleCredentials obj = AppleCredentials.fromJson(decData);
        _storage.write(key: credential.userIdentifier!, value: storageData);
        appleLoginToServer(decData);
      }
      print("");
    } on Exception catch (e) {
      print("${e.toString()}");
    }
  }

  getName(String displayName, type) {
    String fName = displayName.split(" ")[0];
    if (type == "first_name") {
      return fName;
    }
    String lName = displayName.replaceAll("$fName ", "");
    return lName.trim();
  }

  void appleLoginToServer(decData) {
    String firstName = decData['name'].split(" ")[0];
    String lastName = "";
    if (decData['name'].split(" ").length > 1) {
      lastName = decData['name'].split(" ")[1];
    }

    print("");
    Map<String, dynamic> body = {
      "first_name": firstName,
      "last_name": lastName,
      "email": decData['email'],
      "id": decData['id']
    };
    AppDialogUtils.dialogLoading();
    _reposiotry.socialLogin("google", body).then((value) {
      _registrationController.saveSocialData(value);
      AppDialogUtils.dismiss();
    });
  }
}
/*
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(
    const MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
     var res = await _googleSignIn.signIn();
      print("");
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
 */
