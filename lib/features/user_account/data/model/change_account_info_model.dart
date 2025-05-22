import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';

class ChangeAccountInfoModel extends AccountInfoEntity {
  ChangeAccountInfoModel({
    super.name,
    super.accountImage,
    super.solanaWalletAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyName: name,
      AppKeys.keyImage: accountImage,
      AppKeys.keySolanaWalletAddress: solanaWalletAddress,
    };
  }

  factory ChangeAccountInfoModel.fromEntity(AccountInfoEntity entity) {
    return ChangeAccountInfoModel(
      name: entity.name,
      accountImage: entity.accountImage,
      solanaWalletAddress: entity.solanaWalletAddress,
    );
  }
}
