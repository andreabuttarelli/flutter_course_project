enum AppColors {
  primary('00ffff', '00ffff'),
  onPrimary('000000', '000000'),
  secondary('ff00ff', 'ff00ff'),
  onSecondary('000000', '000000'),
  backgroundPrimary('000000', 'fff'),
  backgroundInverse('ffffff', '000'),
  backgroundSecondary('1a1a1a', 'f1f1f1'),
  onBackgroundPrimary('ffffff', '000000'),
  onBackgroundInverse('000000', 'ffffff'),
  onBackgroundSecondary('ffffff', '000000');

  const AppColors(this.darkThemeValue, this.lightThemeValue);

  final String darkThemeValue;
  final String lightThemeValue;
}
