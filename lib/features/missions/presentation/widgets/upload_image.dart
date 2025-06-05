import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dariwall/core/constant/app_color.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_images.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/utils/utils_image_picker_provider.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<UtilsImagePickerProvider>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            provider.pickSingleImage(
              source: ImageSource.gallery,
            );
          },
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(AppDimens.borderRadiusMedium),
            color: theme.colorScheme.outline,
            strokeWidth: 0.5,
            dashPattern: const [4, 4],
            padding: EdgeInsets.all(AppDimens.paddingLarge),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  provider.image != null || provider.imageWeb != null
                      ? SizedBox(
                          height: 120,
                          child: kIsWeb
                              ? Image.memory(
                                  provider.imageWeb!,
                                  fit: BoxFit.scaleDown,
                                )
                              : Image.file(
                                  File(provider.image!.path),
                                  fit: BoxFit.scaleDown,
                                ),
                        )
                      : Image.asset(
                          AppImages.card,
                          height: 120,
                          fit: BoxFit.scaleDown,
                        ),
                  AppDimens.vSpaceLarge,
                  provider.image == null && provider.imageWeb == null
                      ? Text(
                          AppString.noDocumentUploaded,
                          style: theme.textTheme.titleMedium,
                        )
                      : Row(
                          spacing: AppDimens.veryVerySmall,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: AppColor.successColor,
                            ),
                            Text(
                              AppString.imageUploadedSuccessfuly,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: AppColor.successColor),
                            )
                          ],
                        ),
                  AppDimens.vSpaceMedium,
                  provider.image == null && provider.imageWeb == null
                      ? Text(
                          AppString.uploadImage,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: AppColor.infoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          AppString.uploadNewImage,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: AppColor.infoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
