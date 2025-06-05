import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/widgets/app_dialog.dart';
import 'package:dariwall/core/widgets/app_shadow_background.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/set_email_provider.dart';
import 'package:dariwall/features/user_account_info_edit/presentation/provider/verify_email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_cached_image.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
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
  String? email;
  String? userName;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetUserAccountInfoProvider>(context, listen: false);
    if (provider.userAccountInfo?.name != null) {
      userName = provider.userAccountInfo!.name;
    }
    if (provider.userAccountInfo?.email != null) {
      email = provider.userAccountInfo!.email;
    }
  }

  void updateEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<UtilsImagePickerProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<UserAccountInfoEditProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<ChangeUserAccountNameProvider>(),
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
                      final userImage = Provider.of<GetUserAccountInfoProvider>(context)
                          .userAccountInfo
                          ?.accountImage;
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
                  // user name
                  UserAccountInfoItem(
                    title: AppString.userName,
                    hintText: AppString.userName,
                    data: Provider.of<GetUserAccountInfoProvider>(context).userAccountInfo!.name,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ChangeNotifierProvider.value(
                          value: getIt<ChangeUserAccountNameProvider>(),
                          child: SetUserName(),
                        ),
                      );
                    },
                  ),
                  AppDimens.vSpaceMedium,
                  // email
                  UserAccountInfoItem(
                    title: AppString.email,
                    hintText: AppString.enterEmail,
                    data: email,
                    onTap: () async {
                      final emailResult = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => getIt<SetEmailProvider>(),
                          child: const SetEmailDialog(),
                        ),
                      );

                      if (emailResult != null) {
                        final verificationResult = await showDialog<bool>(
                          context: context,
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => getIt<VerifyEmailProvider>(),
                            child: VerifyEmailDialog(email: emailResult),
                          ),
                        );

                        if (verificationResult == true) {
                          updateEmail(emailResult);
                        }
                      }
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

class SetEmailDialog extends StatefulWidget {
  const SetEmailDialog({super.key});

  @override
  State<SetEmailDialog> createState() => _SetEmailDialogState();
}

class _SetEmailDialogState extends State<SetEmailDialog> {
  final TextEditingController editEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    editEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SetEmailProvider, SetEmailStatus>(
      selector: (context, setEmailProvider) => setEmailProvider.status,
      builder: (context, status, child) {
        if (status == SetEmailStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop(editEmailController.text);
          });
        }
        return Form(
          key: formKey,
          child: AppDialog(
            isLoading: status == SetEmailStatus.loading,
            confirmAction: () async {
              if (formKey.currentState!.validate()) {
                await context.read<SetEmailProvider>().setEmail(editEmailController.text);
              }
            },
            cancelAction: () {
              editEmailController.clear();
              context.pop();
            },
            title: AppString.editEmail,
            content: AppString.enterEmail,
            alignment: CrossAxisAlignment.start,
            iconColor: AppColor.warningColor,
            confirmActionTitle: AppString.editEmail,
            child: AppTextFormField(
              controller: editEmailController,
              hintText: AppString.emailHint,
              keyboardType: TextInputType.emailAddress,
              validationType: ValidationType.email,
              suffixIcon: GestureDetector(
                onTap: () {
                  editEmailController.clear();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: AppDimens.paddingMedium),
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VerifyEmailDialog extends StatefulWidget {
  const VerifyEmailDialog({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmailDialog> createState() => _VerifyEmailDialogState();
}

class _VerifyEmailDialogState extends State<VerifyEmailDialog> {
  final TextEditingController confirmCodeController = TextEditingController();

  @override
  void dispose() {
    confirmCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<VerifyEmailProvider, VerifyEmailStatus>(
      selector: (context, verifyEmailProvider) => verifyEmailProvider.status,
      builder: (context, status, child) {
        if (status == VerifyEmailStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              context.pop(true);
            },
          );
        }
        return AppDialog(
          isLoading: status == VerifyEmailStatus.loading,
          confirmAction: () async {
            if (confirmCodeController.text.isNotEmpty) {
              await context
                  .read<VerifyEmailProvider>()
                  .verifyEmail(widget.email, confirmCodeController.text);
            }
          },
          title: AppString.verificationCode,
          content: AppString.codeSentTo(widget.email),
          alignment: CrossAxisAlignment.start,
          iconColor: AppColor.warningColor,
          icon: CupertinoIcons.checkmark_shield,
          child: AppTextFormField(
            controller: confirmCodeController,
            keyboardType: TextInputType.number,
            validationType: ValidationType.notEmpty,
            suffixIcon: GestureDetector(
              onTap: () {
                confirmCodeController.clear();
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppDimens.paddingMedium),
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SetUserName extends StatefulWidget {
  const SetUserName({super.key});

  @override
  State<SetUserName> createState() => _SetUserNameState();
}

class _SetUserNameState extends State<SetUserName> {
  final TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ChangeUserAccountNameProvider, UserAccountNameStatus>(
      selector: (context, changeUserAccountNameProvider) => changeUserAccountNameProvider.status,
      builder: (context, status, child) {
        if (status == UserAccountNameStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        }
        return AppDialog(
          isLoading: status == UserAccountNameStatus.loading,
          confirmAction: () async {
            if (userNameController.text.isNotEmpty) {
              await context
                  .read<ChangeUserAccountNameProvider>()
                  .changeUserName(userNameController.text);
            }
          },
          cancelAction: () {
            userNameController.clear();
            context.pop();
          },
          title: AppString.editUserName,
          alignment: CrossAxisAlignment.start,
          iconColor: AppColor.warningColor,
          confirmActionTitle: AppString.editUserName,
          child: AppTextFormField(
            controller: userNameController,
            hintText: AppString.userName,
            keyboardType: TextInputType.text,
            validationType: ValidationType.notEmpty,
            suffixIcon: GestureDetector(
              onTap: () {
                userNameController.clear();
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppDimens.paddingMedium),
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class UserAccountInfoItem extends StatelessWidget {
  const UserAccountInfoItem({
    super.key,
    required this.title,
    required this.hintText,
    required this.onTap,
    this.data,
  });

  final String title;
  final String hintText;
  final String? data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppDimens.vSpaceSmall,
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data ?? hintText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppDimens.paddingSmall),
                    child: Icon(
                      Icons.edit,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
