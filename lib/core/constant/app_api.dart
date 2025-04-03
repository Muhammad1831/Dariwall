class AppApi {
  AppApi._();

  static const String baseUrl = 'https://dariwall.com/api/';

  // login
  static const String login = 'users/login/';
  static const String loginRenew = 'users/login/renew/';
  static const String retrieveWallet = 'users/login/retrieve-wallet/';

  // register
  static const String confirmPhoneNumber1 = 'users/register/confirm-phone-number/1/';
  static const String confirmPhoneNumber2 = 'users/register/confirm-phone-number/2/';
  static const String setPassword = 'users/register/set-password/';

  
  static const String register = 'accounts/register/';
  static const String confirmEmailAddress1 = 'accounts/register/confirm-email-address/1/';
  static const String confirmEmailAddress2 = 'accounts/register/confirm-email-address/2/';
  static const String provinces = 'generics/provinces/';
  static const String universities = 'generics/universities/';
}
