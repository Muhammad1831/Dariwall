abstract class AppMessage {
  static const String networkError = 'اتصال اینترنت خود را بررسی کنید';
  static const String serverError = 'خطای سرور لطفاً بعداً دوباره تلاش کنید';
  static const String authError = 'اطلاعات ورودی نادرست است';
  static const String tryAgain = 'دوباره تلاش کنید';
  static const String unknownError = 'مشکلی رخ داده است';
  static const String tooManyRequests =
      'تعداد درخواست‌های شما بیش از حد مجاز است. لطفاً کمی صبر کنید';
  static const String invalidInput = 'اطلاعات ورودی نامعتبر است';
  static const String unauthorizedError = 'ورود ناموفق بود';

  static const String copiedPasswords = 'رمز‌های بازیابی کپی شد';
  static const String copiedReferralCode = 'کد معرف کپی شد';
  static const String passwordNotMatch = 'رمز‌ها مطابقت ندارند';

  static const String errorInFetchingData = 'خطا در دریافت اطلاعات';
  static const String loadingData = 'در حال دریافت اطلاعات...';
  static const String noDataFound = 'اطلاعاتی یافت نشد';

  static const String logoutError = 'خروج از حساب کاربری با خطا مواجه شد';
  static const String logoutSuccess = 'خروج از حساب کاربری با موفقیت انجام شد';
  static const String loginSuccess = 'ورود با موفقیت انجام شد';
  static const String loginError = 'ورود با خطا مواجه شد';
  static const String emailVerificationCodeSent = 'کد تایید به ایمیل شما ارسال شد';
  static const String allFieldsAreRequired = 'همه فیلد‌ها باید پر شوند';

  static const String fileSizeShouldBeLessThan4MB = 'حجم فایل باید کمتر از 4 مگابایت باشد';
  static const String missionSuccess = 'ماموریت با موفقیت انجام شد';

  // student info mission
  static const String fullNameIsRequired = 'نام و نام‌خانوادگی وارد نشده است';
  static const String studentNumberIsRequired = 'شماره‌ی دانشجویی وارد نشده است';
  static const String universityIsRequired = 'دانشگاه وارد نشده است';
  static const String provinceIsRequired = 'استان محل تحصیل انتخاب نشده است';
  static const String phoneNumberIsRequired = 'شماره‌ی تلفن وارد نشده است';
  static const String imageIsRequired = 'تصویر کارت دانشجویی بارگذاری نشده است';

  // create wallet
  static const String userNameIsRequired = 'نام کاربری وارد نشده است';

  // connect wallet to email
  static const String emailIsRequired = 'ایمیل وارد نشده است';

  // change solana address wallet
  static const String solanaAddressWalletChangedSuccessfully =
      'آدرس کیف پول سولانا با موفقیت تغییر کرد';

  // change user account info
  static const String userEmailChangedSuccessfully = 'ایمیل با موفقیت تغییر کرد';
  static const String userImageChangedSuccessfully = 'تصویر کاربری با موفقیت تغییر کرد';
  static const String userNameChangedSuccessfully = 'نام کاربری با موفقیت تغییر کرد';

  // gift code
  static const String giftCodeAppliedSuccessfully = 'کد هدیه با موفقیت اعمال شد';

  // send
  static const String solanaWalletAddressIsNotSet = 'آدرس کیف پول سولانا تنظیم نشده است';
  static const String sendSuccess = 'ارسال با موفقیت انجام شد';
  static const String amountMustBeGreaterThanZero = 'مبلغ باید بیشتر از صفر باشد';

  // refresh
  static const String pullToRefresh = 'برای بروزرسانی بکشید';
  static const String releaseToRefresh = 'رها کنید';
  static const String refreshing = 'در حال بروزرسانی...';
  static const String refreshCompleted = 'بروزرسانی با موفقیت انجام شد';

  // image picker
  static const String pickImageError = 'خطا در انتخاب تصویر';
}
