import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dariwall/core/showroom/showroom_adapter.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';
import 'package:dariwall/features/login/data/model/account_info_model.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';

void main() {
  late Dio dio;
  setUp(() { dio = Dio(BaseOptions(baseUrl: 'https://showroom.invalid/api/'));
    dio.httpClientAdapter = ShowroomAdapter(); });
  tearDown(() => dio.close());
  test('synthetic fixtures parse through the real app models', () async {
    expect(MyBalancesModel.fromJson((await dio.get('accounts/panel/my-balances/')).data).balances!.length, 3);
    expect(AccountInfoModel.fromJson((await dio.get('accounts/panel/account-info/')).data).email, 'showroom@example.invalid');
    final missions = (await dio.get('missions/my-missions/')).data as List;
    expect(missions.map((e) => MissionModel.fromJson(e)).length, 4);
    final transactions = (await dio.get('transactions/my-transactions/v2/')).data as List;
    expect(TransactionsModel.fromJson(transactions.first).transactions.length, 1);
    expect(InviteFriendsModel.fromJson((await dio.get('invitations/invites-sent/')).data).count, 2);
  });
  test('wallet creation and financial operations fail closed without network', () async {
    for (final path in ['accounts/register/', 'transactions/do-transaction/send/', 'transactions/do-transaction/swap/']) {
      await expectLater(dio.post(path), throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 403)));
    }
    await expectLater(dio.get('unknown/'), throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 404)));
  });
  test('offline login requires the documented demo code', () async {
    await expectLater(dio.post('accounts/login/via-email/2/', data: {'code': '000000'}), throwsA(isA<DioException>()));
    final result = await dio.post('accounts/login/via-email/2/', data: {'code': '123456'});
    expect(result.data['access'], 'offline-showroom-session');
  });
}
