class ApiSettings {
  //Auth Request
  static const String _BASE_URL = 'https://smart-store.mr-dev.tech/api/';
  static const String LOGIN = _BASE_URL + "auth/login";
  static const String LOGOUT = _BASE_URL + "auth/logout";
  static const String REGISTER = _BASE_URL + "auth/register";
  static const String RESET_PASSWORD = _BASE_URL + "auth/reset-password";
  static const String FORGET_PASSWORD = _BASE_URL + "auth/forget-password";
  static const String ACTIVATE_ACCOUNT = _BASE_URL + "auth/activate";
  static const String CHANGE_PASSWORD = _BASE_URL + "auth/change-password";
  static const String CONTACT_US = _BASE_URL + "contact-requests";
  static const String HOME = _BASE_URL + "home";
  static const String refresh_fcm_token = _BASE_URL + "/auth/refresh-fcm-token";

  //Cities Request
  static const String CITIES = _BASE_URL + "cities";

  //category Req && sub category
  static const String CATEGORY = _BASE_URL + "categories";

  //product request
  static const String PRODUCT = _BASE_URL + "sub-categories";
  static const String PRODUCT_DETAILS = _BASE_URL + "products";
  static const String FAVORITE_PRODUCT = _BASE_URL + "favorite-products";
  static const String RATTING_PRODUCT = _BASE_URL + "products/rate";

  //address
  static const String ADDRESS = _BASE_URL + "addresses";

  //card
  static const String CARD = _BASE_URL + "payment-cards";

  //order
  static const String ORDER = _BASE_URL + "orders";

}
