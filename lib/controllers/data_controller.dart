import 'package:fact_flow/utils/common_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {

  var id = "".obs;
  var name = "".obs;
  var email = "".obs;
  var profileImage = "".obs;
  var phone = "".obs;
  var role = "".obs;
  var gender = "".obs;
  var avatar = "".obs;
  var balance = 0.obs;
  var subscriptionName = "".obs;

  var isVerified = false.obs;
  var isActive = false.obs;
  var isAdmin = false.obs;
  var isStripeConnected = false.obs;

  var createdAt = "".obs;
  var updatedAt = "".obs;

  late SharedPreferences preferences;

  // ---------------------------------------------------------------
  //                   LOAD USER DATA (Single Method)
  // ---------------------------------------------------------------
  Future<void> loadUserData() async {
    preferences = await SharedPreferences.getInstance();

    id.value = preferences.getString(CommonData.id) ?? "";
    name.value = preferences.getString(CommonData.name) ?? "";
    email.value = preferences.getString(CommonData.email) ?? "";
    profileImage.value = preferences.getString(CommonData.profileImage) ?? "";

    phone.value = preferences.getString(CommonData.phone) ?? "";
    role.value = preferences.getString(CommonData.role) ?? "";
    gender.value = preferences.getString(CommonData.gender) ?? "";
    avatar.value = preferences.getString(CommonData.avatar) ?? "";

    balance.value = preferences.getInt(CommonData.balance) ?? 0;
    subscriptionName.value =
        preferences.getString(CommonData.subscriptionName) ?? "";

    isVerified.value = preferences.getBool(CommonData.isVerified) ?? false;
    isActive.value = preferences.getBool(CommonData.isActive) ?? false;
    isAdmin.value = preferences.getBool(CommonData.isAdmin) ?? false;
    isStripeConnected.value =
        preferences.getBool(CommonData.isStripeConnected) ?? false;

    createdAt.value = preferences.getString(CommonData.createdAt) ?? "";
    updatedAt.value = preferences.getString(CommonData.updatedAt) ?? "";
  }

  // ---------------------------------------------------------------
  //                 SAVE ALL DATA FROM API LOGIN
  // ---------------------------------------------------------------
  Future<void> saveUserData(Map<String, dynamic> user) async {
    preferences = await SharedPreferences.getInstance();

    await preferences.setString(CommonData.id, user["id"].toString());
    await preferences.setString(CommonData.name, user["name"] ?? "");
    await preferences.setString(CommonData.email, user["email"] ?? "");
    await preferences.setString(
        CommonData.profileImage, user["avatar"] ?? "/images/placeholder.png");

    await preferences.setString(CommonData.phone, user["phone"] ?? "");
    await preferences.setString(CommonData.role, user["role"] ?? "");
    await preferences.setString(CommonData.gender, user["gender"] ?? "");

    await preferences.setString(CommonData.avatar, user["avatar"] ?? "");
    await preferences.setInt(CommonData.balance, user["balance"] ?? 0);
    await preferences.setString(CommonData.subscriptionName,
        user["subscription_name"] ?? "");

    await preferences.setBool(CommonData.isVerified, user["is_verified"] ?? false);
    await preferences.setBool(CommonData.isActive, user["is_active"] ?? false);
    await preferences.setBool(CommonData.isAdmin, user["is_admin"] ?? false);
    await preferences.setBool(
        CommonData.isStripeConnected, user["is_stripe_connected"] ?? false);

    await preferences.setString(CommonData.createdAt, user["created_at"] ?? "");
    await preferences.setString(CommonData.updatedAt, user["updated_at"] ?? "");

    await loadUserData(); 
  }

  // ---------------------------------------------------------------
  //                UPDATE PROFILE IMAGE ONLY
  // ---------------------------------------------------------------
  Future<void> updateProfileImage(String imageUrl) async {
    preferences = await SharedPreferences.getInstance();
    profileImage.value = imageUrl;
    preferences.setString(CommonData.profileImage, imageUrl);
  }

  // ---------------------------------------------------------------
  //                LOGOUT / CLEAR ALL DATA
  // ---------------------------------------------------------------
  Future<void> clearUserData() async {
    preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    loadUserData(); // reset values
  }
}
