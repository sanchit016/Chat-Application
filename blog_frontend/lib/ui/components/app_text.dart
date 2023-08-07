
import 'package:blog_frontend/file_exporter.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final TextStyle? textStyle;
  const AppText(
      {Key? key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.letterSpacing,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          TextStyle(
            color: color ?? Colors.white,
            fontSize: fontSize ?? 15,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing ?? 1.0,
          ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
