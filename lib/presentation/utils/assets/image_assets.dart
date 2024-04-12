const _imagePath = 'assets/images';

extension ImageExtension on String {
  String get png => '$_imagePath/$this.png';
  String get jpg => '$_imagePath/$this.jpg';
}

class ImageAsset {
  static String accountCreation = 'illustration'.png;

  static String confirmatonMail = 'confirmation_screen'.png;

  static String apple = 'apple'.png;

  static String google = 'google'.png;

  static String facebook = 'facebook'.png;

  static String hide = 'hide_eye'.png;

  static String avatar = 'avatar'.png;

  static String referal = 'referral'.png;
}
