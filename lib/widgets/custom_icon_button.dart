import 'package:archit_s_application1/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.margin,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final EdgeInsetsGeometry? margin;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: IconButton(
          visualDensity: VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          iconSize: getSize(height ?? 0),
          padding: EdgeInsets.all(0),
          icon: Container(
            alignment: Alignment.center,
            width: getSize(width ?? 0),
            height: getSize(height ?? 0),
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(
                      16.00,
                    ),
                  ),
                  border: Border.all(
                    color: appTheme.black900,
                    width: getHorizontalSize(
                      1.00,
                    ),
                  ),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get outlineGray200 => BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        border: Border.all(
          color: appTheme.gray200,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
}
