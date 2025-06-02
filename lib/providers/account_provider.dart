import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:te_find/models/BannerModel.dart';
import 'package:te_find/models/auth_model.dart';
import 'package:te_find/models/SignInResponse.dart';
import 'package:te_find/models/storage/app_storage.dart';
import 'package:te_find/models/util_model.dart';
import 'package:te_find/repository/auth_repository.dart';
import 'package:te_find/services/dialog_service.dart';
import 'package:te_find/services/navigation/navigator_service.dart';
import 'package:te_find/services/navigation/route_names.dart';
import 'package:te_find/utils/assets_manager.dart';
import 'package:te_find/utils/base_model.dart';
import 'package:te_find/utils/enums.dart';
import 'package:te_find/utils/helpers.dart';
import 'package:te_find/utils/locator.dart';
import 'package:te_find/utils/storage_util.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';

import '../models/CustomerAddressModel.dart';
import '../models/PickUpLocationModel.dart';

class AccountProvider extends BaseModel {
  final NavigatorService _navigation = locator<NavigatorService>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final DialogService dialogService = locator<DialogService>();
  ScrollController? controller;
  LoadingState _loadingState = LoadingState.idle;
  LoadingState get loadingState => _loadingState;
  LoadingState _fetchState = LoadingState.loading;
  LoadingState get fetchState => _fetchState;
  List<BannerModel>? _bannerList;
  List<BannerModel>? get bannerList => _bannerList;
  List<CustomerAddress>? _addressList;
  List<CustomerAddress>? get addressList => _addressList;
  List<PickUpLocation>? _pickUpAddress;
  List<PickUpLocation>? get pickUpAddress => _pickUpAddress;
  int? selectedAddressIndex;
  int? selectedPickUpIndex;
  CustomerAddress? _currentLocationAddress;
  CustomerAddress? get currentLocationAddress => _currentLocationAddress;

  CustomerAddress getSelectedAddress(List<CustomerAddress> addressList) {
    if (selectedAddressIndex == null && _currentLocationAddress != null) {
      return _currentLocationAddress!;
    }
    if (selectedAddressIndex != null &&
        selectedAddressIndex! < addressList.length) {
      return addressList[selectedAddressIndex!];
    }
    if (addressList.isNotEmpty) {
      return addressList.first;
    }
    return CustomerAddress(
      addressId: 0,
      addressTitle: '',
      address: '',
      city: '',
      state: '',
      landmark: '',
      defaultAddress: false,
    );
  }

  PickUpLocation getSelectedPickUpAddress(
      List<PickUpLocation> pickUpAddressList) {
    if (pickUpAddressList.isEmpty) {
      return PickUpLocation();
    }
    if (selectedPickUpIndex != null &&
        selectedPickUpIndex! < pickUpAddressList.length) {
      return pickUpAddressList[selectedPickUpIndex!];
    }
    return pickUpAddressList.first;
  }

// functions for profile pages
  void onTapDetailPage() {
    _navigation.navigateTo(PersonalDetail);
  }

  void onTapDeliveryAddress() {
    _navigation.navigateTo(deliveryAddressScreenRoute);
  }

  void onTapMyOrder() {
    _navigation.navigateTo(MyOrdersScreenRoute);
  }

  void onTapWallet() {
    _navigation.navigateTo(WalletPageScreenRoute);
  }

  void onTapWishlist() {
    _navigation.navigateTo(WishlistScreenRoute);
  }

  void addNewAddress() {
    _navigation.navigateTo(addNewAddressScreenRoute);
  }

  void onTapSettings() {
    _navigation.navigateTo(settingsScreenRoute);
  }

  void changePassword() {
    _navigation.navigateTo(changePasswordScreenRoute);
  }

  void changeTransactionPIN() {
    _navigation.navigateTo(changeTransactionPINScreenRoute);
  }

  void notificationSetting() {
    _navigation.navigateTo(notificationSettingScreenRoute);
  }

  void closeAccount() {
    _navigation.navigateTo(deleteAccountScreenRoute);
  }

  void helpPage() {
    _navigation.navigateTo(helpScreenRoute);
  }

  void legalTerms() {
    _navigation.navigateTo(legalTermsScreenRoute);
  }

  void privacyPolicy() {
    _navigation.navigateTo(privacyPolicyScreenRoute);
  }

  void termsOfUse() {
    _navigation.navigateTo(termsOfUseScreenRoute);
  }

  void sellersPage() {
    _navigation.navigateTo(sellersPageScreenRoute);
  }

