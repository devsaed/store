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

  //Cities Request
  static const String CITIES = _BASE_URL + "cities";

  //category Req && sub category
  static const String CATEGORY = _BASE_URL + "categories";

  //product re
  static const String PRODUCT = _BASE_URL + "sub-categories";

  //sub category





  // static const String _API_BASE_URL = _BASE_URL + '/api/';
  // static const String IMAGES_URL = _BASE_URL + '/images/';
  //
  // static const String GET_USERS = _API_BASE_URL + "users";

  // static const String REGISTER = _API_BASE_URL + "students/auth/register";


  // static const String TASK = _API_BASE_URL + "tasks";

}