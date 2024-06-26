class Api {
  // static const String serverIp = "http://10.10.69.200:8000";
  static const String serverIp = "http://192.168.137.1:8000";

  static const String urlImage = "$serverIp/api/image";
  
  static const String urlLogin = "$serverIp/api/login";
  static const String urlContinueGoogle = "$serverIp/api/continuegoogle";
  static const String urlRegister = "$serverIp/api/register";
  static const String urlUpdateUser = "$serverIp/api/update_user";
  static const String urlUpdatePassword = "$serverIp/api/update_password";
  static const String urlUserList = "$serverIp/api/getalluser";
  static const String urlSendCode = "$serverIp/api/sendCode";
  static const String urlvalidateCode = "$serverIp/api/validateCode";
  static const String urlResetPassword = "$serverIp/api/resetPassword";

  static const String urlEvent = "$serverIp/api/event";
  static const String urlEventIsEnrolled = "$serverIp/api/event/isEnrolled";
  static const String urlEventGet = "$serverIp/api/event/getEvent";
  static const String urlEventBooth = "$serverIp/api/event/getBooth";
  static const String urlEventBoothTotal = "$serverIp/api/event/getBoothTotal";
  static const String urlEventBoothAvailable = "$serverIp/api/event/getBoothAvailable";
  static const String urlEventHarga = "$serverIp/api/event/getBoothRange";

  static const String urlOrder = "$serverIp/api/order/getOrder";
  static const String urlOrderMake = "$serverIp/api/order/makeOrder";
  static const String urlOrderBayar = "$serverIp/api/order/uploadBayar";
  static const String urlOrderCount = "$serverIp/api/order/getCountOrder";


}
