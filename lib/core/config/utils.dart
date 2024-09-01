import '../language_cubit/language_cubit.dart';

String getServiceMessage({String? enMessage, String? arMessage, String? fallBack}) {
  String errorMessage = '';
  if (LanguageCubit.isEnglish) {
    if (enMessage != null && enMessage.trim().isNotEmpty) {
      errorMessage = enMessage;
    } else if (arMessage != null && arMessage.trim().isNotEmpty) {
      errorMessage = arMessage;
    }
  } else {
    if (arMessage != null && arMessage.trim().isNotEmpty) {
      errorMessage = arMessage;
    } else if (enMessage != null && enMessage.trim().isNotEmpty) {
      errorMessage = enMessage;
    }
  }
  if (errorMessage.isEmpty) errorMessage = fallBack ?? '';
  return errorMessage;
}