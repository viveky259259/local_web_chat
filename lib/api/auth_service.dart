//import 'dart:async';
//import 'dart:convert';
//import 'dart:io';
//
//
//import 'package:http/http.dart' as http;
//
//class AuthService {
//  AuthService._();
//
////  FirebaseAuth _firebaseAuth;
////  FirebaseUser currentFirebaseUser;
////  GoogleSignInAccount googleAccount;
////  User user;
//
////  final GoogleSignIn googleSignIn = new GoogleSignIn();
//
////  static Future<AuthService> create({FirebaseAuth firebaseAuth}) async {
////    var repository = AuthService._();
////    await repository._load();
////    return repository;
////  }
//
//  _load() async {
////    _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
////    googleAccount = googleSignIn.currentUser;
//  }
//
////  Future<ApiResult<FirebaseUser>> signUp(email, password, firstName, lastName,
////      mobile, zipCode, profileImage) async {
////    ApiResult<FirebaseUser> apiResult = ApiResult();
////    try {
////      FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
////              email: email, password: password))
////          .user;
////
////      String imageUrl = await uploadMemberImage(profileImage, firstName);
////      await storeUser(user,
////          firstName: firstName,
////          lastName: lastName,
////          mobile: mobile,
////          zipCode: zipCode,
////          provider: 'email',
////          imageUrl: imageUrl,
////          bonz: appConfig.defaultBonzOnSignUp);
////
////      currentFirebaseUser = user;
////
////      apiResult
////        ..result = user
////        ..isSuccess = true;
////    } catch (e) {
////      String message;
////      if (e is PlatformException) {
////        message = e.message;
////      }
////      apiResult
////        ..message = message ?? e.toString()
////        ..isSuccess = false;
////      print('error');
////      print(e);
////    }
////    return apiResult;
////  }
//
////  Future<String> uploadMemberImage(File image, String userName) async {
////    String uploadedImageUrl = await ImageUploader()
////        .uploadImageToFirebaseStorage(
////            image, Statics.ProfileImageStorageBucket, userName);
////    return uploadedImageUrl;
////  }
//
////  Future<User> signIn(String email, String password) async {
////    try {
////      final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
////              email: email, password: password))
////          .user;
////
////      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
////
////      assert(user.uid == currentUser.uid);
////
////      currentFirebaseUser = user;
////
////      return await storeUser(user, provider: 'email');
////    } catch (e) {
////      return null;
////    }
////  }
//
////  Future<User> signInWithGoogle() async {
////    if (googleAccount == null) {
////      // Start the sign-in process:
////
////      googleAccount = await googleSignIn.signIn();
////    }
////    FirebaseUser user = await signIntoFirebase(googleAccount);
////
////    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
////
////    assert(user.uid == currentUser.uid);
////
////    currentFirebaseUser = user;
////
////    return await storeUser(user,
////        provider: 'google',
////        imageUrl: user.photoUrl,
////        firstName: user.displayName);
////  }
////
////  Future<FirebaseUser> signIntoFirebase(
////      GoogleSignInAccount googleSignInAccount) async {
////    GoogleSignInAuthentication googleAuth =
////        await googleSignInAccount.authentication;
////
////    final AuthCredential credential = GoogleAuthProvider.getCredential(
////      accessToken: googleAuth.accessToken,
////      idToken: googleAuth.idToken,
////    );
////
////    final FirebaseUser user =
////        (await _firebaseAuth.signInWithCredential(credential)).user;
////    return user;
////  }
////
////  Future<Map<String, dynamic>> signInWithFacebook() async {
////    var facebookLogin = FacebookLogin();
////    var facebookLoginResult =
////        await facebookLogin.logIn(['email', 'public_profile']);
////
////    if (facebookLoginResult.status == FacebookLoginStatus.error) {
////      return {'error': facebookLoginResult.errorMessage};
////    } else if (facebookLoginResult.status ==
////        FacebookLoginStatus.cancelledByUser) {
////      return {'error': facebookLoginResult.errorMessage};
////    } else if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
////      var token = facebookLoginResult.accessToken.token;
////      final AuthCredential credential =
////          FacebookAuthProvider.getCredential(accessToken: token);
////      final FirebaseUser user =
////          (await _firebaseAuth.signInWithCredential(credential)).user;
////      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
////      var graphResponse = await http.get(
////          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${facebookLoginResult.accessToken.token}');
////      var profile = json.decode(graphResponse.body);
////
////      assert(user.uid == currentUser.uid);
////
////      currentFirebaseUser = user;
////      String imageUrl;
////      if (profile['picture']?.length > 0)
////        imageUrl = profile['picture']['data']['url'];
////      await storeUser(user,
////          provider: 'facebook',
////          firstName: profile['first_name'],
////          lastName: profile['last_name'],
////          imageUrl: imageUrl);
////      return {"user": user};
////    } else {
////      return null;
////    }
////  }
////
////  Future<void> forgotPassword(String email) async {
////    await _firebaseAuth.sendPasswordResetEmail(email: email);
////  }
//
//  Future storeUser(
//      {String firstName,
//      String lastName,
//      String mobile,
//      String zipCode,
//      String provider,
//      String imageUrl,
//      int bonz}) async {
//    if (firebaseUser == null) return User();
//    user = await getLocalUser();
//
//    if (user == null || user == User()) {
//      user = await userRepository.get(firebaseUser.email);
//      if (user == null || user == User()) {
//        user = await userRepository.insert(User(
//            email: firebaseUser.email,
//            firebaseUid: firebaseUser.uid,
//            firstName: firstName,
//            lastName: lastName,
//            mobile: mobile,
//            zipCode: zipCode,
//            provider: provider,
//            profileImageUrl: imageUrl,
//            bonz: bonz ?? 0));
//      } else {
//        if (imageUrl != null)
//          user = await userRepository.updateProfile(user.email,
//              userProfileUrl: imageUrl);
//      }
//    }
//
//    return user;
//  }
//
//  Future<void> logOut() async {
//    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
//
//    return Future.wait([_firebaseAuth.signOut()]);
//  }
//
//  Future<bool> isLoggedIn() async {
//    final currentUser = await _firebaseAuth.currentUser();
//    return currentUser != null;
//  }
//
//  Future<FirebaseUser> getUser() async {
//    return (await _firebaseAuth.currentUser());
//  }
//
//  Future<User> getLocalUser() async {
//    return await userLocal.getLocalUser();
//  }
//}
