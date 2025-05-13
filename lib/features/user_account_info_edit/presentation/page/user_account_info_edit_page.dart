import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/features/user_account/presentation/provider/get_user_account_info_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/change_user_account_image_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/change_user_account_name_provider.dart';
import 'package:provider/provider.dart';

class UserAccountInfoEditPage extends StatefulWidget {
  const UserAccountInfoEditPage({super.key});

  @override
  State<UserAccountInfoEditPage> createState() => _UserAccountInfoEditPageState();
}

class _UserAccountInfoEditPageState extends State<UserAccountInfoEditPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? userName;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetUserAccountInfoProvider>(context, listen: false);
    if (provider.userAccountInfo?.name != null) {
      userName = provider.userAccountInfo!.name;
      userNameController.text = provider.userAccountInfo!.name!;
    }
    if (provider.userAccountInfo?.email != null) {
      emailController.text = provider.userAccountInfo!.email!;
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<UtilsImagePickerProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<UserAccountInfoEditProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ChangeUserAccountNameProvider>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: AppShadowBackground(
            child: Padding(
              padding: EdgeInsets.all(
                AppDimens.paddingVeryLarge,
              ),
              child: Column(
                children: [
                  AppHeader(headerText: AppString.userAccountInfo),
                  AppDimens.vSpaceVeryLarge,
                  Selector<UserAccountInfoEditProvider, UserAccountImageStatus>(
                    selector: (context, userAccountInfoEditProvider) =>
                        userAccountInfoEditProvider.state,
                    builder: (context, state, child) {
                      final userImage =
                          Provider.of<GetUserAccountInfoProvider>(context).userAccountInfo?.userImage;
                      return state == UserAccountImageStatus.loading
                          ? SizedBox(
                              height: size.height * 0.1,
                              width: size.height * 0.1,
                              child: AppLoading(),
                            )
                          : (userImage != null)
                              ? AppCachedImage(
                                  imageUrl: userImage,
                                  shape: BoxShape.circle,
                                  height: size.height * 0.1,
                                  width: size.height * 0.1,
                                )
                              : Image.asset(
                                  AppImages.avatar,
                                  height: size.width * 0.25,
                                  width: size.width * 0.25,
                                );
                    },
                  ),
                  AppDimens.vSpaceSmall,
                  Selector<UtilsImagePickerProvider, XFile?>(
                    selector: (context, imagePickerProvider) => imagePickerProvider.image,
                    builder: (context, image, child) {
                      return InkWell(
                        onTap: () async {
                          await context.read<UtilsImagePickerProvider>().pickSingleImage(
                                source: ImageSource.gallery,
                              );
            
                          if (context.read<UtilsImagePickerProvider>().image != null) {
                            await context.read<UserAccountInfoEditProvider>().changeUserImage(
                                context.read<UtilsImagePickerProvider>().image!.path);
                          }
                        },
                        borderRadius: BorderRadius.circular(AppDimens.borderRadiusSmall),
                        child: Padding(
                          padding: EdgeInsets.all(AppDimens.paddingVerySmall),
                          child: Text(
                            AppString.addimage,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  AppDimens.vSpaceVeryLarge,
                  AppTextFormField.withTitle(
                    title: AppString.userName,
                    controller: userNameController,
                    hintText: AppString.userName,
                  ),
                  AppDimens.vSpaceMedium,
                  AppTextFormField.withTitle(
                    title: AppString.email,
                    controller: emailController,
                    hintText: AppString.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    enabled: false,
                  ),  
                  Spacer(),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: userNameController,
                    builder: (context, value, child) {
                      return Selector<ChangeUserAccountNameProvider, UserAccountNameStatus>(
                        selector: (context, changeUserAccountNameProvider) =>
                            changeUserAccountNameProvider.status,
                        builder: (context, state, child) {
                          return AppButton(
                            isLoading: state == UserAccountNameStatus.loading,
                            bgColor: value.text != userName
                                ? theme.colorScheme.primary
                                : theme.disabledColor,
                            text: AppString.confirm,
                            onTap: () {
                              if (value.text != userName) {
                                userName = value.text;
                                context
                                    .read<ChangeUserAccountNameProvider>()
                                    .changeUserName(value.text);
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
