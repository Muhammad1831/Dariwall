import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/features/missions/data/datasource/parax_missions_data_source.dart';
import 'package:dariwall/features/missions/data/repository/parax_missions_repository_imp.dart';
import 'package:dariwall/features/missions/domain/repository/parax_missions_repository.dart';
import 'package:dariwall/features/missions/domain/usecase/parax_usecase/check_join_parax_telegram_channel_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/parax_usecase/follow_parax_in_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/parax_usecase/like_parax_in_coinmarketcap_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/parax_usecase/retweet_parax_twitter_post_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/check_join_parax_telegram_channel_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/follow_parax_in_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/like_parax_in_coinmarketcap_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/parax_provider/retweet_parax_twitter_post_mission_provider.dart';
import 'package:dariwall/features/send/data/datasource/transfer_data_source.dart';
import 'package:dariwall/features/send/data/repository/transfer_repository_imp.dart';
import 'package:dariwall/features/send/domain/repository/transfer_repository.dart';
import 'package:dariwall/features/send/domain/usecase/transfer_usecase.dart';
import 'package:dariwall/features/send/presentation/provider/transfer_provider.dart';
import 'package:dariwall/features/swap/data/datasource/swap_data_source.dart';
import 'package:dariwall/features/swap/data/repository/swap_repository_imp.dart';
import 'package:dariwall/features/swap/domain/repository/swap_repository.dart';
import 'package:dariwall/features/swap/domain/usecase/swap_usecase.dart';
import 'package:dariwall/features/swap/presentation/provider/swap_provider.dart';
import 'package:dariwall/features/user_account_info_edit/data/datasource/set_email_data_source.dart';
import 'package:dariwall/features/user_account_info_edit/data/repository/set_email_repository_imp.dart';
import 'package:dariwall/features/user_account_info_edit/domain/repository/set_email_repository.dart';
import 'package:dariwall/features/user_account_info_edit/domain/usecase/set_email_usecase.dart';
import 'package:dariwall/features/user_account_info_edit/domain/usecase/verify_email_usecase.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/set_email_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/verify_email_provider.dart';
import 'package:dariwall/global_provider/data/datasource/calculate_fee_data_source.dart';
import 'package:dariwall/global_provider/data/datasource/calculate_source_target_value_data_source.dart';
import 'package:dariwall/global_provider/data/repository/calculate_fee_repository_imp.dart';
import 'package:dariwall/global_provider/data/repository/calculate_source_target_value_repository_imp.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_fee_repository.dart';
import 'package:dariwall/global_provider/domain/repository/calculate_source_target_value_repository.dart';
import 'package:dariwall/global_provider/domain/usecase/calculate_fee_usecase.dart';
import 'package:dariwall/global_provider/domain/usecase/calculate_source_target_value_usecase.dart';
import 'package:dariwall/global_provider/providers/calculate_fee_provider.dart';
import 'package:dariwall/global_provider/providers/calculate_source_target_value_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:dariwall/features/connet_wallet_to_email/data/datasource/connect_wallet_email_datasource.dart';
import 'package:dariwall/features/connet_wallet_to_email/data/repository/connect_wallet_email_repository_imp.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/repository/connect_wallet_email_repository.dart';
import 'package:dariwall/features/connet_wallet_to_email/domain/usecase/connect_wallet_email_usecase.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/providers/connect_wallet_email_otp_provider.dart';
import 'package:dariwall/features/connet_wallet_to_email/presentation/providers/connect_wallet_email_provider.dart';
import 'package:dariwall/features/create_new_wallet/domain/repository/create_wallet_repository.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/features/gift_code_page/data/datasource/gift_code_data_source.dart';
import 'package:dariwall/features/gift_code_page/data/repository/gift_code_repository_imp.dart';
import 'package:dariwall/features/gift_code_page/domain/repository/gift_code_repository.dart';
import 'package:dariwall/features/gift_code_page/domain/usecase/send_gift_code_usecase.dart';
import 'package:dariwall/features/gift_code_page/domain/usecase/verify_gift_code_usecase.dart';
import 'package:dariwall/features/gift_code_page/presentation/provider/send_gift_code_provider.dart';
import 'package:dariwall/features/gift_code_page/presentation/provider/verify_gift_code_provider.dart';
import 'package:dariwall/features/home/data/datasource/my_balances_datasource.dart';
import 'package:dariwall/features/home/data/repository/my_balances_repository_imp.dart';
import 'package:dariwall/features/home/domain/repository/my_balances_repository.dart';
import 'package:dariwall/features/home/domain/usecase/my_balances_usecase.dart';
import 'package:dariwall/features/home/presentation/provider/my_balances_provider.dart';
import 'package:dariwall/features/home/presentation/provider/show_in_currency_provider.dart';
import 'package:dariwall/features/invite_friends/data/datasource/invite_friends_datasource.dart';
import 'package:dariwall/features/invite_friends/data/repository/invite_friends_repository_imp.dart';
import 'package:dariwall/features/invite_friends/domain/repository/invite_friends_repository.dart';
import 'package:dariwall/features/invite_friends/domain/usecase/invite_friends_usecase.dart';
import 'package:dariwall/features/invite_friends/presentaion/provider/invite_friends_provider.dart';
import 'package:dariwall/features/login/data/datasource/login_data_source.dart';
import 'package:dariwall/features/login/data/repository/login_repository_imp.dart';
import 'package:dariwall/features/login/domain/repository/login_repository.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_email_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/login_with_keys_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/logout_usecase.dart';
import 'package:dariwall/features/login/domain/usecase/verify_email_code_usecase.dart';
import 'package:dariwall/features/login/presentation/provider/login_provider.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/core/utils/utils_shared_preferences.dart';
import 'package:dariwall/features/create_new_wallet/data/datasource/create_wallet_datasource.dart';
import 'package:dariwall/features/create_new_wallet/data/repository/create_wallet_repository_imp.dart';
import 'package:dariwall/features/create_new_wallet/domain/usecase/create_wallet_usecase.dart';
import 'package:dariwall/features/create_new_wallet/presentation/provider/create_wallet_provider.dart';
import 'package:dariwall/features/login/domain/usecase/check_login_usecase.dart';
import 'package:dariwall/features/missions/data/datasource/ostad_missions_data_source.dart';
import 'package:dariwall/features/missions/data/repository/missions_repository_imp.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/comment_on_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/follow_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/get_missions_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/get_province_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/join_dariwall_telegram_channel_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/join_discussion_group_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/join_telegram_channel_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/like_coinmarketcap_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/like_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/retweet_twitter_mission_usecase.dart';
import 'package:dariwall/features/missions/domain/usecase/ostad_usecase/student_info_mission_usecase.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/comment_on_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/follow_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_provinece_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/join_dariwall_telegram_channel_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/join_discussion_group_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/join_telegram_channel_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/like_coinmarketcap_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/like_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/retweet_twitter_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/student_info_mission_provider.dart';
import 'package:dariwall/features/transactions/data/datasource/transactions_data_source.dart';
import 'package:dariwall/features/transactions/data/repository/transactions_repository_imp.dart';
import 'package:dariwall/features/transactions/domain/repository/transactions_repository.dart';
import 'package:dariwall/features/transactions/domain/usecase/transactions_usecase.dart';
import 'package:dariwall/features/transactions/presentation/provider/transactions_provider.dart';
import 'package:dariwall/features/send/data/datasource/withdraw_data_source.dart';
import 'package:dariwall/features/send/data/repository/withdraw_repository_imp.dart';
import 'package:dariwall/features/send/domain/repository/withdraw_repository.dart';
import 'package:dariwall/features/send/domain/usecase/withdraw_usecase.dart';
import 'package:dariwall/features/send/presentation/provider/withdraw_provider.dart';
import 'package:dariwall/features/solana_address_wallet/presentation/provider/solana_address_wallet_provider.dart';
import 'package:dariwall/features/user_account/data/datasource/user_account_data_source.dart';
import 'package:dariwall/features/user_account/data/repository/user_account_repository_imp.dart';
import 'package:dariwall/features/user_account/domain/repository/user_account_repository.dart';
import 'package:dariwall/features/user_account/domain/usecase/change_user_account_usecase.dart';
import 'package:dariwall/features/user_account/domain/usecase/get_user_account_usecase.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/change_user_account_image_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/change_user_account_name_provider.dart';
import 'package:dariwall/global_provider/data/datasource/currency_prices_data_source.dart';
import 'package:dariwall/global_provider/data/repository/currency_prices_repository_imp.dart';
import 'package:dariwall/global_provider/domain/repository/currency_prices_repository.dart';
import 'package:dariwall/global_provider/domain/usecase/currency_prices_usecase.dart';
import 'package:dariwall/global_provider/providers/currency_prices_provider.dart';

