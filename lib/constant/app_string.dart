abstract class AppString {
  AppString._();

  static const String ostad = 'OSTAD';
  static const String enterUserAccount = 'ورود به حساب کاربری';
  static const String phoneNumber = 'شماره تلفن همراه';
  static const String password = 'رمز عبور';
  static const String enterInAccount = 'ورود به حساب';
  static const String forgotPassword = 'فراموشی رمز عبور';
  static const String dontHaveAccount = 'حساب کاربری ندارید؟';
  static const String createAccount = 'ایجاد حساب';
  static const String passHint = '********';
  static const String phoneHint = '1122***0918';
  static const String enterPhoneNumber = 'شماره موبایل خود را وارد کنید.';
  static const String enterValidPhoneNumber = 'شماره موبایل وارد شده معتبر نمی باشد.';
  static const String enterEmail = 'ایمیل خود را وارد کنید.';
  static const String enterValidEmail = 'ایمیل وارد شده معتبر نمی باشد.';
  static const String enterPassword = 'رمز عبور را وارد کنید.';
  static const String enterRepeatPassword = 'تکرار رمز عبور را وارد کنید.';
  static const String passwordMustContainLettersAndNumbersAndSpecialCharacter =
      'رمز عبور باید شامل حروف بزرگ و کوچک، اعداد و حداقل یک کاراکتر خاص (@, #, !, ...) باشد.';
  static const String enterUserName = 'نام کاربری خود را وارد کنید';
  static const String thisFieldMustNotBeEmpty = 'این فیلد نمی‌تواند خالی باشد';

  static String minimumCharacterPassword(int length) => 'رمز عبور باید حداقل $length کاراکتر باشد.';
}
