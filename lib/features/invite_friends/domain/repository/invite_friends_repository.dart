import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';

abstract class InviteFriendsRepository {
  Future<Either<AppException, InviteFriendsModel>> inviteFriends();
}
