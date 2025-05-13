import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';
import 'package:dariwall/features/invite_friends/domain/repository/invite_friends_repository.dart';

class InviteFriendsUsecase {
  final InviteFriendsRepository repository;

  InviteFriendsUsecase({required this.repository});

  Future<Either<AppException, InviteFriendsModel>> call() async {
    return await repository.inviteFriends();
  }
}
