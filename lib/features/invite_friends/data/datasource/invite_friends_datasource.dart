import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';

class InviteFriendsDatasource {
  final ApiClientService apiClientService;

  InviteFriendsDatasource({required this.apiClientService});

  Future<InviteFriendsModel> inviteFriends() async {
    final response = await apiClientService.get(
      AppApi.inviteFriends,
    );
    return InviteFriendsModel.fromJson(response.data);
  }
}
