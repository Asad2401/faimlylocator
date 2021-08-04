import 'package:flutter/material.dart';
import 'package:pak_lpg/size_config.dart';
import 'package:intl/intl.dart';

// list of colors that we use in our app
//const kBackgroundColor = Color(0xFFF1EFF1);
const kBackgroundColor = Color(0xFFFFFFFF);
const kBlueColor = Color(0xFF40BAD5);

const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kPrimaryColor1 = Color(0xFF008122);
//const kPrimaryColor = Color(0xFF008269);
const kPrimaryColor = Color(0xFF40BAD5);

const kDefaultPadding = 20.0;
const kCompanyName = "My Family Locator";
// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);
const defaultDuration = Duration(milliseconds: 250);
const String base_url = "https://ayanenergyapps.com/management/api/exposeAPI/";
const kBaseUrl = "https://ayanenergyapps.com/management/managmentapi/";
const kBaseUrl2 = "https://ayanenergyapps.com/management/api/exposeAPI/";
const locationInterval = 200;
//https://www.biitsolutions.co.uk/ayan_energy/api/exposeAPI/login_customer.php?email=warraich_traders@gmail.com&password=123456
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kERPlNullError = "Please Enter your first name";
const String kContactlNullError = "Please Enter your contact number";
const String kENameNullError = "Please Enter your last name.";
const String kEBankNameNullError = "Please Enter Bank Name.";
const String kEBankAmountNullError = "Please Enter Amount.";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
enum ReloadChoice {

  RELOAD,
  RELOAD_FROM_SERVER
}
final oCcy = new NumberFormat("#,##0.00", "en_US");
