import 'package:dio/dio.dart';
import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/user_account/data/model/change_account_info_model.dart';
import 'package:dariwall/features/user_account/data/model/user_account_model.dart';

class UserAccountDataSource {
  final ApiClientService apiClientService;

  UserAccountDataSource({required this.apiClientService});

  Future<UserAccountModel> getUserAccountInfo() async {
    final response = await apiClientService.get(
      AppApi.userAccountInfo,
    );
    return UserAccountModel.fromJson(response.data);
  }

  Future<void> changeAccountInfo(ChangeAccountInfoModel changeAccountInfoModel) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyName: changeAccountInfoModel.name,
        AppKeys.keySolanaWalletAddress: changeAccountInfoModel.solanaWalletAddress,
        AppKeys.keyImage: changeAccountInfoModel.accountImage != null
            ? await MultipartFile.fromFile(changeAccountInfoModel.accountImage!)
            : null,
      },
    );

    await apiClientService.patch(
      AppApi.changeAccountInfo,
      data: formData,
    );
  }
}
