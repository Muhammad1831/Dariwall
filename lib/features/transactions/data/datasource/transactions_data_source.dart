import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/transactions/data/model/transactions_model.dart';

class TransactionsDataSource {
  final ApiClientService apiClientService;

  TransactionsDataSource({required this.apiClientService});

  Future<List<TransactionsModel>> getTransactions() async {
    final response = await apiClientService.get(AppApi.myTransactions);

    final List<dynamic>? data = response.data as List?;

    if (data == null) {
      return [];
    }

    return data.map((e) => TransactionsModel.fromJson(e)).toList();
  }
}
