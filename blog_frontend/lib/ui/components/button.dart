import 'package:blog_frontend/file_exporter.dart';

class Button extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function? onPressed;
  final Color? textColor;
  const Button(
      {required this.text,
      required this.color,
      required this.onPressed,
      required this.textColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.hWise, horizontal: 20.wWise),
      child: GestureDetector(
        onTap: () => onPressed!(),
        child: Container(
          width: 400.wWise,
          height: 60.hWise,
          padding: EdgeInsets.symmetric(
            vertical: 12.hWise,
            horizontal: 12.wWise,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              40.wWise,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text ?? "",
                fontWeight: FontWeight.w600,
                fontSize: 18.hWise,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
