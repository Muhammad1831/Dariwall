import 'package:flutter/material.dart';
import 'package:ostad/core/constant/app_dimens.dart';
import 'package:ostad/core/widgets/app_text_field.dart';

class AppOtp extends StatefulWidget {
  const AppOtp({super.key, this.numberOfField = 6, required this.onChanged});

  final int? numberOfField;
  final Function(String) onChanged;

  @override
  State<AppOtp> createState() => _AppOtpState();
}

class _AppOtpState extends State<AppOtp> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  String otp = '';

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.numberOfField!, (_) => TextEditingController());
    _focusNodes = List.generate(widget.numberOfField!, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.numberOfField!,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: AppTextFormField(
              contentPaddingHorizontal: AppDimens.paddingVerySmall,
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              style: Theme.of(context).textTheme.headlineSmall,
              onChanged: (value) {
                _onChanged(value, index);
                otp = _controllers.map((c) => c.text).join();
                widget.onChanged(otp);
              },
            ),
          ),
        ),
      ).toList().reversed.toList(),
    );
  }
}