  void faqPage() {
    _navigation.navigateTo(FaqScreenRoute);
  }

  void negotiationPage() {
    _navigation.navigateTo(negotiationScreenRoute);
  }

  //
  late SignInResponse _currentUser;
  SignInResponse get currentUser => _currentUser;

  late AuthModel _token;
  AuthModel get token => _token;
  setFetchState(LoadingState value) {
    _fetchState = value;
    notifyListeners();
  }

  setLoadingState(LoadingState value) {
    _loadingState = value;
    notifyListeners();
  }

  // Handles Signup Page One
  String? _emailPhone = "Email Address";
  String? get emailPhone => _emailPhone;
  setEmailPhone(String value) {
    _emailPhone = value;
    print("Updated emailPhone to: $_emailPhone");
    notifyListeners();
  }

  final GlobalKey<FormState> formKeySignup = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController signInPhoneOrEmailController =
      TextEditingController(); //""test@gmail.com"
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController settingPasswordController = TextEditingController();

  // signUpWithEmailOrPhoneNumber
  final List<String> dropDownItems = [
    'Email Address',
    'Phone Number',
  ];

  // api calls
  String? signUpReference;
  // bool isEmail = true;
  String? username;
  String? mode;
  startRegistration() async {
    username = emailPhone == 'Email Address'
        ? emailController.text
        : phoneController.text;
    mode = emailPhone == 'Email Address' ? "email" : "phone";
    // username = isEmail ? emailController.text : phoneController.text;
    // mode = isEmail ? "email" : "phone";
    notifyListeners();
    setBusy(true);
    try {
      HTTPResponseModel result =
          await _authRepository.signup({"username": username, "mode": mode});
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        signUpReference = result.data["notification_reference"];
        notifyListeners();
        _navigation.navigateTo(
          verifyEmailorPasswordRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  verifyOtpCode() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verify({
        "otp": pinController.text,
        "reference_code": signUpReference,
        "sent_to": username,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        _navigation.navigateTo(
          setUpProfileRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController forgotOtpPinController = TextEditingController();
// function to help me detect the input for the mode selection//
  String detectModeFromInput(String input) {
    final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$");
    if (emailRegex.hasMatch(input.trim())) {
      return "email";
    } else {
      return "phone";
    }
  }

  String? forgotReference;
  sendForgotPassOTP() async {
    setBusy(true);
    try {
      final user = usernameController.text.trim();
      final mode = detectModeFromInput(user);
      HTTPResponseModel result = await _authRepository.sendForgotOtp({
        "mode": mode,
        "username": user,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        forgotReference = result.data["notification_reference"];
        _navigation.navigateTo(emailVerificationScreenRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  verifyForgotOtpCode() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.verifyForgot({
        "otp": forgotOtpPinController.text,
        "reference_code": forgotReference ?? "",
        "sent_to": usernameController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        _navigation.navigateTo(setNewPasswordRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  resetPassword(
    String password,
  ) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.resetPassword({
        "otp": forgotOtpPinController.text,
        "username": usernameController.text,
        "password": password,
        "password_confirmation": password
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        _navigation.navigateTo(successfulResetPageScreenRoute);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  bool acceptTerms = false;
  completeSignUp() async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.completeRegistration({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": username,
        "username": username,
        "password": passwordController.text,
        "accept_terms": acceptTerms,
        "password_confirmation": passwordController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);

        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  createCustomerAddress(
      String firstName,
      String lastName,
      String phoneNumber,
      String companyName,
      String buildingNumber,
      String streetAddress,
      String addressTitle,
      String city,
      String landMark,
      String state,
      String note,
      int defaultAddress) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.createAddress({
        "customer_id": currentUser.oldUserId,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phoneNumber,
        "company_name": companyName,
        "building_no": buildingNumber,
        "street_address": streetAddress,
        "address_title": addressTitle,
        "city": city,
        "landmark": landMark,
        "state": state,
        "default_address": 1,
        "note": note
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  getCustomerAddress() async {
    try {
      HTTPResponseModel result =
          await _authRepository.getCustomerAddress(currentUser.oldUserId);
      // print( currentUser.oldUserId);
      // print( currentUser.oldUserId);
      // print( currentUser.oldUserId);
      // print( currentUser.oldUserId);
      // print( currentUser.oldUserId);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        print(result.data);
        List<CustomerAddress> addressList = List<CustomerAddress>.from(
            result.data.map((item) => CustomerAddress.fromJson(item)));
        _addressList = addressList;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  getPickUpAddress() async {
    try {
      HTTPResponseModel result = await _authRepository.getPickUpAddress();
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        List<PickUpLocation> pickUpLocation = List<PickUpLocation>.from(
            result.data.map((item) => PickUpLocation.fromJson(item)));
        _pickUpAddress = pickUpLocation;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> getDefaultLocation() async {
    try {
      setBusy(true);
      if (_userPosition == null) {
        await getUserLocation();
      }
      if (_userPosition == null) {
        return false;
      }
      final lat = _userPosition!.latitude;
      final lng = _userPosition!.longitude;
      HTTPResponseModel result =
          await _authRepository.getDefaultLocation(lat, lng);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        final data = result.data;
        final address = data['address'];
        _currentLocationAddress = CustomerAddress(
          addressTitle: 'Current Location',
          address: address['village'] ?? '',
          city: address['city'] ?? '',
          state: address['state'] ?? '',
          landmark: '',
          defaultAddress: false,
        );

        notifyListeners();
        return true;
      } else {
        setBusy(false);
        return false;
      }
    } catch (e) {
      debugPrint('Error fetching default location: $e');
      setBusy(false);
      return false;
    }
  }

  logIn() async {
    // owoyemibusuyi@gmail.com
    // Busuyi@123
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.login({
        "username": signInPhoneOrEmailController.text,
        "password": signInPasswordController.text,
      });
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));

        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        return false;
      }
    } catch (e) {
      setBusy(false);
      print(e.toString());
      showErrorToast(message: e.toString());
      return false;
    }
  }

  String guestId = Uuid().v6().toString();
  loginAsAGuest() {
    SignInResponse user = SignInResponse();
    _currentUser = user;
    notifyListeners();
    _navigation.pushNamedAndRemoveUntil(
      bottomNavigationRoute,
    );
  }

// google signUp

  performServiceAuth(String idToken) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.loginProviders(idToken);
      // print(userData.identityToken);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));
        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        // if (result.code == 202) {
        //   debugPrint('User to sign up');
        //   showToast(
        //       message: 'Welcome ${userData.name}, kindly complete your profile');
        // }
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  performAppleLogin(String idToken) async {
    setBusy(true);
    try {
      HTTPResponseModel result = await _authRepository.loginApple(idToken);
      // print(userData.identityToken);
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        setBusy(false);
        showToast(message: result.all['message']);
        SignInResponse user = SignInResponse.fromJson(result.data['user']);
        _currentUser = user;
        final AuthModel auth = AuthModel.fromJson(result.data['token']);
        _token = auth;
        await StorageUtil.setData('token', auth.token);
        await StorageUtil.setData('profile', json.encode(user));
        _navigation.pushNamedAndRemoveUntil(
          bottomNavigationRoute,
        );
        return true;
      } else {
        setBusy(false);
        showErrorToast(message: result.all['message']);
        // if (result.code == 202) {
        //   debugPrint('User to sign up');
        //   showToast(
        //       message: 'Welcome ${userData.name}, kindly complete your profile');
        // }
        return false;
      }
    } catch (e) {
      setBusy(false);
      showErrorToast(message: e.toString());
      return false;
    }
  }

  banner() async {
    try {
      HTTPResponseModel result = await _authRepository.banner();
      if (HTTPResponseModel.isApiCallSuccess(result)) {
        List<BannerModel> packageList = List<BannerModel>.from(
            result.data.map((item) => BannerModel.fromJson(item)));
        _bannerList = packageList;
        notifyListeners();
      }
    } catch (e) {}
  }

  signInWithGoogle() async {
    GoogleSignInAuthentication? googleSignInAuthentication;
    GoogleSignInAccount? account;

    try {
      final GoogleSignIn googleSignIn;
      if (Platform.isIOS) {
        googleSignIn = await GoogleSignIn(
          clientId:
              "483222300106-3a7p1q7qfslscjvkul4ccfa5m90jcb2i.apps.googleusercontent.com",
        );
      } else {
        googleSignIn = await GoogleSignIn(
          serverClientId:
              "483222300106-9mbtmfplmnjevjnk6pe4eoo64c14jjce.apps.googleusercontent.com",
        );
      }
      // GoogleSignIn();

      try {
        account = await googleSignIn.signIn();
        print(account?.email);
        googleSignInAuthentication = await account?.authentication;
      } catch (e) {
        debugPrint('Error retrieving Google SignInAuthentication: $e');
        return null;
      }

      if (googleSignInAuthentication == null) {
        showErrorToast(message: 'Sign-in canceled by user.');
        return null;
      }

      try {
        if (googleSignInAuthentication.accessToken == null ||
            googleSignInAuthentication.idToken == null) {
          showErrorToast(
              message: 'Google authentication failed. Please try again.');
          return null;
        } else {
          // final User userCredential = auth.currentUser!;
          // user = userCredential;
          //
          // debugPrint('User: ${user.displayName}');
          // debugPrint('Email: ${user.email}');
          // debugPrint('UID: ${user.uid}');
        }
      } catch (e) {
        // Handle general errors
        debugPrint('Exception during Google Sign-In: $e');
        showErrorToast(
            message: 'Error occurred using Google Sign In. Please try again.');
      }

      return googleSignInAuthentication.accessToken;
    } catch (e) {
      // Handle errors during Google Sign-In initialization
      debugPrint('Error during Google Sign-In: $e');
      showErrorToast(
          message: 'Error occurred during sign-in process. Try again.');

      return null;
    }
  }

  processAppleSignUp() async {
    AuthorizationCredentialAppleID? user;
    try {
      //var user = await FirebaseService.signInWithGoogle(context: context);
      user = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: 'com.te_find.te_find',
          redirectUri:
              // For web your redirect URI needs to be the host of the "current page",
              // while for Android you will be using the API server that redirects back into your app via a deep link
              Uri.parse(
            'https://mighty-longing-machine.glitch.me/callbacks/sign_in_with_apple',
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      showErrorToast(message: 'Apple login failed. Please try again.');

      return;
    }
    // ignore: avoid_print
    debugPrint(user.toString());

    debugPrint("user.userIdentifier: ");
    debugPrint(user.userIdentifier);

    debugPrint("user.identityToken: ");
    debugPrint(user.identityToken);

    debugPrint("user.familyName: ");
    debugPrint(user.familyName);
    debugPrint("user.givenName: ");
    debugPrint(user.givenName);

    var firstName = user.givenName ?? '';
    var surname = user.familyName ?? '';
    var name = "$surname $firstName";

    //perform login

    performAppleLogin(user.identityToken ?? '');
  }

  processGoogleSignUp(String type) async {
    try {
      // Attempt to sign in with Google
      var id = await signInWithGoogle();
// print(user);
//       if (user == null) {
//         // If the user is null, show a failure message and exit
//         showErrorToast(message: 'Google login failed. Please try again.');
//         return;
//       }else {
//         // Create the service auth user object
//         var userData = ServiceAuthUser(
//           platform: 'Google',
//           email: user.email ?? '',
//           name: user.displayName ?? '',
//           phone: user.phoneNumber,
//           uid: user.uid,
//           pictureUrl: user.photoURL,
//         );

      // Proceed to perform the service authentication
      await performServiceAuth(id);
    } catch (e) {
      // Handle unexpected errors
      debugPrint('Error during Google Sign-Up: $e');
      showErrorToast(
          message: 'An unexpected error occurred. Please try again later.');
    }
  }

// login page validatiom
  bool get isFormValid {
    // Check if both email and pin are not empty
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

// pin and phone validation
  checkActive() {
    notifyListeners();
  }

// Carousal slider images
  final currentPageProvider = StateProvider<int>((ref) => 0);

  final List<Widget> myitems = [
    ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          Assets.slider,
          fit: BoxFit.cover,
        )),
  ];

  //Old ones
  String _destinationAddress = '';
  double? _destinationLat;
  double? _destinationLng;

  String get destinationAddress => _destinationAddress;
  double? get destinationLat => _destinationLat;
  double? get destinationLng => _destinationLng;

  setAddress(
    String address,
    double? lat,
    double? lng,
  ) {
    _destinationAddress = address;
    _destinationLat = lat;
    _destinationLng = lng;
    notifyListeners();
  }

  //
  // late SignInResponse _currentUser;
  // SignInResponse get currentUser => _currentUser;
  //
  // late AuthModel _token;
  // AuthModel get token => _token;

  late String _role;
  String get role => _role;

  bool isLoading = false;

  // Setters
  setRole(String value) async {
    _role = value;
    notifyListeners();
  }

  // Setters
  setLoading(bool value) async {
    isLoading = value;
    notifyListeners();
  }

  alreadyLoggedIn() async {
    var d = await StorageUtil.getData('profile');
    SignInResponse user = SignInResponse.fromJson(json.decode(d!));
    _currentUser = user;
    var t = await StorageUtil.getData('token');
    final AuthModel auth = AuthModel.fromJson(t!);
    _token = auth;
    _navigation.navigateReplacementTo(bottomNavigationRoute);
    return "Success";
  }

  Position? locationData;
  bool? _serviceEnabled;

  LocationPermission? _permissionGranted;

  // Position _userPosition = Position(
  //   longitude: 0.0, //3.8354081093539407,
  //   latitude: 0.0, //7.428901726059259,
  //   timestamp: DateTime.now(),
  //   accuracy: 0.0,
  //   altitude: 0.0,
  //   altitudeAccuracy: 0.0,
  //   heading: 0.0,
  //   headingAccuracy: 0.0,
  //   speed: 0.0,
  //   speedAccuracy: 0.0,
  // );
  // Position get userPosition => _userPosition;
  Position? _userPosition;
  Position? get userPosition => _userPosition;

  // getUserLocation() async {
  //   _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!_serviceEnabled!) {
  //     showToast(message: "Kindly make your location service enabled");
  //     if (!_serviceEnabled!) {}
  //   }
  //   _permissionGranted = await Geolocator.checkPermission();
  //   if (_permissionGranted == LocationPermission.denied) {
  //     _permissionGranted = await Geolocator.requestPermission();
  //   }
  //   locationData = await Geolocator.getCurrentPosition();
  //   _userPosition = locationData!;
  //   notifyListeners();
  // }
  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showToast(message: "Kindly enable location services");
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(message: "Location permission denied");
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        showToast(
            message: "Permission permanently denied. Enable it in settings.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _userPosition = position;
      notifyListeners();
    } catch (e) {
      debugPrint("Error getting location: $e");
      showToast(message: "Failed to get current location.");
    }
  }

  // sign up method
  final signUpMethodProvider = StateProvider<String>((ref) => '');
  // login

  // validate passwordcharacters

  bool criteria1Satisfied = false;
  bool criteria2Satisfied = false;
  bool hasUppercaseLetter = false;
  bool hasLowercaseLetter = false;
  bool hasNumber = false;
  bool hasSymbol = false;

  void validatePassword() {
    if (passwordController.text.length >= 8) {
      criteria1Satisfied = true;
      notifyListeners();
    } else {
      criteria1Satisfied = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
      hasUppercaseLetter = true;
      notifyListeners();
    } else {
      hasUppercaseLetter = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[a-z]'))) {
      hasLowercaseLetter = true;
      notifyListeners();
    } else {
      hasLowercaseLetter = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[0-9]'))) {
      hasNumber = true;
      notifyListeners();
    } else {
      hasNumber = false;
      notifyListeners();
    }

    if (passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSymbol = true;
      notifyListeners();
    } else {
      hasSymbol = false;
      notifyListeners();
    }

    if (hasUppercaseLetter && hasLowercaseLetter && hasNumber && hasSymbol) {
      criteria2Satisfied = true;
      notifyListeners();
    } else {
      criteria2Satisfied = false;
      notifyListeners();
    }
  }

  // for change password in settings
  void validatePassword2() {
    if (settingPasswordController.text.length >= 8) {
      criteria1Satisfied = true;
      notifyListeners();
    } else {
      criteria1Satisfied = false;
      notifyListeners();
    }

    if (settingPasswordController.text.contains(RegExp(r'[A-Z]'))) {
      hasUppercaseLetter = true;
      notifyListeners();
    } else {
      hasUppercaseLetter = false;
      notifyListeners();
    }

    if (settingPasswordController.text.contains(RegExp(r'[a-z]'))) {
      hasLowercaseLetter = true;
      notifyListeners();
    } else {
      hasLowercaseLetter = false;
      notifyListeners();
    }

    if (settingPasswordController.text.contains(RegExp(r'[0-9]'))) {
      hasNumber = true;
      notifyListeners();
    } else {
      hasNumber = false;
      notifyListeners();
    }

    if (settingPasswordController.text
        .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSymbol = true;
      notifyListeners();
    } else {
      hasSymbol = false;
      notifyListeners();
    }

    if (hasUppercaseLetter && hasLowercaseLetter && hasNumber && hasSymbol) {
      criteria2Satisfied = true;
      notifyListeners();
    } else {
      criteria2Satisfied = false;
      notifyListeners();
    }
  }
}

//
class ShowHideNotifier extends StateNotifier<bool> {
  ShowHideNotifier() : super(false);
  void toggle(bool isExpanded) {
    state = isExpanded;
  }
}

final showHideProvider = StateNotifierProvider<ShowHideNotifier, bool>((ref) {
  return ShowHideNotifier();
});
//
