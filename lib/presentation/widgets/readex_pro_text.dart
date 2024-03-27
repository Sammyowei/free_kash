import 'package:flutter/material.dart'; // Flutter's Material Design widgets
import 'package:google_fonts/google_fonts.dart'; // Google Fonts for custom text styling

// A ReadexPro text widget with extended google fonts readex pro styling options
class ReadexProText extends StatelessWidget {
  // The text to display
  final String data;

  // Font size of the text
  final double? fontSize;

  // Spacing between words
  final double? wordSpacing;

  // Color of the text
  final Color? color;

  // Background color of the text
  final Color? backgroundColor;

  // Paint for drawing the background of the text
  final Paint? background;

  // Decoration to draw around the text
  final TextDecoration? decoration;

  // Color of the decoration
  final Color? decorationColor;

  // Style of the decoration
  final TextDecorationStyle? decorationStyle;

  // Thickness of the decoration
  final double? decorationThickness;

  // Additional font features
  final List<FontFeature>? fontFeatures;

  // Style of the text
  final FontStyle? fontStyle;

  // Spacing between letters
  final double? letterSpacing;

  // Height of the text
  final double? height;

  // Weight of the font
  final FontWeight? fontWeight;

  // Locale for the text
  final Locale? locale;

  // Shadows cast by the text
  final List<Shadow>? shadows;

  // Baseline for the text
  final TextBaseline? textBaseline;

  // Additional text style to apply
  final TextStyle? textStyle;

  const ReadexProText({
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.wordSpacing,
    this.background,
    this.backgroundColor,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.fontFeatures,
    this.fontStyle,
    this.height,
    this.letterSpacing,
    this.locale,
    this.shadows,
    this.textBaseline,
    this.textStyle,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // Return a Text widget styled with Google Fonts
    return Text(
      data,
      style: GoogleFonts.readexPro(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        wordSpacing: wordSpacing,
        background: background,
        backgroundColor: backgroundColor,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontFeatures: fontFeatures,
        fontStyle: fontStyle,
        height: height,
        letterSpacing: letterSpacing,
        locale: locale,
        shadows: shadows,
        textBaseline: textBaseline,
        textStyle: textStyle,
      ),
    );
  }
}
