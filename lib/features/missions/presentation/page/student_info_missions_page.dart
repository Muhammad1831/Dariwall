import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:dariwall/core/widgets/app_button.dart';
import 'package:dariwall/core/widgets/app_drop_down.dart';
import 'package:dariwall/core/widgets/app_header.dart';
import 'package:dariwall/core/widgets/app_text_field.dart';
import 'package:dariwall/core/widgets/app_warning_tip.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';
import 'package:dariwall/features/missions/presentation/provider/get_provinece_provider.dart';
import 'package:dariwall/features/missions/presentation/provider/student_info_mission_provider.dart';
import 'package:dariwall/features/missions/presentation/widgets/steps_title.dart';
import 'package:dariwall/features/missions/presentation/widgets/upload_image.dart';
import 'package:provider/provider.dart';

class StudentInfoMissionsPage extends StatefulWidget {
  const StudentInfoMissionsPage({super.key, required this.mission});
  final MissionModel mission;

  @override
  State<StudentInfoMissionsPage> createState() => _StudentInfoMissionsPageState();
}

class _StudentInfoMissionsPageState extends State<StudentInfoMissionsPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _studentNumber = TextEditingController();
  final TextEditingController _university = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _studentNumber.dispose();
    _university.dispose();
    _phoneNumber.dispose();
    getIt<GetProvineceProvider>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<UtilsImagePickerProvider>(),
        ),
        ChangeNotifierProvider.value(
          value: getIt<StudentInfoMissionProvider>(),
        ),
        ChangeNotifierProvider.value(
          value: getIt<GetProvineceProvider>(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(
                    headerText: AppString.studentInfoAtuntion,
                    justIcon: true,
                  ),
                  AppDimens.vSpaceLarge,
                  StepsTitle(),
                  AppDimens.vSpaceSmall,
                  AppWarningTip(
                    text: AppString.beforeStarting,
                  ),
                  AppDimens.vSpaceLarge,
                  Text(AppString.studentInfoAttentionDescription),
                  AppDimens.vSpaceLarge,
                  // full name textformfield
                  AppTextFormField.withTitle(
                    controller: _fullName,
                    title: AppString.name,
                    hintText: AppString.enterYourName,
                    textInputAction: TextInputAction.next,
                    validationType: ValidationType.notEmpty,
                  ),
                  AppDimens.vSpaceMedium,
                  // student number textformfield
                  AppTextFormField.withTitle(
                    controller: _studentNumber,
                    title: AppString.studentNumber,
                    hintText: AppString.enterStudentNumber,
                    validationType: ValidationType.notEmpty,
                    textInputAction: TextInputAction.next,
                  ),
                  AppDimens.vSpaceMedium,
                  // phone number textformfield
                  AppTextFormField.withTitle(
                    controller: _phoneNumber,
                    title: AppString.phoneNumberHaveTelegram,
                    hintText: AppString.enterPhoneNumberHaveTelegram,
                    validationType: ValidationType.phoneNumber,
                    textInputAction: TextInputAction.next,
                  ),
                  AppDimens.vSpaceMedium,
                  // university name textformfield
                  AppTextFormField.withTitle(
                    controller: _university,
                    title: AppString.university,
                    hintText: AppString.selectUniversity,
                    validationType: ValidationType.notEmpty,
                  ),
                  AppDimens.vSpaceMedium,
                  // province dropdown
                  Text(
                    AppString.province,
                  ),
                  AppDimens.vSpaceVerySmall,
                  Consumer<GetProvineceProvider>(
                    builder: (context, getProvinceProvider, child) {
                      return AsyncDropDown(
                        onChanged: (value) {
                          getProvinceProvider.setProvinceCode(value);
                        },
                        value: getProvinceProvider.provinceCode,
                        fetchItems: () async {
                          await getProvinceProvider.getProvinces();
                          return getProvinceProvider.provinces.map((element) {
                            return DropdownMenuItem(
                              value: element.code,
                              child: Text(element.name),
                            );
                          }).toList();
                        },
                        hint: AppString.selectProvince,
                      );
                    },
                  ),
                  AppDimens.vSpaceMedium,
                  AppDimens.vSpaceMedium,
                  Text(AppString.uploadStudentCardImage),
                  AppDimens.vSpaceMedium,
                  UploadImage(),
                  AppDimens.vSpaceLarge,
                  Divider(),
                  AppDimens.vSpaceSmall,
                  // reward text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${AppString.reward} :'),
                      Text(
                        '${widget.mission.amount.toString()} ${widget.mission.currencyInfo.currencyEnName}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColor.warningColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AppDimens.vSpaceSmall,
                  Consumer2<StudentInfoMissionProvider, UtilsImagePickerProvider>(
                    builder: (context, studentInfoProvider, imagePickerProvider, child) {
                      return AppButton(
                        isLoading: studentInfoProvider.status == StudentInfoMissionStatus.loading,
                        text: AppString.continueText,
                        onTap: () async {
                          await studentInfoProvider.studentInfoMission(
                            StudentInfoMissionModel(
                              fullName: _fullName.text,
                              studentNumber: _studentNumber.text,
                              universityName: _university.text,
                              provinceCode: getIt<GetProvineceProvider>().provinceCode,
                              phoneNumber: _phoneNumber.text,
                              image: imagePickerProvider.imageFile,
                            ),
                          );
                          if (studentInfoProvider.status == StudentInfoMissionStatus.success) {
                            if (mounted) {
                              context.pop();
                            }
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
