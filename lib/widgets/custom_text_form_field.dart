import 'package:pds/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.fillColor,
    this.filled = false,
    this.isObscureText,
    this.contentPadding,
    this.defaultBorderDecoration,
    this.enabledBorderDecoration,
    this.focusedBorderDecoration,
    this.disabledBorderDecoration,
    this.validator, 
    this.errorMaxLines,
    this.maxLength,this.inputFormatters,
    this
    .onChanged
  }) : super(
          key: key,
        );

  final Alignment? alignment;
  final double? width; 
  void Function(String)? onChanged;
  final EdgeInsetsGeometry? margin; 
  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final Color? fillColor;

  final bool? filled;
  bool? isObscureText;

  final EdgeInsets? contentPadding;

  final InputBorder? defaultBorderDecoration;

  final InputBorder? enabledBorderDecoration;

  final InputBorder? focusedBorderDecoration;

  final InputBorder? disabledBorderDecoration;

  final FormFieldValidator<String>? validator;
    List<TextInputFormatter>? inputFormatters;
  int? maxLength;
  final int? errorMaxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: widget.width ?? double.maxFinite,
        margin: widget.margin,
        child: TextFormField(
          
          onChanged:widget. onChanged,
          maxLength: widget.maxLength  ,
          controller: widget.controller,
          
          inputFormatters: widget.inputFormatters,
          // inputFormatters: [FilteringTextInputFormatter.deny(
          //            RegExp(r'\s')),],
          focusNode: widget.focusNode,
          autofocus: widget.autofocus!,
          style: widget.textStyle,
          obscureText: widget.obscureText!,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines ?? 1,
          decoration: decoration,
          validator: widget.validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: widget.hintText ?? "",
        hintStyle: widget.hintStyle, 
        prefixIcon: widget.prefix,counterText: "",
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: widget.suffix,
        suffixIconConstraints: widget.suffixConstraints,
        fillColor: widget.fillColor,
        filled: widget.filled,
        isDense: true,
        errorMaxLines: widget.errorMaxLines,
        contentPadding: widget.contentPadding,
        border: widget.defaultBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                6,
              ),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        enabledBorder: widget.enabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                6
              ),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        focusedBorder: widget.focusedBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
               6
              ),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),
            ),
        disabledBorder: widget.disabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
               6
              ),
              borderSide: BorderSide(
                color: appTheme.gray200,
                width: 1,
              ),

            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get fillDeeporange5001 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
         6
        ),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineBluegray50 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
        12
        ),
        borderSide: BorderSide(
          color: appTheme.blueGray50,
          width: 1,
        ),
      );
}