final getIt = GetIt.instance;

class LocatorService {
  static Future<void> init() async {
    // Register the LocalStorageService as a singleton
    final utilsSharedPreferences = await UtilsSharedPreferences.getInstance();
    getIt.registerSingleton<UtilsSharedPreferences>(utilsSharedPreferences);

    getIt.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          baseUrl: AppApi.baseUrl,
          connectTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
          contentType: 'application/json',
          responseType: ResponseType.json,
          headers: {
            'Accept-Language': 'fa',
          },
          validateStatus: (status) => status != null && status < 400,
        ),
      ),
    );

    getIt.registerSingleton<ApiClientService>(
      ApiClientService(getIt<Dio>(), getIt<UtilsSharedPreferences>()),
    );

    // image picker
    getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerServiceImp());
    getIt.registerLazySingleton<ImageValidator>(() => ImageValidatorImp());
    getIt.registerLazySingleton<ImageConverter>(() => ImageConverterImp());
    getIt.registerFactory<UtilsImagePickerProvider>(
      () => UtilsImagePickerProvider(
        pickerService: getIt<ImagePickerService>(),
        validator: getIt<ImageValidator>(),
        converter: getIt<ImageConverter>(),
      ),
    );

    // login
    getIt.registerLazySingleton<LoginDataSource>(
        () => LoginDataSource(getIt<ApiClientService>(), getIt<UtilsSharedPreferences>()));
    getIt
        .registerLazySingleton<LoginRepository>(() => LoginRepositoryImp(getIt<LoginDataSource>()));
    getIt.registerLazySingleton<CheckLoginUseCase>(
        () => CheckLoginUseCase(getIt<UtilsSharedPreferences>()));
    getIt
        .registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(getIt<UtilsSharedPreferences>()));
    getIt.registerLazySingleton<LoginWithEmailUseCase>(
        () => LoginWithEmailUseCase(getIt<LoginRepository>()));
    getIt.registerLazySingleton<LoginWithKeysUseCase>(
        () => LoginWithKeysUseCase(getIt<LoginRepository>()));
    getIt.registerLazySingleton<VerifyEmailCodeUseCase>(
        () => VerifyEmailCodeUseCase(getIt<LoginRepository>()));
    getIt.registerLazySingleton<LoginProvider>(
      () => LoginProvider(
        loginWithEmailUseCase: getIt<LoginWithEmailUseCase>(),
        loginWithKeysUseCase: getIt<LoginWithKeysUseCase>(),
        verifyEmailCodeUseCase: getIt<VerifyEmailCodeUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        checkLoginUseCase: getIt<CheckLoginUseCase>(),
      ),
    );

    // create wallet
    getIt.registerLazySingleton<CreateWalletDatasource>(
        () => CreateWalletDatasource(getIt<ApiClientService>(), getIt<UtilsSharedPreferences>()));
    getIt.registerLazySingleton<CreateWalletRepository>(
        () => CreateWalletRepositoryImpl(datasource: getIt<CreateWalletDatasource>()));
    getIt.registerLazySingleton<CreateWalletUsecase>(
        () => CreateWalletUsecase(createWalletRepository: getIt<CreateWalletRepository>()));
    getIt.registerLazySingleton<CreateWalletProvider>(
        () => CreateWalletProvider(createWalletUsecase: getIt<CreateWalletUsecase>()));

    // ostad missions
    getIt.registerLazySingleton<MissionsDataSource>(
        () => MissionsDataSource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<MissionsRepository>(
        () => MissionsRepositoryImp(missionsDataSource: getIt<MissionsDataSource>()));
    // like twitter
    getIt.registerLazySingleton<LikeTwitterMissionUsecase>(
        () => LikeTwitterMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<LikeTwitterMissionProvider>(() =>
        LikeTwitterMissionProvider(likeTwitterMissionUsecase: getIt<LikeTwitterMissionUsecase>()));
    //follow twitter
    getIt.registerLazySingleton<FollowTwitterMissionUsecase>(
        () => FollowTwitterMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<FollowTwitterMissionProvider>(() => FollowTwitterMissionProvider(
        followTwitterMissionUsecase: getIt<FollowTwitterMissionUsecase>()));
    // student info mission
    getIt.registerLazySingleton<StudentInfoMissionUsecase>(
        () => StudentInfoMissionUsecase(missionsRepository: getIt<MissionsRepository>()));
    getIt.registerFactory<StudentInfoMissionProvider>(() =>
        StudentInfoMissionProvider(studentInfoMissionUsecase: getIt<StudentInfoMissionUsecase>()));
    // retweet twitter mission
    getIt.registerLazySingleton<RetweetTwitterMissionUsecase>(
        () => RetweetTwitterMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<RetweetTwitterMissionProvider>(() => RetweetTwitterMissionProvider(
        retweetTwitterMissionUsecase: getIt<RetweetTwitterMissionUsecase>()));
    // comment on twitter mission
    getIt.registerLazySingleton<CommentOnTwitterMissionUsecase>(
        () => CommentOnTwitterMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<CommentOnTwitterMissionProvider>(() => CommentOnTwitterMissionProvider(
        commentOnTwitterMissionUsecase: getIt<CommentOnTwitterMissionUsecase>()));
    // join telegram channel mission
    getIt.registerLazySingleton<JoinTelegramChannelMissionUsecase>(
        () => JoinTelegramChannelMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<JoinTelegramChannelMissionProvider>(() =>
        JoinTelegramChannelMissionProvider(
            joinTelegramChannelMissionUsecase: getIt<JoinTelegramChannelMissionUsecase>()));
    // join discussion group mission
    getIt.registerLazySingleton<JoinDiscussionGroupMissionUsecase>(
        () => JoinDiscussionGroupMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<JoinDiscussionGroupMissionProvider>(() =>
        JoinDiscussionGroupMissionProvider(
            joinDiscussionGroupMissionUsecase: getIt<JoinDiscussionGroupMissionUsecase>()));
    // like coinmarketcap mission
    getIt.registerLazySingleton<LikeCoinmarketcapMissionUsecase>(
        () => LikeCoinmarketcapMissionUsecase(getIt<MissionsRepository>()));
    getIt.registerFactory<LikeCoinmarketcapMissionProvider>(() => LikeCoinmarketcapMissionProvider(
        likeCoinmarketcapMissionUsecase: getIt<LikeCoinmarketcapMissionUsecase>()));
    // join dariwall telegram channel mission
    getIt.registerLazySingleton<JoinDariwallTelegramChannelMissionUsecase>(() =>
        JoinDariwallTelegramChannelMissionUsecase(missionsRepository: getIt<MissionsRepository>()));
    getIt.registerFactory<JoinDariwallTelegramChannelMissionProvider>(() =>
        JoinDariwallTelegramChannelMissionProvider(
            joinDariwallTelegramChannelMissionUsecase:
                getIt<JoinDariwallTelegramChannelMissionUsecase>()));
    // get province
    getIt.registerLazySingleton<GetProvinceUsecase>(
        () => GetProvinceUsecase(missionsRepository: getIt<MissionsRepository>()));
    getIt.registerLazySingleton<GetProvineceProvider>(
        () => GetProvineceProvider(getIt<GetProvinceUsecase>()));
    // get missions
    getIt.registerLazySingleton<GetMissionsUsecase>(
        () => GetMissionsUsecase(missionsRepository: getIt<MissionsRepository>()));
    getIt.registerLazySingleton<GetMissionsProvider>(
        () => GetMissionsProvider(getMissionsUsecase: getIt<GetMissionsUsecase>()));

    // parax missions
    getIt.registerLazySingleton<ParaxMissionsDataSource>(
        () => ParaxMissionsDataSource(getIt<ApiClientService>()));
    getIt.registerLazySingleton<ParaxMissionRepository>(() =>
        ParaxMissionsRepositoryImp(paraxMissionsDataSource: getIt<ParaxMissionsDataSource>()));
    // follow twitter parax
    getIt.registerLazySingleton<FollowParaxInTwitterMissionUsecase>(() =>
        FollowParaxInTwitterMissionUsecase(
            paraxMissionRepository: getIt<ParaxMissionRepository>()));
    getIt.registerFactory<FollowParaxInTwitterMissionProvider>(() =>
        FollowParaxInTwitterMissionProvider(
            followParaxInTwitterMissionUsecase: getIt<FollowParaxInTwitterMissionUsecase>()));
    // retweet parax post
    getIt.registerLazySingleton<RetweetParaxTwitterPostMissionUsecase>(() =>
        RetweetParaxTwitterPostMissionUsecase(
            paraxMissionRepository: getIt<ParaxMissionRepository>()));
    getIt.registerFactory<RetweetParaxTwitterPostMissionProvider>(() =>
        RetweetParaxTwitterPostMissionProvider(
            retweetParaxTwitterPostMissionUsecase: getIt<RetweetParaxTwitterPostMissionUsecase>()));
    // like parax in coinmarketcap
    getIt.registerLazySingleton<LikeParaxInCoinmarketcapMissionUsecase>(() =>
        LikeParaxInCoinmarketcapMissionUsecase(
            paraxMissionRepository: getIt<ParaxMissionRepository>()));
    getIt.registerFactory<LikeParaxInCoinmarketcapMissionProvider>(() =>
        LikeParaxInCoinmarketcapMissionProvider(
            likeParaxInCoinmarketcapMissionUsecase:
                getIt<LikeParaxInCoinmarketcapMissionUsecase>()));
    // check join in telegram channel
    getIt.registerLazySingleton<CheckJoinParaxTelegramChannelUsecase>(() =>
        CheckJoinParaxTelegramChannelUsecase(
            paraxMissionRepository: getIt<ParaxMissionRepository>()));
    getIt.registerFactory<CheckJoinParaxTelegramChannelProvider>(() =>
        CheckJoinParaxTelegramChannelProvider(
            checkJoinParaxTelegramChannelUsecase: getIt<CheckJoinParaxTelegramChannelUsecase>()));

    // calculate fee
    getIt.registerLazySingleton<CalculateFeeDataSource>(
        () => CalculateFeeDataSource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<CalculateFeeRepository>(
        () => CalculateFeeRepositoryImp(calculateFeeDataSource: getIt<CalculateFeeDataSource>()));
    getIt.registerLazySingleton<CalculateFeeUsecase>(
        () => CalculateFeeUsecase(calculateFeeRepository: getIt<CalculateFeeRepository>()));
    getIt.registerFactory<CalculateFeeProvider>(
        () => CalculateFeeProvider(calculateFeeUsecase: getIt<CalculateFeeUsecase>()));

    // calculate source target value
    getIt.registerLazySingleton<CalculateSourceTargetValueDataSource>(
        () => CalculateSourceTargetValueDataSource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<CalculateSourceTargetValueRepository>(() =>
        CalculateSourceTargetValueRepositoryImp(
            calculateSourceTargetValueDataSource: getIt<CalculateSourceTargetValueDataSource>()));
    getIt.registerLazySingleton<CalculateSourceTargetValueUsecase>(() =>
        CalculateSourceTargetValueUsecase(
            calculateSourceTargetValueRepository: getIt<CalculateSourceTargetValueRepository>()));
    getIt.registerFactory<CalculateSourceTargetValueProvider>(() =>
        CalculateSourceTargetValueProvider(
            calculateSourceTargetValueUsecase: getIt<CalculateSourceTargetValueUsecase>()));

    // swap
    getIt.registerLazySingleton<SwapDataSource>(
        () => SwapDataSource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<SwapRepository>(
        () => SwapRepositoryImp(swapDataSource: getIt<SwapDataSource>()));
    getIt.registerLazySingleton<SwapUsecase>(
        () => SwapUsecase(swapRepository: getIt<SwapRepository>()));
    getIt.registerFactory<SwapProvider>(() => SwapProvider(swapUsecase: getIt<SwapUsecase>()));

    // home
    getIt.registerLazySingleton<MyBalancesDatasource>(
        () => MyBalancesDatasource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<MyBalancesRepository>(
        () => MyBalancesRepositoryImp(myBalancesDatasource: getIt<MyBalancesDatasource>()));
    getIt.registerLazySingleton<MyBalancesUsecase>(
        () => MyBalancesUsecase(myBalancesRepository: getIt<MyBalancesRepository>()));
    getIt.registerLazySingleton<MyBalancesProvider>(
        () => MyBalancesProvider(myBalancesUsecase: getIt<MyBalancesUsecase>()));

    getIt.registerLazySingleton<ShowInCurrencyProvider>(
      () => ShowInCurrencyProvider(),
    );

    // connect wallet email
    getIt.registerLazySingleton<ConnectWalletEmailDatasource>(
        () => ConnectWalletEmailDatasource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<ConnectWalletEmailRepository>(
        () => ConnectWalletEmailRepositoryImp(datasource: getIt<ConnectWalletEmailDatasource>()));
    getIt.registerLazySingleton<ConnectWalletEmailUsecase>(
        () => ConnectWalletEmailUsecase(repository: getIt<ConnectWalletEmailRepository>()));
    getIt.registerLazySingleton<ConnectWalletEmailProvider>(
        () => ConnectWalletEmailProvider(usecase: getIt<ConnectWalletEmailUsecase>()));
    getIt.registerLazySingleton<ConnectWalletEmailOtpProvider>(
        () => ConnectWalletEmailOtpProvider(usecase: getIt<ConnectWalletEmailUsecase>()));

    // invite friends
    getIt.registerLazySingleton<InviteFriendsDatasource>(
        () => InviteFriendsDatasource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<InviteFriendsRepository>(
        () => InviteFriendsRepositoryImp(datasource: getIt<InviteFriendsDatasource>()));
    getIt.registerLazySingleton<InviteFriendsUsecase>(
        () => InviteFriendsUsecase(repository: getIt<InviteFriendsRepository>()));
    getIt.registerLazySingleton<InviteFriendsProvider>(
        () => InviteFriendsProvider(usecase: getIt<InviteFriendsUsecase>()));

    // user account
    getIt.registerLazySingleton<UserAccountDataSource>(
        () => UserAccountDataSource(apiClientService: getIt<ApiClientService>()));
    getIt.registerLazySingleton<UserAccountRepository>(
        () => UserAccountRepositoryImp(userAccountDataSource: getIt<UserAccountDataSource>()));
    getIt.registerLazySingleton<GetUserAccountInfoUsecase>(
        () => GetUserAccountInfoUsecase(userAccountRepository: getIt<UserAccountRepository>()));
    getIt.registerLazySingleton<GetUserAccountInfoProvider>(() =>
        GetUserAccountInfoProvider(getUserAccountInfoUsecase: getIt<GetUserAccountInfoUsecase>()));

    // change solana address wallet
    getIt.registerLazySingleton<ChangeUserAccountUsecase>(
        () => ChangeUserAccountUsecase(userAccountRepository: getIt<UserAccountRepository>()));
    getIt.registerFactory<SolanaAddressWalletProvider>(() =>
        SolanaAddressWalletProvider(changeUserAccountUsecase: getIt<ChangeUserAccountUsecase>()));

    // change user image
    getIt.registerFactory<UserAccountInfoEditProvider>(() =>
        UserAccountInfoEditProvider(changeUserAccountUsecase: getIt<ChangeUserAccountUsecase>()));

    // change user name
    getIt.registerLazySingleton<ChangeUserAccountNameProvider>(() =>
        ChangeUserAccountNameProvider(changeUserAccountUsecase: getIt<ChangeUserAccountUsecase>()));

    // gift code
    getIt.registerLazySingleton<GiftCodeDatasource>(
      () => GiftCodeDatasource(apiClientService: getIt<ApiClientService>()),
    );
    getIt.registerLazySingleton<GiftCodeRepository>(
      () => GiftCodeRepositoryImp(datasource: getIt<GiftCodeDatasource>()),
    );
    getIt.registerLazySingleton<SendGiftCodeUsecase>(
      () => SendGiftCodeUsecase(repository: getIt<GiftCodeRepository>()),
    );
    getIt.registerLazySingleton<VerifyGiftCodeUsecase>(
      () => VerifyGiftCodeUsecase(giftCodeRepository: getIt<GiftCodeRepository>()),
    );
    getIt.registerFactory<SendGiftCodeProvider>(
      () => SendGiftCodeProvider(sendGiftCodeUsecase: getIt<SendGiftCodeUsecase>()),
    );
    getIt.registerFactory<VerifyGiftCodeProvider>(
      () => VerifyGiftCodeProvider(verifyGiftCodeUsecase: getIt<VerifyGiftCodeUsecase>()),
    );

    // my transactions
    getIt.registerLazySingleton<TransactionsDataSource>(
      () => TransactionsDataSource(apiClientService: getIt<ApiClientService>()),
    );
    getIt.registerLazySingleton<TransactionsRepository>(
      () => TransactionsRepositoryImp(dataSource: getIt<TransactionsDataSource>()),
    );
    getIt.registerLazySingleton<TransactionsUsecase>(
      () => TransactionsUsecase(myTransactionsRepository: getIt<TransactionsRepository>()),
    );
    getIt.registerLazySingleton<TransactionsProvider>(
      () => TransactionsProvider(myTransactionsUsecase: getIt<TransactionsUsecase>()),
    );

    // currency prices
    getIt.registerLazySingleton<CurrencyPricesDataSource>(
      () => CurrencyPricesDataSource(
        apiClientService: getIt<ApiClientService>(),
      ),
    );
    getIt.registerLazySingleton<CurrencyPricesRepository>(
      () => CurrencyPricesRepositoryImp(
        currencyPricesDataSource: getIt<CurrencyPricesDataSource>(),
      ),
    );
    getIt.registerLazySingleton<CurrencyPricesUsecase>(
      () => CurrencyPricesUsecase(
        currencyPricesRepository: getIt<CurrencyPricesRepository>(),
      ),
    );
    getIt.registerLazySingleton<CurrencyPricesProvider>(
      () => CurrencyPricesProvider(
        currencyPricesUsecase: getIt<CurrencyPricesUsecase>(),
      ),
    );

    // withdraw
    getIt.registerLazySingleton<WithdrawDataSource>(
      () => WithdrawDataSource(apiClientService: getIt<ApiClientService>()),
    );
    getIt.registerLazySingleton<WithdrawRepository>(
      () => WithdrawRepositoryImp(withdrawDataSource: getIt<WithdrawDataSource>()),
    );
    getIt.registerLazySingleton<WithdrawUsecase>(
      () => WithdrawUsecase(withdrawRepository: getIt<WithdrawRepository>()),
    );
    getIt.registerFactory<WithdrawProvider>(
      () => WithdrawProvider(withdrawUsecase: getIt<WithdrawUsecase>()),
    );

    // transfer
    getIt.registerLazySingleton<TransferDataSource>(
      () => TransferDataSource(apiClientService: getIt<ApiClientService>()),
    );
    getIt.registerLazySingleton<TransferRepository>(
      () => TransferRepositoryImp(transferDataSource: getIt<TransferDataSource>()),
    );
    getIt.registerLazySingleton<TransferUsecase>(
      () => TransferUsecase(transferRepository: getIt<TransferRepository>()),
    );
    getIt.registerFactory<TransferProvider>(
      () => TransferProvider(transferUsecase: getIt<TransferUsecase>()),
    );

    // set email
    getIt.registerLazySingleton<SetEmailDataSource>(
      () => SetEmailDataSource(apiClientService: getIt<ApiClientService>()),
    );
    getIt.registerLazySingleton<SetEmailRepository>(
      () => SetEmailRepositoryImp(setEmailDataSource: getIt<SetEmailDataSource>()),
    );
    getIt.registerLazySingleton<SetEmailUsecase>(
      () => SetEmailUsecase(setEmailRepository: getIt<SetEmailRepository>()),
    );
    getIt.registerLazySingleton<VerifyEmailUsecase>(
      () => VerifyEmailUsecase(setEmailRepository: getIt<SetEmailRepository>()),
    );
    getIt.registerFactory<SetEmailProvider>(
      () => SetEmailProvider(setEmailUsecase: getIt<SetEmailUsecase>()),
    );
    getIt.registerFactory<VerifyEmailProvider>(
      () => VerifyEmailProvider(verifyEmailUsecase: getIt<VerifyEmailUsecase>()),
    );
  }

  static void reset() async {
    getIt<MyBalancesProvider>().reset();
    getIt<TransactionsProvider>().reset();
    getIt<CurrencyPricesProvider>().reset();
    getIt<GetUserAccountInfoProvider>().reset();
    getIt<UtilsSharedPreferences>().clear();
    getIt<Dio>().close();
    await getIt.reset();

    init();
  }
}
