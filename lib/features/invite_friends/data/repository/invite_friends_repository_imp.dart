import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/invite_friends/data/datasource/invite_friends_datasource.dart';
import 'package:dariwall/features/invite_friends/data/model/invite_friends_model.dart';
import 'package:dariwall/features/invite_friends/domain/repository/invite_friends_repository.dart';

class InviteFriendsRepositoryImp implements InviteFriendsRepository {
  final InviteFriendsDatasource datasource;

  InviteFriendsRepositoryImp({required this.datasource});

  @override
  Future<Either<AppException, InviteFriendsModel>> inviteFriends() async {
    try {
      final result = await datasource.inviteFriends();
      return Right(result);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
