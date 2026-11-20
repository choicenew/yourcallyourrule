// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get sheetTitle => 'Desbloquear Privilégios VIP';

  @override
  String get sheetSubtitle =>
      'Tradução Edge AI ilimitada · Totalmente limpo e sem anúncios · Sincronização em alta definição na nuvem';

  @override
  String get buyButtonText => 'Comprar Agora';

  @override
  String get watchAdButtonText => 'Ver Anúncio para Obter 1 Dia de VIP';

  @override
  String get restoreButtonText => 'Restaurar Compras';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get sheetTitle => 'Desbloquear Privilégios VIP';

  @override
  String get sheetSubtitle =>
      'Tradução Edge AI ilimitada · Totalmente limpo & sem anúncios · Sincronização em alta definição na nuvem';

  @override
  String get buyButtonText => 'Comprar Agora';

  @override
  String get watchAdButtonText => 'Assistir Anúncio para Obter 1 Dia de VIP';

  @override
  String get restoreButtonText => 'Restaurar Compras';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get sheetTitle => 'Desbloquear Privilégios VIP';

  @override
  String get sheetSubtitle =>
      'Tradução Edge AI ilimitada · Totalmente limpo e sem anúncios · Sincronização em alta definição na nuvem';

  @override
  String get buyButtonText => 'Comprar Agora';

  @override
  String get watchAdButtonText => 'Ver Anúncio para Obter 1 Dia de VIP';

  @override
  String get restoreButtonText => 'Restaurar Compras';
}
