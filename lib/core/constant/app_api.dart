class AppApi {
  AppApi._();

  // static const String baseUrl = 'https://dariwall.com/api/';
  static const String baseUrl = 'https://demo.dariwall.com/api/';

  // login
  static const String obtainPair = 'accounts/login/token/obtain-pair/';
  static const String refreshPair = 'accounts/login/token/refresh-pair/';
  static const String sendEmail = 'accounts/login/via-email/1/';
  static const String verifyCode = 'accounts/login/via-email/2/';

  // create wallet
  static const String createWallet = 'accounts/register/';

  // missions
  static const String studentInfo = 'missions/do-missions/01/';
  static const String followTwitter = 'missions/do-missions/02/';
  static const String likeTwitter = 'missions/do-missions/03/';
  static const String retweetTwitter = 'missions/do-missions/04/';
  static const String commentOnTwitter = 'missions/do-missions/05/';
  static const String joinTelegramChannel = 'missions/do-missions/06/';
  static const String joinDiscussionGroup = 'missions/do-missions/07/';
  static const String likeCoinmarketcap = 'missions/do-missions/08/';
  static const String likeCoinGecko = 'missions/do-missions/09/';
  static const String joinDariwallTelegramChannel = 'missions/do-missions/11/';
  static const String provinces = 'generics/provinces/';
  static const String missions = 'missions/my-missions/';

  // balances
  static const String balances = 'accounts/panel/my-balances/';

  // set email
  static const String sendEmailOtp = 'accounts/panel/set-email-address/1/';
  static const String verifyEmailOtp = 'accounts/panel/set-email-address/2/';

  // invite friends
  static const String inviteFriends = 'invitations/invites-sent/';

  // user account
  static const String userAccountInfo = 'accounts/panel/account-info/';
  static const String changeAccountInfo = 'accounts/panel/account-info/change/';

  // gift code
  static const String sendGiftCode = 'gifts/enter-code/';
  static const String verifyGiftCode = 'gifts/verify-code/';

  // my transactions
  static const String myTransactions = 'transactions/my-transactions/v2/';

  // withdraw
  static const String withdraw = 'transactions/do-transaction/withdraw/';

  // calculate fee
  static const String calculateFee = 'transactions/do-transaction/calculate-fee/';

  // currency price
  static const String currencyPrice = 'currencies/prices/';

  static const String confirmEmailAddress1 = 'accounts/register/confirm-email-address/1/';
  static const String confirmEmailAddress2 = 'accounts/register/confirm-email-address/2/';
  static const String universities = 'generics/universities/';
}
