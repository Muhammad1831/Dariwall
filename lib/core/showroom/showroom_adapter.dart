import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

/// Opt-in, offline transport for rendering the real app with synthetic data.
/// Never constructs a network client or delegates a request to the real API.
class ShowroomAdapter implements HttpClientAdapter {
  static const account = {
    'referralCode': 'DEMO-ONLY',
    'solanaWalletAddress': 'SHOWROOM-NOT-A-REAL-WALLET',
    'email': 'showroom@example.invalid',
    'name': 'کاربر آزمایشی',
    'accountImage': null,
  };

  static Map<String, dynamic> currency(String code, String fa) => {
    'currencyCode': code, 'currencyEnName': code, 'currencyFaName': fa,
    // Bundled brand image for demo tokens, never a remote market-data service.
    'currencyIcon': 'assets/images/logo.png',
  };

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    final path = options.uri.path.replaceFirst('/api/', '');
    dynamic data;
    int status = 200;
    if (path == 'accounts/login/via-email/1/' && options.method == 'POST') {
      data = {'secureToken': 'offline-showroom-only'};
    } else if (path == 'accounts/login/via-email/2/' && options.method == 'POST') {
      final body = options.data;
      if (body is! Map || body['code'] != '123456') {
        status = 400; data = {'detail': 'کد آزمایشی 123456 است.'};
      } else {
        data = {'access': 'offline-showroom-session', 'refresh': 'offline-showroom-refresh', 'accountInfo': account};
      }
    } else if (options.method != 'GET') {
      status = 403;
      data = {'detail': 'حالت نمایش فقط خواندنی است؛ عملیات مالی، ساخت کیف پول و تغییر حساب غیرفعال‌اند.'};
    } else if (path == 'accounts/panel/account-info/') {
      data = account;
    } else if (path == 'accounts/panel/my-balances/') {
      data = {
        'balances': [
          {'currencyInfo': currency('USDT', 'تتر'), 'amount': 120.0, 'valueUsd': 120.0, 'valueIrt': 7200000.0},
          {'currencyInfo': currency('SOL', 'سولانا'), 'amount': 2.0, 'valueUsd': 280.0, 'valueIrt': 16800000.0},
          {'currencyInfo': currency('OSTAD', 'استاد'), 'amount': 2500.0, 'valueUsd': 25.0, 'valueIrt': 1500000.0},
        ],
        'totalBalance': {'valueUsd': 425.0, 'valueIrt': 25500000.0},
      };
    } else if (path == 'currencies/prices/') {
      data = [
        {'currencyInfo': currency('USDT', 'تتر'), 'price': 1.0},
        {'currencyInfo': currency('SOL', 'سولانا'), 'price': 140.0},
        {'currencyInfo': currency('OSTAD', 'استاد'), 'price': 0.01},
      ];
    } else if (path == 'missions/my-missions/') {
      data = [
        for (final entry in [(1, 'اطلاعات دانشجویی'), (2, 'دنبال‌کردن شبکهٔ اجتماعی'), (6, 'عضویت در کانال'), (11, 'آشنایی با داری‌وال')])
          {'ruleCode': entry.$1, 'title': entry.$2, 'description': 'مأموریت آزمایشی؛ ارسال اطلاعات و دریافت پاداش غیرفعال است.', 'currencyInfo': currency('OSTAD', 'استاد'), 'amount': 100.0, 'mission': null},
      ];
    } else if (path == 'transactions/my-transactions/v2/') {
      data = [{
        'transactionDate': '۱۴۰۵/۰۷/۱۵', 'transactionDay': 'چهارشنبه',
        'transactions': [{
          'transactionType': 3, 'status': 2, 'createdAt': '۱۴۰۵/۰۷/۱۵ ۱۰:۳۰',
          'createdDay': 'چهارشنبه', 'updatedAt': '۱۴۰۵/۰۷/۱۵ ۱۰:۳۰', 'fee': 0.0,
          'description': 'واریز نمایشی؛ تراکنش واقعی نیست', 'account': 0,
          'currencyInfo': currency('USDT', 'تتر'), 'amount': 120.0, 'source': 1,
          'sourceAddress': 'DEMO-NOT-A-REAL-ADDRESS',
        }],
      }];
    } else if (path == 'invitations/invites-sent/') {
      data = {
        'invitedAccounts': [{'name': 'همراه آزمایشی یک', 'dateJoined': '۱۴۰۵/۰۷/۱۴'}, {'name': 'همراه آزمایشی دو', 'dateJoined': '۱۴۰۵/۰۷/۱۵'}],
        'count': 2, 'successfulCount': 1, 'nextInviteRewardUSDT': 1.0, 'totalReward': 1.0,
      };
    } else if (path == 'generics/provinces/') {
      data = [];
    } else {
      status = 404; data = {'detail': 'این بخش در نمایش آفلاین داده ندارد.'};
    }
    return ResponseBody.fromString(jsonEncode(data), status,
      headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
    );
  }

  @override
  void close({bool force = false}) {}
}
