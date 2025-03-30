import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  const AppDropDown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hint = 'انتخاب کنید',
    this.isExpanded = true,
    this.icon,
    this.dropdownColor,
    this.decoration,
    this.padding,
    this.borderRadius = 8.0,
    this.hintStyle,
    this.style,
  }) : super(key: key);

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
        menuMaxHeight: 200.h,
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
    Key? key,
    required this.fetchItems,
    required this.value,
    required this.onChanged,
    this.hint = 'انتخاب کنید',
    this.isExpanded = true,
    this.icon,
    this.dropdownColor,
    this.decoration,
    this.borderRadius = 8.0,
    this.hintStyle,
    this.style,
  }) : super(key: key);

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطا در دریافت اطلاعات: ${e.toString()}')),
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
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            color: widget.dropdownColor ?? Theme.of(context).canvasColor,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: _isLoading
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 8),
                          Text('در حال دریافت اطلاعات...'),
                        ],
                      ),
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
                                  vertical: 12.0,
                                  horizontal: 16.0,
                                ),
                                child: item.child,
                              ),
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('اطلاعاتی یافت نشد'),
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
    final InputDecoration effectiveDecoration = widget.decoration ??
        InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
          ),
          child: InputDecorator(
            decoration: effectiveDecoration,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getSelectedItemText(),
                    style: widget.value == null
                        ? widget.hintStyle ?? TextStyle(color: Colors.grey.shade600)
                        : widget.style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_isLoading && !_isDropdownOpen)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                else
                  widget.icon ?? const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
