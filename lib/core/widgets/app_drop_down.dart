import 'package:flutter/material.dart';
import 'package:dariwall/core/constant/app_dimens.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/constant/app_string.dart';
import 'package:dariwall/core/utils/utils_show_snackbar.dart';
import 'package:dariwall/core/widgets/app_loading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool isExpanded;
  final Widget? icon;
  final Color? dropdownColor;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final double? menuMaxHeight;

  const AppDropDown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint = AppString.choose,
    this.isExpanded = true,
    this.icon,
    this.dropdownColor,
    this.decoration,
    this.padding,
    this.borderRadius = AppDimens.borderRadiusSmall,
    this.hintStyle,
    this.style,
    this.menuMaxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = decoration ??
        InputDecoration(
          contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
      child: DropdownButtonFormField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        menuMaxHeight: menuMaxHeight ?? 200,
        value: value,
        items: items,
        onChanged: onChanged,
        isExpanded: isExpanded,
        icon: icon ?? const Icon(Icons.arrow_drop_down),
        dropdownColor: dropdownColor,
        style: style,
        decoration: effectiveDecoration,
        hint: Text(
          hint,
          style: hintStyle ?? TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }
}

class AsyncDropDown<T> extends StatefulWidget {
  final Future<List<DropdownMenuItem<T>>> Function() fetchItems;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool isExpanded;
  final Widget? icon;
  final Color? dropdownColor;
  final InputDecoration? decoration;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final TextStyle? style;

  const AsyncDropDown({
    super.key,
    required this.fetchItems,
    required this.value,
    required this.onChanged,
    this.hint = AppString.choose,
    this.isExpanded = true,
    this.icon,
    this.dropdownColor,
    this.decoration,
    this.borderRadius = AppDimens.borderRadiusSmall,
    this.hintStyle,
    this.style,
  });

  @override
  State<AsyncDropDown<T>> createState() => _AsyncDropDownState<T>();
}

class _AsyncDropDownState<T> extends State<AsyncDropDown<T>> {
  List<DropdownMenuItem<T>>? _items;
  bool _isLoading = false;
  bool _isDropdownOpen = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() async {
    if (_isDropdownOpen) {
      _removeOverlay();
      return;
    }

    // شروع بارگذاری
    _showLoadingOverlay();

    if (_items == null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // دریافت آیتم‌ها از سرور
        final fetchedItems = await widget.fetchItems();

        if (mounted) {
          setState(() {
            _items = fetchedItems;
            _isLoading = false;
            _updateOverlay();
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _removeOverlay();
          });

          // نمایش خطا
          UtilsShowSnackbar.show(
            context: context,
            status: Status.error,
            message: AppMessage.errorInFetchingData,
          );
        }
      }
    } else {
      // اگر آیتم‌ها قبلاً دریافت شده‌اند، نمایش آنها
      _updateOverlay();
    }
  }

  void _showLoadingOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? AppDimens.borderRadiusSmall),
            color: widget.dropdownColor ?? Theme.of(context).canvasColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingLarge),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: _isLoading
                  ? const Center(
                      child: AppLoading(),
                    )
                  : _items != null && _items!.isNotEmpty
                      ? ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: _items!.map((item) {
                            return InkWell(
                              onTap: () {
                                widget.onChanged(item.value);
                                _removeOverlay();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppDimens.paddingMedium,
                                  horizontal: AppDimens.paddingLarge,
                                ),
                                child: item.child,
                              ),
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(AppDimens.paddingLarge),
                            child: Text(AppMessage.noDataFound),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  String _getSelectedItemText() {
    if (widget.value == null) {
      return widget.hint;
    }

    if (_items != null) {
      for (var item in _items!) {
        if (item.value == widget.value) {
          if (item.child is Text) {
            return (item.child as Text).data ?? widget.hint;
          }
        }
      }
    }

    return widget.hint;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final InputDecoration effectiveDecoration = widget.decoration ??
        InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimens.paddingMedium,
            vertical: AppDimens.paddingSmall,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? AppDimens.borderRadiusSmall),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? AppDimens.borderRadiusSmall),
          ),
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? AppDimens.borderRadiusSmall),
          ),
          child: InputDecorator(
            decoration: effectiveDecoration,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getSelectedItemText(),
                    style: widget.value == null
                        ? widget.hintStyle ?? theme.textTheme.labelMedium
                        : widget.style ??
                            theme.textTheme.labelMedium!.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_isLoading && !_isDropdownOpen)
                  const AppLoading()
                else
                  widget.icon ??
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.chevron_left),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
