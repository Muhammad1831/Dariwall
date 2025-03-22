import 'package:flutter/material.dart';
import 'package:ostad/constant/app_dimens.dart';
import 'package:ostad/constant/app_icons.dart';
import 'package:ostad/constant/app_string.dart';
import 'package:ostad/providers/image_picker_provider.dart';
import 'package:ostad/widgets/app_button.dart';
import 'package:ostad/widgets/app_snack_bar.dart';
import 'package:provider/provider.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
    required this.onTap,
    this.isMultiImage = false,
  });

  final Function(ImagePickerProvider, bool) onTap;
  final bool isMultiImage;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ImagePickerProvider>(
      builder: (context, imagePickerProvider, child) {
        final hasImages = isMultiImage
            ? imagePickerProvider.imageList != null && imagePickerProvider.imageList!.isNotEmpty
            : imagePickerProvider.image != null;

        if (imagePickerProvider.pickImageError != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              AppSnackBar.showError(context, message: imagePickerProvider.pickImageError!);
            },
          );
        }
        return AppButton(
          bgColor: hasImages ? null : theme.colorScheme.surface,
          text: hasImages
              ? AppString.send
              : isMultiImage
                  ? AppString.uploadImages
                  : AppString.uploadImage,
          textColor: hasImages ? null : theme.colorScheme.tertiary,
          icon: hasImages ? null : AppIcons.upload,
          iconSize: AppDimens.iconMedium,
          iconColor: hasImages ? null : theme.colorScheme.tertiary,
          onTap: () => onTap(imagePickerProvider, hasImages),
        );
      },
    );
  }
}
