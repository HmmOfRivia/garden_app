import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:garden_app/config/config.dart';
import 'package:intl/intl.dart';

class CustomInputField extends StatelessWidget {
  final Widget _field;

  static final InputDecoration _decoration = InputDecoration(
    hintStyle: AppStyles.whiteRegular(15).copyWith(
      color: Colors.white,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: AppColors.mainColor,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
  );

  CustomInputField.text({
    Key? key,
    required String name,
    String? hintText,
    TextEditingController? controller,
    int maxLength = 40,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
    TextInputAction? textInputAction,
    Function(String?)? onSubmitted,
    Function(String?)? onChanged,
    FocusNode? focusNode,
  })  : _field = FormBuilderTextField(
          name: name,
          focusNode: focusNode,
          style: AppStyles.whiteMedium(15),
          scrollPadding: const EdgeInsets.only(bottom: 400),
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          validator: validator,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          onChanged: onChanged,
          decoration: decoration ??
              _decoration.copyWith(
                hintText: hintText,
                counterText: '',
              ),
        ),
        super(key: key);

  CustomInputField.dropdown({
    Key? key,
    required String name,
    String? hintText,
    FormFieldValidator<dynamic>? validator,
    required List<DropdownMenuItem<dynamic>> items,
  })  : _field = FormBuilderDropdown<dynamic>(
          name: name,
          items: items,
          decoration: _decoration.copyWith(hintText: hintText),
          style: AppStyles.whiteMedium(15),
          validator: validator,
          dropdownColor: AppColors.mainColor,
        ),
        super(key: key);

  CustomInputField.timePicker({
    Key? key,
    required String name,
    TimeOfDay? initialTime,
    DateTime? initialDate,
    FormFieldValidator<dynamic>? validator,
    String? hintText,
  })  : _field = FormBuilderDateTimePicker(
          name: name,
          inputType: InputType.both,
          format: DateFormat('h:mm yyy-MM-dd'),
          initialTime: initialTime ?? TimeOfDay.now(),
          initialDate: initialDate ?? DateTime.now(),
          decoration: _decoration.copyWith(hintText: hintText),
          style: AppStyles.whiteMedium(15),
          validator: validator,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _field;
  }
}
