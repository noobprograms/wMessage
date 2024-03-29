import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nial_deliveries/core/models/user_model.dart' as usermodel;
import 'package:nial_deliveries/core/utils/auth_constants.dart';
import 'package:nial_deliveries/core/utils/zego_appId.dart';
import 'package:nial_deliveries/routes/app_routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  String? token = '';
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  static usermodel.User userToStore = usermodel.User(
    uid: '',
    name: '',
    email: '',
    tokenValue: '',
    phoneNumber: "",
  );
  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      if (Get.currentRoute != '/login_screen')
        Get.offNamed(AppRoutes.signUpScreen);
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      // await firebaseFirestore.collection('users').doc(user.uid).get().then((value) => value.data());
      var toPutName = '';
      var toPutPhoto = '';
      if (user.displayName != null) toPutName = user.displayName!;
      if (user.photoURL != null) toPutPhoto = user.photoURL!;
      userToStore.updateUser(
        user.uid,
        toPutName,
        user.email,
        toPutPhoto,
      );
      Get.offAllNamed(AppRoutes.chatsScreen,
          arguments: {'currentUser': userToStore});
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) async {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAllNamed(AppRoutes.signUpScreen);
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      var profileImage;
      var coverImage;
      var result = await firebaseFirestore
          .collection('users')
          .doc(googleSignInAccount.id)
          .get();

      if (result.exists) {
        userToStore = usermodel.User(
            uid: result.data()!['uid'],
            name: result.data()!['name'],
            email: result.data()!['email'],
            tokenValue: result.data()!['tokenValue'],
            profileImageUrl: result.data()!['profileImageUrl'],
            phoneNumber: result.data()!['phoneNumber']);
      } else {
        userToStore = usermodel.User(
          uid: googleSignInAccount.id,
          name: googleSignInAccount.displayName!,
          email: googleSignInAccount.email!,
          profileImageUrl: googleSignInAccount.photoUrl!,
          phoneNumber: "",
          tokenValue: token!,
        );
        await firebaseFirestore
            .collection('users')
            .doc(googleSignInAccount.id)
            .set(userToStore.toJson());
      }
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: zegoAppID /*input your AppID*/,
        appSign: zegoAppSignIn /*input your AppSign*/,
        userID: result.data()!['uid'].substring(0, 4),
        userName: result.data()!['name'],
        plugins: [ZegoUIKitSignalingPlugin()],
      );

      Get.offAllNamed(AppRoutes.chatsScreen,
          arguments: {'currentUser': userToStore});
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        getNotificationToken();
        UserCredential cred = await auth.signInWithCredential(credential);
        firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .get()
            .then((value) async {
          if (value.exists)
            null;
          else {
            userToStore = usermodel.User(
              uid: cred.user!.uid,
              name: cred.user!.displayName!,
              email: cred.user!.email!,
              profileImageUrl: cred.user!.photoURL!,
              phoneNumber: "",
              tokenValue: token!,
            );
            await firebaseFirestore
                .collection('users')
                .doc(cred.user!.uid)
                .set(userToStore.toJson());
          }
        });
        // userToStore = usermodel.User(
        //   uid: cred.user!.uid,
        //   name: cred.user!.displayName!,
        //   email: cred.user!.email!,
        //   profileImageUrl: cred.user!.photoURL!,
        //   following: cred.user!.,
        //   tokenValue: token!,
        // );
        // await firebaseFirestore
        //     .collection('users')
        //     .doc(cred.user!.uid)
        //     .set(userToStore.toJson());
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void getNotificationToken() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      if (value != null) token = value;
    });
  }

  void register(String email, password, name, number) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      getNotificationToken();
      userToStore = usermodel.User(
        uid: cred.user!.uid,
        name: name,
        email: email,
        tokenValue: token!,
        phoneNumber: number,
      );

      await firebaseFirestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(userToStore.toJson());
    } catch (firebaseAuthException) {}
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-?_'), ' ').capitalize!;
      String message = '';
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
          message =
              'Your email is not correctly formatted. Enter a correct email.';
        case 'wrong-password':
          message = 'Wrong Password entered. Please Login again.';
        case 'user-not-found':
          message =
              'No account exists for the provided email. Sign up to create one.';
        case 'INVALID_LOGIN_CREDENTIALS':
          message =
              'The password does not match the account or the account does not exists.';
        default:
          message = e.message.toString();
      }
      Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    await auth.signOut();
  }

  // Future<String> uploadToFirebase(String path) {
  //   File fileToUpload = File(path);
  //   Reference ref = firebaseStorage
  //       .ref()
  //       .child('profilePics')
  //       .child(firebaseAuth.currentUser!.uid);

  //   UploadTask uploadTask = ref.putFile(image);
  //   TaskSnapshot snap = await uploadTask;
  //   String downloadUrl = await snap.ref.getDownloadURL();
  //   return downloadUrl;
  // }
}
