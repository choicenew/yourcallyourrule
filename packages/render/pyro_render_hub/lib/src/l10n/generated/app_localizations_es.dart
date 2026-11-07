// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get demandSentToAi => 'Solicitud enviada al asistente de IA';

  @override
  String get urlCopiedToClipboard => 'URL de la página copiada al portapapeles';

  @override
  String get cannotOpenExternalUrl =>
      'No se puede abrir la URL en el navegador externo';

  @override
  String get scanningWebTextNodes => 'Escaneando nodos de texto web...';

  @override
  String get noTranslatableWebNodesFound =>
      'No se encontraron nodos de texto traducibles. Espere a que la página se cargue por completo.';

  @override
  String get bilingualTranslationComplete =>
      'Traducción bilingüe en línea completada';

  @override
  String get failedToExtractWebText =>
      'Error al extraer el contenido traducible de la página web';

  @override
  String get webDictionarySearchTitle =>
      'Búsqueda de palabras web y diccionario';

  @override
  String get cancel => 'Cancelar';

  @override
  String get search => 'Buscar';

  @override
  String get smartSelectionEnabled =>
      'Burbuja de selección de texto inteligente y enlace de la barra de acciones activados';

  @override
  String get systemMenuRestored =>
      'Menú nativo de pulsación larga del sistema restaurado';

  @override
  String get copyLink => 'Copiar enlace';

  @override
  String get openInSystemBrowser => 'Abrir en navegador del sistema';

  @override
  String get bilingualPageTranslation => 'Traducción bilingüe de página web';

  @override
  String get extractAndTranslateContent => 'Extraer y traducir contenido';

  @override
  String get aiDeepAnalysisSummary => 'Análisis profundo y resumen con IA';

  @override
  String get dictionaryLookup => 'Consulta de diccionario';

  @override
  String get shareWebPage => 'Compartir página web';

  @override
  String get lookupWordAction => 'Buscar palabra';

  @override
  String get translateAction => 'Traducir';

  @override
  String get inputLookupHint =>
      'Ingrese la palabra o frase en inglés para buscar...';
}
