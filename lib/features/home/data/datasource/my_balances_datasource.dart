import 'dart:core';

import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/home/data/model/my_balances_model.dart';

class MyBalancesDatasource {
  final ApiClientService apiClientService;

  MyBalancesDatasource({required this.apiClientService});

  Future<MyBalancesModel> getMyBalances() async {
    final response = await apiClientService.get(AppApi.balances);
    return MyBalancesModel.fromJson(response.data);
  }
}
