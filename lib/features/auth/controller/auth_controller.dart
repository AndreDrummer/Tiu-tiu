import 'package:tiutiu/features/auth/models/email_password_auth.dart';
import 'package:tiutiu/core/local_storage/local_storage_keys.dart';
import 'package:tiutiu/features/auth/service/auth_service.dart';
import 'package:tiutiu/core/local_storage/local_storage.dart';
import 'package:tiutiu/core/constants/images_assets.dart';
import 'package:tiutiu/features/system/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

enum AuthKeys {
  password,
  token,
  email,
}

class AuthController extends GetxController {
  AuthController({required AuthService authService})
      : _authService = authService;

  final AuthService _authService;

  final Rx<EmailAndPasswordAuth> _emailAndPasswordAuth =
      EmailAndPasswordAuth().obs;
  final RxBool _isCreatingNewAccount = false.obs;
  final RxBool _isShowingPassword = false.obs;
  final RxBool _isLoading = false.obs;

  EmailAndPasswordAuth get emailAndPasswordAuth => _emailAndPasswordAuth.value;
  bool get isCreatingNewAccount => _isCreatingNewAccount.value;
  bool get isShowingPassword => _isShowingPassword.value;
  bool get userExists => _authService.userExists;
  bool get isLoading => _isLoading.value;

  User? get user => _authService.authUser;

  void set _setEmailAndPasswordAuth(EmailAndPasswordAuth newValue) {
    _emailAndPasswordAuth(newValue);
  }

  void set isCreatingNewAccount(bool value) => _isCreatingNewAccount(value);
  void set isShowingPassword(bool value) => _isShowingPassword(value);
  void set isLoading(bool value) => _isLoading(value);

  void clearEmailAndPassword() {
    _emailAndPasswordAuth(EmailAndPasswordAuth());
  }

  void updateEmailAndPasswordAuth(
    EmailAndPasswordAuthEnum property,
    dynamic data,
  ) {
    final map = emailAndPasswordAuth.toMap();
    map[property.name] = data;

    _setEmailAndPasswordAuth = EmailAndPasswordAuth().fromMap(map);
  }

  Future<bool> createUserWithEmailAndPassword() async {
    bool success = false;

    if (emailAndPasswordAuth.password == emailAndPasswordAuth.repeatPassword) {
      isLoading = true;
      success = await _authService.createUserWithEmailAndPassword(
        password: emailAndPasswordAuth.password!,
        email: emailAndPasswordAuth.email!,
      );

      if (success) {
        await loadUserData();
        saveEmailAndPasswordAuthData();
      }

      isCreatingNewAccount = false;
      isShowingPassword = false;
      isLoading = false;
    }

    return success;
  }

  Future<bool> loginWithEmailAndPassword() async {
    isLoading = true;

    final bool success = await _authService.loginWithEmailAndPassword(
      password: emailAndPasswordAuth.password!,
      email: emailAndPasswordAuth.email!,
    );

    if (success) {
      await loadUserData();
      saveEmailAndPasswordAuthData();
    }

    isShowingPassword = false;
    isLoading = false;

    debugPrint('${success ? 'Successfully' : 'Not'} authenticated');

    return success;
  }

  Future<bool> loginWithFacebook({String? token}) async {
    isLoading = true;
    final bool success = await _authService.loginWithFacebook(token: token);

    if (success) {
      await loadUserData();
      saveFacebookToken(_authService.facebookToken);
    }

    isLoading = false;

    return success;
  }

  Future<void> passwordReset(String email) async {
    await _authService.passwordReset(email);
  }

  Future<bool> tryAutoLoginIn() async {
    bool success = false;

    final hosters = [
      await trySignInWithEmailAndPassword(),
      await tryLoginWithFacebook(),
    ];

    int count = 0;
    while (!success && count < hosters.length) {
      success = hosters[count];
      count++;
    }

    return success;
  }

  Future<bool> trySignInWithEmailAndPassword() async {
    final emailPasswordAuthData = await LocalStorage.getDataUnderKey(
      key: LocalStorageKey.emailPasswordAuthData,
      mapper: EmailAndPasswordAuth(),
    ) as EmailAndPasswordAuth?;

    if (emailPasswordAuthData != null) {
      _setEmailAndPasswordAuth = EmailAndPasswordAuth(
        password: (emailPasswordAuthData).password,
        email: emailPasswordAuthData.email,
      );

      return loginWithEmailAndPassword();
    }

    return false;
  }

  Future<bool> tryLoginWithFacebook() async {
    final facebookToken = await LocalStorage.getValueUnderString(
      LocalStorageKey.facebookAuthData.name,
    );

    if (facebookToken != null) {
      return loginWithFacebook(token: facebookToken);
    }

    return false;
  }

  void saveEmailAndPasswordAuthData() {
    LocalStorage.setDataUnderKey(
      key: LocalStorageKey.emailPasswordAuthData,
      data: {
        AuthKeys.password.name: emailAndPasswordAuth.password!,
        AuthKeys.email.name: emailAndPasswordAuth.email!,
      },
    );
  }

  void saveFacebookToken(String? facebookToken) {
    LocalStorage.setValueUnderString(
      key: LocalStorageKey.facebookAuthData.name,
      value: facebookToken,
    );
  }

  Future<void> loadUserData() async {
    // TODO: Update creationData and lastSignInTime
    // _firebaseAuth.currentUser?.metadata.creationTime
    await tiutiuUserController.updateLoggedUserData(
      authController.user!.uid,
    );
  }

  Future<void> signOut() async {
    await _authService.logOut();
    clearAllAuthData();
    clearEmailAndPassword();
    homeController.bottomBarIndex = 0;
    print('Deslogado!');
  }

  void clearAllAuthData() {
    tiutiuUserController.resetUserData();
    LocalStorageKey.values.forEach((key) {
      if (key != LocalStorageKey.firstOpen)
        LocalStorage.deleteDataUnderKey(key);
    });
  }

  final _startScreenImages = [
    StartScreenAssets.whiteCat,
    StartScreenAssets.greyCat,
    StartScreenAssets.pinscher,
    StartScreenAssets.oldMel,
    StartScreenAssets.munkun,
    StartScreenAssets.liu,
    StartScreenAssets.husky,
    StartScreenAssets.hairy,
  ];

  List<String> get startScreenImages => _startScreenImages;
}
