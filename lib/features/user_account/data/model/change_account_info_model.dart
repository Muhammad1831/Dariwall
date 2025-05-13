import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/features/login/domain/entity/account_info_entity.dart';

class ChangeAccountInfoModel extends AccountInfoEntity {
  ChangeAccountInfoModel({
    super.name,
    super.userImage,
    super.solanaWalletAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      AppKeys.keyName: name,
      AppKeys.keyImage: userImage,
      AppKeys.keySolanaWalletAddress: solanaWalletAddress,
    };
  }

  factory ChangeAccountInfoModel.fromEntity(AccountInfoEntity entity) {
    return ChangeAccountInfoModel(
      name: entity.name,
      userImage: entity.userImage,
      solanaWalletAddress: entity.solanaWalletAddress,
    );
  }
}
