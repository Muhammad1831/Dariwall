abstract class AppString {
  AppString._();

  static const String ostad = 'OSTAD';
  static const String enterUserAccount = 'ورود به حساب کاربری';
  static const String phoneNumber = 'شماره تلفن همراه';
  static const String password = 'رمز عبور';
  static const String repeatPassword = 'تکرار رمز عبور';
  static const String newPassword = 'رمز عبور جدید';
  static const String newRepeatPassword = 'تکرار رمز عبور جدید';
  static const String enterInAccount = 'ورود به حساب';
  static const String forgotPassword = 'فراموشی رمز عبور';
  static const String dontHaveAccount = 'حساب کاربری ندارید؟';
  static const String createAccount = 'ایجاد حساب';
  static const String passHint = '********';
  static const String phoneHint = '1122***0918';
  static const String emailHint = 'example@gmail.com';
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

  static const String createUserAccount = 'ایجاد حساب کاربری';
  static const String back = 'بازگشت';
  static const String info = 'اطلاعات';
  static const String referrer = 'معرف';
  static const String validation = 'اعتبارسنجی';
  static const String upload = 'بارگذاری';
  static const String basicInfo = 'اطلاعات پایه';
  static const String additionalInfo = 'اطلاعات تکمیلی';
  static const String name = 'نام';
  static const String lastName = 'نام خانوادگی';
  static const String sex = 'جنسیت';
  static const String province = 'استان محل تحصیل';
  static const String university = 'دانشگاه';
  static const String studentNumber = 'شماره دانشجویی';
  static const String telegramId = 'آیدی تلگرام';
  static const String solanaAddressWallet = 'آدرس کیف پول سولانا';
  static const String enterYourName = 'نام  را وارد کنید...';
  static const String enterYourLastName = 'نام خانوادگی را وارد کنید...';
  static const String male = 'مذکر';
  static const String female = 'مونث';
  static const String selectProvince = 'استان محل تحصیل را انتخاب کنید...';
  static const String selectUniversity = 'دانشگاهی که درآن تحصیل می کنید...';
  static const String enterStudentNumber = 'شماره دانشجویی را وارد کنید...';
  static const String enterTelegramId = 'user123456';
  static const String enterSolanaAddressWallet = 'آدرس کیف پول سولانا را وارد کنید...';
  static const String mustUsePhantomWallet = 'حتما از کیف پول Phantom استفاده کنید.';
  static const String continueText = 'ادامه';
  static const String referrerPhoneNumber = 'شماره موبایل معرف';
  static const String referrerHintText = '09123456789';
  static const String referrerOptionalText1 =
      '(اختیاری) اگر کسی شما را معرفی کرده است، شماره موبایل او را وارد کنید.';
  static const String referrerOptionalText2 = 'اگر معرف ندارید، می توانید از این مرحله عبور کنید.';
  static const String dontHaveReferrer = 'معرف ندارم';
  static const String enterYourEmailForVerification =
      'لطفاً ایمیل خود را وارد کنید. کد اعتبارسنجی به ایمیل شما ارسال خواهد شد. با وارد کردن این کد، فرایند اعتبارسنجی را تکمیل کنید.';
  static const String email = 'ایمیل';
  static const String completValidationProcess = 'تکمیل فرآیند اعتبارسنجی';
  static const String checkYourEmail =
      'لطفاً ایمیل خود را بررسی کنید و کد ارسال شده را در کادر زیر وارد کنید تا فرایند اعتبارسنجی شما تکمیل شود.';
  static String codeSentToEmail(String email) => 'کد به $email ارسال شد.';
  static const String codeNotSent = 'کد ارسال نشده است؟';
  static const String sentCodeAgain = 'ارسال مجدد کد';
  static const String minimumPasswordCharacter = 'رمز عبور باید حداقل ۸ کاراکتر داشته باشد.';
  static const String dontUseSimplePassword =
      'از نام، تاریخ تولد، شماره تلفن یا کلمات ساده مانند "123456" یا "password" استفاده نشود.';
  static const String useUperLowerSpecialSign =
      'از حروف کوچک و بزرگ و علائم نشانه گذاری(%#\$*&) استفاده شود.';
  static const String noDocumentUploaded = 'در حال حاضر مدرکی بارگزاری نشده است.';
  static const String uploadImage = 'بارگزاری تصویر';
  static const String uploadImages = 'بارگزاری تصاویر';
  static const String uploadNewImage = 'بارگزاری تصویر جدید';
  static const String imageUploadedSuccessfuly = 'تصویر با موفقیت بارگزاری شد.';
  static const String confirm = 'تایید';
  static const String home = 'خانه';
  static const String account = 'حساب کاربری';
  static const String priceInfo = 'اطلاع قیمت';
  static const String wallet = 'کیف پول';
  static const String learnAndGuide = 'آموزش و راهنما';
  static const String logout = 'خروج از حساب کاربری';
  static const String totalBalance = 'موجودی کل';
  static const String toman = 'تومان';
  static const String buy = 'خرید';
  static const String sell = 'فروش';
  static const String sharePurchase = 'سهم خریداری شده';
  static const String giftAndReward = 'پاداش و جوایز';
  static const String reward = 'پاداش';
  static const String downloadAndCreatePhantomWallet = 'دانلود و ایجاد کیف پول فانتوم';
  static const String downloadPhantomWallet = 'آدرس دانلود از گوگل پلی(بدون نیاز به فیلترشکن)';
  static const String firstDownloadAndCreatePhantomWallet =
      'ابتدا کیف پول فانتوم (Phantom Wallet) را دانلود و نصب کنید.';
  static const String afterDownloadAndCreatePhantomWallet =
      'پس از نصب، یک کیف پول جدید ایجاد کنید یا اگر از قبل حساب دارید، وارد کیف پول خود شوید.';
  static const String confirmYourAccount = 'مطمئن شوید که اطلاعات حساب کاربری شما تایید شده باشد.';
  static const String doneMission = 'انجام ماموریت‌ها(پاداش و جوایز)';
  static const String goToMission = 'به بخش ماموریت‌ها مراجعه کنید.';
  static const String doTheTasks = 'کارهای خواسته شده در ماموریت‌ها را انجام دهید.';
  static const String uploadTheImage =
      'پس از انجام هر ماموریت، تصویر مربوط به آن را بارگذاری کنید.';
  static const String viewAndDoMission = 'مشاهده و انجام مأموریت‌ها';
  static const String waitingForConfirmation = 'انتظار برای تایید';
  static const String afterUploadingTheImages =
      'پس از بارگذاری تصاویر، منتظر بمانید تا ماموریت‌ها و احراز هویت شما توسط تیم ما تایید شود.';
  static const String thisProcessCanTakeUpTo48Hours = 'این فرآیند ممکن است تا ۴۸ ساعت زمان ببرد.';
  static const String receiveReward = 'دریافت جایزه';
  static const String afterConfirmation =
      'پس از تایید، حساب سولانای کیف پول شما به مبلغ ۱۰ دلار شارژ خواهد شد.';
  static const String convertToOstadToken =
      'این سولانا را می‌توانید به توکن استاد شجریان تبدیل کنید.';
  static const String buyTokenAndGetLicense = 'خرید توکن و دریافت مجوز';
  static const String afterConvertSolanaToOstadToken =
      'پس از تبدیل سولانا به توکن استاد شجریان، تصویر خرید خود را بارگذاری کنید.';
  static const String afterUploadingTheImage =
      'با انجام این کار، مجوز شرکت در رویدادهای بعدی را دریافت خواهید کرد.';
  static const String participateInEvents = 'شرکت در رویدادها';
  static const String participateInEventsDescription =
      'برای اطلاع از رویدادهای جدید، به صفحه اطلاعیه‌ها در اپلیکیشن یا کانال تلگرامی هواداران استاد شجریان مراجعه کنید.';
  static const String beforeStarting =
      'قبل از شروع، تمام مراحل را با دقت مطالعه کنید و سپس اقدامات را به درستی انجام دهید.';
  static const String followOstadInX = 'دنبال کردن OSTAD در  X';
  static const String steps = 'مراحل';
  static const String followOstadInXDescription = '۱. OSTAD رو در X دنبال کنید:';
  static const String likeAndRepostPost = '2. پست مربوط به آدرس CA رو لایک، ریپلای و ریتوییت کنید:';
  static const String uploadImagesFromEachStep = '3. بارگزاری تصاویر از هر مرحله';
  static const String uploadImagesFromEachStepDescription =
      'لطفاً از تمامی کارهایی که انجام می‌دهید، اسکرین‌شات بگیرید و برای ما ارسال کنید. این اسکرین‌شات‌ها به عنوان مدرک انجام ماموریت‌ها استفاده خواهند شد.';
  static const String clickOnFollowButton =
      'بعد از ورود به صفحه توییتر، روی دکمه "Follow" (دنبال کردن) کلیک کنید.';
  static const String afterEnterPost = ' بعد از ورود به پست:';
  static const String onLikeButton = 'روی دکمه لایک';
  static const String click = 'بزنید';
  static const String aComment = 'یک کامنت';
  static const String write = 'بنویسید';
  static const String onRetweetButton = 'روی دکمه ریتوییت';
  static const String clickAndChooseRetweet = 'کلیک کنید و گزینه Retweet را انتخاب کنید';
  static const String startParantse = ' (';
  static const String endParantse = ') ';
  static const String seeImagesUploaded = 'مشاهده تصاویر بارگزاری شده';
  static const String send = 'ارسال';
  static const String likeCoinmarketcapDescription = '1. وارد لینک زیر شوید و رای خود را مشابه تصویر زیر ثبت کنید:';
  static const String voteForOstadInCoinMarketCap = 'رای دادن به استاد در CoinMarketCap';
  static const String vote = 'رای دادن';
}
