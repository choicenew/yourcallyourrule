// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get aboutContactSubscription => 'Acerca de la suscripción de contacto';

  @override
  String get aboutLabels => 'Acerca de las etiquetas';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Acerca de las reglas de suscripción telefónica';

  @override
  String get aboutPhoneSubscriptions =>
      'Acerca de las suscripciones telefónicas';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'Suscríbase a listas de reglas telefónicas a través de URL, actualice las reglas automáticamente. Admite archivos de reglas en formato JSON, CSV.';

  @override
  String get aboutSmsFilter => 'Acerca del filtrado de SMS';

  @override
  String get aboutSmsSubscriptionRules =>
      'Acerca de las reglas de suscripción de SMS';

  @override
  String get aboutSubtitle => 'Versión de la aplicación e información legal';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get action => 'Acción';

  @override
  String get actionAll => 'Todos';

  @override
  String get actionAllow => 'Permitir';

  @override
  String get actionBlock => 'Bloquear';

  @override
  String get actionFilterAll => 'Todos los filtros';

  @override
  String get actionFilterTitle => 'Filtrar por tipo de acción';

  @override
  String get actionFilterTooltip => 'Filtro de acción';

  @override
  String get actionNone => 'Sin acción';

  @override
  String get actionSilence => 'Silenciar';

  @override
  String actionTag(Object actionType) {
    return 'Acción: $actionType';
  }

  @override
  String get actionType => 'Tipo de acción';

  @override
  String get actionUnknown => 'Desconocido';

  @override
  String get add => 'Añadir';

  @override
  String get addAllowedBlockedRule => 'Añadir regla de Permitir/Bloquear';

  @override
  String get addAllowSubscription => 'Añadir suscripción de Permitir';

  @override
  String get addBlockSubscription => 'Añadir suscripción de Bloquear';

  @override
  String get addContactButton => 'Añadir contacto';

  @override
  String addContactFailed(Object error) {
    return 'Error al añadir contacto: $error';
  }

  @override
  String get addedToAllowedRules => 'Añadido a las reglas permitidas';

  @override
  String get addedToBlacklist => 'Añadido a la lista negra';

  @override
  String get addedToBlockedRules => 'Añadido a las reglas bloqueadas';

  @override
  String get addedToFavoriteContacts => 'Añadido a contactos favoritos';

  @override
  String get addedToFavorites => 'Añadido a contactos favoritos';

  @override
  String get addedToWhitelist => 'Añadido a la lista blanca';

  @override
  String get addFavorite => 'Añadir favorito';

  @override
  String get addFilter => 'Añadir filtro';

  @override
  String get addLabel => 'Añadir etiqueta';

  @override
  String get addLabelButton => 'Añadir etiqueta';

  @override
  String addLabelFailed(Object error) {
    return 'Error al añadir etiqueta: $error';
  }

  @override
  String get addLabelToCall => 'Añadir etiqueta al registro de llamadas';

  @override
  String get addName => 'Añadir nombre';

  @override
  String get addNoneSubscription => 'Añadir suscripción de Ninguno';

  @override
  String get addOrEditContactInfo =>
      'Se utiliza para añadir o editar información de contacto';

  @override
  String get addPhoneMark => 'Añadir marca de teléfono';

  @override
  String get addPhoneNumberRule => 'Añadir regla de número de teléfono';

  @override
  String get addPlugin => 'Añadir plugin';

  @override
  String get addPluginFailed => 'Error al añadir plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Error al añadir plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Añadir plugin desde archivo local';

  @override
  String get addPluginFromUrl => 'Añadir plugin desde URL';

  @override
  String get addRegexRule => 'Añadir regla de expresión regular';

  @override
  String get addRule => 'Añadir regla';

  @override
  String get addRuleButton => 'Añadir regla';

  @override
  String addRuleFailed(Object error) {
    return 'Error al añadir la regla: $error';
  }

  @override
  String get addRuleTooltip => 'Añadir regla';

  @override
  String get addSilenceSubscription => 'Añadir suscripción de silencio';

  @override
  String get addSimRuleButton => 'Añadir regla de SIM';

  @override
  String get addSmsFilterRule => 'Añadir regla de filtro SMS';

  @override
  String get addSmsRule => 'Añadir regla SMS';

  @override
  String get addSmsSubscription => 'Añadir suscripción SMS';

  @override
  String get addSubscription => 'Añadir suscripción';

  @override
  String get addSubscriptionButton => 'Añadir suscripción';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Error al añadir la suscripción: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Añadir suscripción';

  @override
  String get addToAllowedRules => 'Añadir a reglas permitidas';

  @override
  String get addToBlacklist => 'Añadir a la lista negra';

  @override
  String get addToBlockedRules => 'Añadir a reglas bloqueadas';

  @override
  String get addToFavoriteContacts => 'Añadir a contactos favoritos';

  @override
  String get addToFavorites => 'Añadir a favoritos';

  @override
  String get addToRules => 'Añadir a reglas';

  @override
  String get addToWhitelist => 'Añadir a la lista blanca';

  @override
  String get adPlaceholder => 'Marcador de posición de anuncio';

  @override
  String get agent => 'Agente';

  @override
  String get all => 'Todo';

  @override
  String get allCallsTab => 'Todos';

  @override
  String get allDataClearedSuccessfully =>
      'Todos los datos borrados correctamente';

  @override
  String get allow => 'Permitir';

  @override
  String get allowAllAllowRules => 'Permitir todas las reglas de permiso';

  @override
  String get allowAllAllowRulesDesc =>
      'Permitir llamadas desde reglas de permiso';

  @override
  String get allowAllBlacklistedNumbers =>
      'Permitir todos los números en la lista negra';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Permitir llamadas desde la lista de bloqueados';

  @override
  String get allowAllBlockRules => 'Permitir todas las reglas de bloqueo';

  @override
  String get allowAllBlockRulesDesc =>
      'Permitir llamadas desde reglas de bloqueo';

  @override
  String get allowAllowedNumbers => 'Permitir números permitidos';

  @override
  String get allowAllowedNumbersDesc =>
      'Permitir llamadas desde la lista de permitidos';

  @override
  String get allowBlock => 'Permitir/Bloquear';

  @override
  String get allowBlockedNumbers => 'Permitir números bloqueados';

  @override
  String get allowBlockedNumbersDesc =>
      'Permitir llamadas desde la lista de bloqueados';

  @override
  String get allowedBlockedRule => 'Regla de Permitir/Bloquear';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Editar regla de Permitir/Bloquear';

  @override
  String get allowedBlockedRuleManagement =>
      'Gestión de reglas de Permitir/Bloquear';

  @override
  String get allowNonExceededNumbers => 'Permitir números no excedidos';

  @override
  String get allowNonExceededNumbersDescription =>
      'Permitir automáticamente números que no excedan el umbral de conteo';

  @override
  String get allowRegexAllowRules => 'Permitir reglas de permiso Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'Habilitar la coincidencia de patrones regex para reglas de permiso';

  @override
  String get allowRegexAllowRulesDescription =>
      'Habilitar reglas de permiso basadas en regex';

  @override
  String get allowRegexBlockRules => 'Permitir reglas de bloqueo Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'Habilitar la coincidencia de patrones regex para reglas de bloqueo';

  @override
  String get allowRegexBlockRulesDescription =>
      'Habilitar reglas de bloqueo basadas en regex';

  @override
  String get allowRule => 'Regla de permiso';

  @override
  String get allowRules => 'Reglas de permiso';

  @override
  String get allowWhitelistedNumbers => 'Permitir números en la lista blanca';

  @override
  String get allowWhitelistedNumbersDescription =>
      'Permitir todos los números en la lista blanca';

  @override
  String get allPermissionsGranted => 'Todos los permisos concedidos';

  @override
  String get allSettingsCompleted => 'Todos los ajustes completados.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Todas las actualizaciones completadas ($count reglas)';
  }

  @override
  String get answerThenHangup => 'Responder y luego colgar';

  @override
  String get appLegalese =>
      '© 2023 Your Call Your Rule. Todos los derechos reservados.';

  @override
  String get applicationSoftware => 'Software de aplicación';

  @override
  String get apply => 'Aplicar';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Error de autorización: Por favor, compruebe el ID y la clave del cliente';

  @override
  String get authorizationFailedMessage => 'Error de autorización';

  @override
  String get authorizationSuccessMessage => 'Autorización exitosa';

  @override
  String get authorizeLoginButton => 'Autorizar inicio de sesión';

  @override
  String get automotiveIndustry => 'Industria automotriz';

  @override
  String get autoSyncLabel => 'Sincronización automática';

  @override
  String get autoUpdate => 'Actualización automática';

  @override
  String get autoUpdateDescription =>
      'Establecer intervalos de actualización automática para las suscripciones o actualizar manualmente';

  @override
  String get autoUpdateSettings => 'Ajustes de actualización automática';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Administrar las actualizaciones automáticas de reglas y complementos';

  @override
  String get autoUpdateSettingsTitle => 'Ajustes de actualización automática';

  @override
  String get autoUpdateSubtitle =>
      'Administrar las actualizaciones automáticas de reglas y complementos';

  @override
  String get autoUpdateTitle => 'Actualización automática';

  @override
  String get avatarBorderColor => 'Color del borde del avatar';

  @override
  String get avatarBorderSize => 'Tamaño del borde del avatar';

  @override
  String get avatarIconSizesSetting => 'Tamaños de avatar e icono';

  @override
  String get avatarPosition => 'Posición del avatar';

  @override
  String get avatarSize => 'Tamaño del avatar';

  @override
  String axisPosition(Object axis) {
    return 'Posición del $axis';
  }

  @override
  String get backgroundGradientSetting => 'Gradiente de fondo';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get backupAndRestore => 'Copia de seguridad y restauración';

  @override
  String get backupAndRestoreSubtitle =>
      'Copia de seguridad o restaura los datos de la aplicación';

  @override
  String get backupAndRestoreTitle => 'Copia de seguridad y restauración';

  @override
  String get backupFailed => 'Copia de seguridad fallida';

  @override
  String get backupFailedMessage => 'Copia de seguridad fallida';

  @override
  String backupFailedWithError(Object error) {
    return 'Copia de seguridad fallida: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Copia de seguridad o restaura los datos de la aplicación';

  @override
  String get backupRestoreTitle => 'Copia de seguridad y restauración';

  @override
  String get backupSectionTitle => 'Copia de seguridad';

  @override
  String get backupSettings => 'Ajustes de copia de seguridad';

  @override
  String get backupSettingsDialogTitle => 'Ajustes de copia de seguridad';

  @override
  String get backupSettingsTitle => 'Ajustes de copia de seguridad';

  @override
  String get backupSuccessMessage =>
      'Copia de seguridad en la nube realizada con éxito';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Copia de seguridad exitosa en: $path';
  }

  @override
  String get backupToCloud => 'Copia de seguridad en la nube';

  @override
  String get backupToCloudDescription =>
      'Copia de seguridad de la configuración y las reglas en el almacenamiento en la nube';

  @override
  String backupToCloudFailed(Object error) {
    return 'Error al realizar la copia de seguridad en la nube: $error';
  }

  @override
  String get backupToCloudLabel => 'Copia de seguridad en la nube';

  @override
  String get backupToCloudSuccess =>
      'Copia de seguridad en la nube realizada con éxito';

  @override
  String get backupToCloudTitle => 'Copia de seguridad en la nube';

  @override
  String get backupToLocalLabel => 'Copia de seguridad local';

  @override
  String get bank => 'Banco';

  @override
  String get basicInfo => 'Información básica';

  @override
  String get basicRuleFilter => 'Filtro de regla básica';

  @override
  String get basicRuleFiltering => 'Filtrado de regla básica';

  @override
  String get basicRuleFilteringExplanation =>
      '• Filtrado de regla básica: reglas de filtrado basadas en lista negra, lista blanca y regex';

  @override
  String get basicRuleFilterSettings =>
      'Configuración del filtro de regla básica';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtra llamadas usando lista negra/lista blanca y expresiones regulares';

  @override
  String get batchDeleteContacts => 'Eliminar contactos por lotes';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '¿Estás seguro de que quieres eliminar $count contactos seleccionados?';
  }

  @override
  String get batchDeleteFailed => 'Error al eliminar por lotes';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '¿Estás seguro de que quieres eliminar $count etiquetas?';
  }

  @override
  String get blacklist => 'Lista negra';

  @override
  String get blacklistingAndWhitelisting => 'Lista negra y lista blanca';

  @override
  String get blacklistLabel => 'Lista negra';

  @override
  String get blackWhiteList => 'Lista Negra/Blanca';

  @override
  String get block => 'Bloquear';

  @override
  String get blockCalls => 'Bloquear llamadas';

  @override
  String get blocked => 'Bloqueado';

  @override
  String get blockedCallAction => 'Acción de llamada bloqueada';

  @override
  String get blockedCalls => 'Llamadas bloqueadas';

  @override
  String get blockedCallsTitle => 'Llamadas bloqueadas';

  @override
  String get blockedCommunications => 'Comunicaciones bloqueadas';

  @override
  String get blockedPhoneLabel => 'Llamadas bloqueadas';

  @override
  String get blockedSpamCalls => 'Llamadas de spam bloqueadas';

  @override
  String get blockingTrend => 'Tendencia de bloqueo';

  @override
  String get blockInternationalCalls =>
      'coincide con números que no comienzan con + o 00';

  @override
  String get blockInternationalCallsTitle =>
      'Bloquear llamadas internacionales';

  @override
  String get blockLandlineNumbersTitle => 'Bloquear números de línea fija';

  @override
  String get blockMobileNumbers =>
      'coincide con números que no comienzan con 13-19';

  @override
  String get blockMobileNumbersTitle => 'Bloquear números de móvil';

  @override
  String get blockPremiumRateNumbers =>
      'coincide con números que no comienzan con 118 o 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Bloquear números de tarifa premium';

  @override
  String get blockRule => 'Regla de bloqueo';

  @override
  String get blockRules => 'Reglas de bloqueo';

  @override
  String get blockSpecificAreaCodes =>
      'coincide con números que comienzan con 0 + 2-3 dígitos';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Bloquear códigos de área específicos:';

  @override
  String get blockTypeAnalysisTitle => 'Análisis del tipo de bloqueo';

  @override
  String get both => 'Ambos';

  @override
  String get bulkDelete => 'Eliminar contactos por lotes';

  @override
  String get bulkDeleteContacts => 'Eliminar contactos por lotes';

  @override
  String get bulkDeleteLabels => 'Eliminar etiquetas en bloque';

  @override
  String get call => 'Llamar';

  @override
  String get callback => 'Devolver llamada';

  @override
  String callbackTo(String number) {
    return 'Devolver la llamada a $number';
  }

  @override
  String get callBlocking => 'Bloqueo de llamadas';

  @override
  String get callerIdApp => 'Aplicación de identificación de llamadas';

  @override
  String get callerIdCustomizationTitle =>
      'Personalizar el identificador de llamadas';

  @override
  String get callerIdDialogTitle => 'Información del identificador de llamadas';

  @override
  String get callerIdDisplayMode =>
      'Modo de visualización del identificador de llamadas';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Marcado por $count';
  }

  @override
  String get callerIdPreview => 'Vista previa del identificador de llamadas';

  @override
  String get callFilter => 'Filtro de llamadas';

  @override
  String get callFilterDescription =>
      'Cuando está habilitado, las llamadas entrantes se verifican con la lista de reglas a continuación. Las reglas de filtrado de llamadas no se sincronizan entre dispositivos de forma predeterminada.';

  @override
  String get callFilterRules => 'Reglas del filtro de llamadas';

  @override
  String get callFilterRulesDescription =>
      'Establecer reglas básicas para el filtrado de llamadas';

  @override
  String get callFilterSettings => 'Configuración del filtro de llamadas';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Establecer límites de frecuencia de llamadas y reglas de bloqueo';

  @override
  String get callFrequencyInterceptionTitle =>
      'Interceptación de frecuencia de llamadas';

  @override
  String get callHistory => 'Historial de llamadas';

  @override
  String get callHistoryInfoDesc =>
      'Aquí se muestra su historial de llamadas, incluidas las llamadas entrantes, salientes y perdidas.';

  @override
  String get callHistoryInfoTitle => 'Historial de llamadas';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Error al inicializar el historial de llamadas: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Error al actualizar el historial de llamadas: $error';
  }

  @override
  String get callHistoryTab => 'Historial de llamadas';

  @override
  String get callHistoryTimelineEarlier => 'Anterior';

  @override
  String get callHistoryTimelineToday => 'Hoy';

  @override
  String get callHistoryTimelineYesterday => 'Ayer';

  @override
  String get callScreeningPermission => 'Permiso de detección de llamadas';

  @override
  String get callScreeningPermissionDescription =>
      'Se utiliza para detectar y bloquear llamadas no deseadas.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Permiso de detección de llamadas no concedido, puede afectar la funcionalidad de la aplicación.';

  @override
  String get callSettingsSubtitle =>
      'Identificador de llamadas, configuración de filtrado y bloqueo';

  @override
  String get callSettingsTitle => 'Configuración de llamadas';

  @override
  String get callStatistics => 'Estadísticas de llamadas';

  @override
  String get callTypeAnswered => 'Contestada';

  @override
  String get callTypeBlocked => 'Bloqueada';

  @override
  String get callTypeIconColor => 'Color del icono de tipo de llamada';

  @override
  String get callTypeMissed => 'Llamada perdida';

  @override
  String get callTypeOutgoing => 'Saliente';

  @override
  String get callTypePosition => 'Posición del tipo de llamada';

  @override
  String get callTypeUnknown => 'Desconocida';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get carRental => 'Alquiler de coches';

  @override
  String get carrier => 'Proveedor';

  @override
  String get carrierColor => 'Color del proveedor';

  @override
  String get carrierFontSize => 'Tamaño de fuente del proveedor';

  @override
  String get carrierPosition => 'Posición del proveedor';

  @override
  String get changeLabel => 'Cambiar etiqueta';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Error al cambiar el estado del complemento: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Error al cambiar el estado de la suscripción: $error';
  }

  @override
  String get changeTag => 'Cambiar etiqueta';

  @override
  String get charity => 'Organización benéfica';

  @override
  String chartMonthFormat(int month) {
    return 'Mes $month';
  }

  @override
  String get chartOneDayAgo => 'Hace 1 día';

  @override
  String get chartOneMonthAgo => 'Hace 1 mes';

  @override
  String get chartOneWeekAgo => 'Hace 1 semana';

  @override
  String get chartTenDaysAgo => 'Hace 10 días';

  @override
  String get chartThreeDaysAgo => 'Hace 3 días';

  @override
  String get chartToday => 'Hoy';

  @override
  String get checkFileFormat =>
      'Por favor, compruebe el formato del archivo o los permisos';

  @override
  String checkPermissionFailed(Object error) {
    return 'Error al comprobar los permisos: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Elija la acción de interceptación predeterminada';

  @override
  String get clearAllData => 'Borrar todos los datos';

  @override
  String get clearAllDataConfirmation =>
      '¿Está seguro de que desea borrar todos los datos de la aplicación? Esta acción no se puede deshacer.';

  @override
  String get clearAllDataDescription =>
      'Borrar todos los datos de la aplicación';

  @override
  String get clearAllDataLabel => 'Borrar todos los datos';

  @override
  String get clearFilter => 'Borrar filtro';

  @override
  String get clearLabelFilter => 'Borrar filtro de etiqueta';

  @override
  String get clearLabelFilterButton => 'Borrar filtro de etiqueta';

  @override
  String get closeButton => 'Cerrar';

  @override
  String get cloudSync => 'Sincronización en la nube';

  @override
  String get cloudSyncAndBackupTitle =>
      'Sincronización y copia de seguridad en la nube';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Configure WebDAV, OneDrive y Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Ajustes de sincronización en la nube';

  @override
  String get cloudSyncTitle => 'Sincronización en la nube';

  @override
  String get collapseLabelSelector => 'Contraer selector de etiquetas';

  @override
  String get collection => 'Cobro de deudas';

  @override
  String get colorPickerTitle => 'Elegir color';

  @override
  String get configManagement => 'Gestión de la configuración';

  @override
  String get configUpdated => 'Configuración actualizada';

  @override
  String get configurationAdvice =>
      'A través de una configuración adecuada, puede establecer diferentes estrategias de filtrado para tarjetas SIM de trabajo y personales.';

  @override
  String get configureBackupOptions =>
      'Configurar opciones de copia de seguridad';

  @override
  String get configureBackupOptionsSubtitle =>
      'Configurar opciones de copia de seguridad';

  @override
  String get configureCloudSyncService =>
      'Configurar servicio de sincronización en la nube';

  @override
  String get configureCloudSyncServiceHint =>
      'Por favor, configure un servicio de sincronización en la nube para habilitar la sincronización multidispositivo.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Por favor, configure un servicio de sincronización en la nube para habilitar la sincronización multidispositivo.';

  @override
  String get configureSimCardFilterRules =>
      'Configurar reglas de filtrado de la tarjeta SIM';

  @override
  String get configureSyncServiceHint =>
      'Por favor, configure primero el servicio de sincronización en la configuración de sincronización en la nube';

  @override
  String get confirm => 'Confirmar';

  @override
  String get confirmBatchDeleteContacts =>
      '¿Está seguro de que desea eliminar los seleccionados?';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get confirmDelete => 'Confirmar eliminación';

  @override
  String get confirmDeleteContact => '¿Está seguro de que desea eliminar?';

  @override
  String get confirmDeleteContactName => '¿Confirmar eliminación?';

  @override
  String get confirmDeleteFilter =>
      '¿Está seguro de que desea eliminar este filtro?';

  @override
  String confirmDeleteLabel(Object name) {
    return '¿Está seguro de que desea eliminar la etiqueta \"$name\"?';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '¿Está seguro de que desea eliminar el plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '¿Está seguro de que desea eliminar $count plugins?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      '¿Está seguro de que desea eliminar esta regla? Esta acción no se puede deshacer.';

  @override
  String get confirmDeleteSelectedContacts =>
      '¿Está seguro de eliminar los contactos seleccionados?';

  @override
  String get confirmDeleteSmsFilterRule =>
      '¿Está seguro de que desea eliminar esta regla de filtro de SMS?';

  @override
  String get confirmDeleteSmsRule =>
      '¿Está seguro de que desea eliminar esta regla de SMS?';

  @override
  String get confirmDeleteSubscription =>
      '¿Está seguro de que desea eliminar esta suscripción?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '¿Está seguro de que desea eliminar $name?';
  }

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get connectedStatus => 'Conectado';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Error de conexión: Por favor, compruebe la dirección del servidor, el nombre de usuario y la contraseña';

  @override
  String get connectionFailedMessage => 'Error de conexión';

  @override
  String get connectionStatusLabel => 'Estado de la conexión';

  @override
  String get connectionSuccessMessage => 'Conexión exitosa';

  @override
  String get contactAddSuccess => 'Contacto añadido exitosamente';

  @override
  String get contactDeleted => 'Contacto eliminado';

  @override
  String get contactEditDialog => 'Diálogo de edición de contacto';

  @override
  String get contactNameHint => 'Ingrese el nombre del contacto (opcional)';

  @override
  String get contactNameLabel => 'Nombre';

  @override
  String get contactNameOptional => 'Nombre del contacto (opcional)';

  @override
  String get contactNotFound => 'Contacto no encontrado';

  @override
  String get contacts => 'Contactos';

  @override
  String contactsDeleted(Object count) {
    return '$count contactos eliminados';
  }

  @override
  String get contactSettingsSubtitle =>
      'Gestión de contactos y configuración de etiquetas';

  @override
  String get contactSettingsTitle => 'Configuración de contactos';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Error al cargar contactos: $error';
  }

  @override
  String get contactsManagement => 'Gestión de contactos';

  @override
  String get contactsManagementPageTitle => 'Página de gestión de contactos';

  @override
  String get contactsPageTitle => 'Gestión de contactos';

  @override
  String get contactsPermission => 'Permiso de contactos';

  @override
  String get contactsPermissionDescription =>
      'Se utiliza para identificar llamadas de contactos.';

  @override
  String get contactsTab => 'Contactos';

  @override
  String get contactSubscriptionDescription =>
      'Suscríbete a listas de contactos a través de URL, actualiza automáticamente la información y las etiquetas de los contactos. Admite datos en formato JSON.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Error al cargar las suscripciones de contactos: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Suscripciones de contactos';

  @override
  String get contactUpdateSuccess => 'Contacto actualizado exitosamente';

  @override
  String get contactUs => 'Contáctenos';

  @override
  String get content => 'Contenido';

  @override
  String get contentRegex => 'Regex del contenido';

  @override
  String get countColor => 'Color del conteo';

  @override
  String get countFontSize => 'Tamaño de fuente del conteo';

  @override
  String get countPosition => 'Posición del conteo';

  @override
  String get country => 'País';

  @override
  String get countryNameColor => 'Color del nombre del país';

  @override
  String get countryNameFontSize => 'Tamaño de fuente del nombre del país';

  @override
  String get countryRegionNamePosition => 'Posición del nombre del país/región';

  @override
  String get countrySelectionDialog => 'Diálogo de selección de país';

  @override
  String get countrySelectionDialogDescription =>
      'Se utiliza para seleccionar un país para consultar la información del identificador de llamadas';

  @override
  String get countThresholdDescription =>
      'Establezca el umbral de conteo mínimo requerido para activar las acciones de filtrado';

  @override
  String get countThresholdLabel => 'Umbral de conteo';

  @override
  String get countThresholdSettings => 'Configuración del umbral de conteo';

  @override
  String countThresholdValue(Object count) {
    return 'Umbral de conteo: $count';
  }

  @override
  String get createdRules => 'Reglas creadas';

  @override
  String get csvFormat => 'Formato CSV';

  @override
  String get currentDeviceChip => 'Actual';

  @override
  String get currentDeviceLabel => 'Etiqueta del dispositivo actual';

  @override
  String get currentDeviceTitle => 'Dispositivo actual';

  @override
  String get currentLabels => 'Etiquetas actuales:';

  @override
  String get currentLanguage => 'Idioma actual';

  @override
  String get currentPasswordLabel => 'Contraseña actual';

  @override
  String get customerService => 'Servicio al Cliente';

  @override
  String get customRange => 'Rango personalizado';

  @override
  String get dailyStatistics => 'Estadísticas diarias';

  @override
  String get dailyStatisticsDesc =>
      'Reciba estadísticas diarias sobre llamadas y mensajes bloqueados';

  @override
  String get dashboardTab => 'Tablero';

  @override
  String get dataAnalysis => 'Análisis de datos';

  @override
  String get dataAnalysisDashboardPage =>
      'Página del tablero de análisis de datos';

  @override
  String get dataExport => 'Exportación de datos';

  @override
  String dataLoadFailure(Object error) {
    return 'Error al cargar los datos: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Error al cargar los datos: $error';
  }

  @override
  String get dataMigration => 'Migración de datos';

  @override
  String get dataMigrationDescription =>
      'Esta función le permite transferir todos sus datos entre dispositivos. Actualmente, puede utilizar las funciones de copia de seguridad y restauración para migrar sus datos manualmente.';

  @override
  String get dataMigrationDialogContent =>
      'Esta función le permite transferir todos sus datos entre dispositivos. Actualmente, puede utilizar las funciones de copia de seguridad y restauración para migrar sus datos manualmente.';

  @override
  String get dataMigrationDialogTitle => 'Migración de datos';

  @override
  String get dataMigrationSectionTitle => 'Migración de datos';

  @override
  String get dataSourceReminder => 'Recordatorio de la fuente de datos';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Días VIP';
  }

  @override
  String get debtCollection => 'Cobro de deudas';

  @override
  String get defaultPeriod => 'Semana';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get deleteContact => 'Eliminar contacto';

  @override
  String deleteContactConfirm(Object name) {
    return '¿Está seguro de que desea eliminar a $name?';
  }

  @override
  String get deleteContactConfirmation =>
      '¿Está seguro de que desea eliminar el contacto?';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '¿Está seguro de que desea eliminar $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Eliminar dispositivo';

  @override
  String deleteFailed(Object error) {
    return 'Error al eliminar: $error';
  }

  @override
  String get deleteFilter => 'Eliminar filtro';

  @override
  String get deleteLabel => 'Eliminar etiqueta';

  @override
  String deleteLabelFailed(Object error) {
    return 'Error al eliminar la etiqueta: $error';
  }

  @override
  String get deletePlugin => 'Eliminar plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Error al eliminar el plugin: $error';
  }

  @override
  String get deletePlugins => 'Eliminar plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Error al eliminar los plugins: $error';
  }

  @override
  String get deleteRule => 'Eliminar regla';

  @override
  String deleteRuleFailed(Object error) {
    return 'Error al eliminar la regla: $error';
  }

  @override
  String get deleteSelected => 'Eliminar selección';

  @override
  String get deleteSmsRule => 'Eliminar regla de SMS';

  @override
  String get deleteSubscription => 'Eliminar suscripción';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '¿Está seguro de que desea eliminar la suscripción \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Error al eliminar la suscripción: $error';
  }

  @override
  String get deleteSuccess => 'Eliminación exitosa';

  @override
  String get delivery => 'Entrega';

  @override
  String get deviceDeletedSuccessfully => 'Dispositivo eliminado correctamente';

  @override
  String get deviceDeletedSuccessfullyMessage =>
      'Dispositivo eliminado correctamente';

  @override
  String get deviceIdLabel => 'ID del dispositivo';

  @override
  String get deviceIDLabel => 'ID del dispositivo';

  @override
  String get deviceManagementSubtitle =>
      'Administrar la sincronización multidispositivo';

  @override
  String get deviceManagementTitle => 'Administración de dispositivos';

  @override
  String get deviceModelLabel => 'Modelo de dispositivo';

  @override
  String get deviceName => 'Nombre del dispositivo';

  @override
  String get deviceNameCannotBeEmpty =>
      'El nombre del dispositivo no puede estar vacío';

  @override
  String get deviceNameHint =>
      'Por favor, introduzca el nombre del dispositivo';

  @override
  String get deviceNameLabel => 'Nombre del dispositivo';

  @override
  String get deviceRenamedSuccessfully => 'Dispositivo renombrado con éxito';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Dispositivo renombrado con éxito';

  @override
  String get devicesSyncedSuccessfully =>
      'Dispositivos sincronizados con éxito';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Dispositivos sincronizados con éxito';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Dispositivos sincronizados con éxito';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Dispositivo dado de baja con éxito';

  @override
  String get dialogTitle => 'Explicación del patrón Regex';

  @override
  String get differentFromLocalCounter =>
      'Esta función es diferente del filtro de contador local, ya que se centra en patrones de llamadas repetidas en un corto período de tiempo en lugar de contar las marcas a largo plazo.';

  @override
  String get disabled => 'Desactivado';

  @override
  String get disabledStatus => 'Desactivado';

  @override
  String get disableGlobalPlugins => 'Desactivar plugins globales';

  @override
  String get disableSubscriptionSuccessfully =>
      'Suscripción desactivada con éxito';

  @override
  String get disconnectButton => 'Desconectar';

  @override
  String get disconnectedMessage => 'Desconectado';

  @override
  String get disconnectedStatus => 'Desconectado';

  @override
  String get disconnectFailedMessage => 'Error al desconectar';

  @override
  String get done => 'Hecho';

  @override
  String get dualSimAdvice =>
      'Esta función es particularmente útil para teléfonos con doble SIM para establecer diferentes estrategias de filtrado para tarjetas SIM de trabajo y personales.';

  @override
  String get earlier => 'Anterior';

  @override
  String get ecommerce => 'Comercio electrónico';

  @override
  String get edit => 'Editar';

  @override
  String get editContact => 'Editar contacto';

  @override
  String get editFilter => 'Editar filtro';

  @override
  String get editLabel => 'Editar etiqueta';

  @override
  String get editPhoneRule => 'Editar regla de teléfono';

  @override
  String get editPhoneRules => 'Se utiliza para editar reglas de teléfono';

  @override
  String get editPhoneRuleTitle => 'Editar regla de teléfono';

  @override
  String get editRule => 'Editar regla';

  @override
  String get editSmsRule => 'Editar regla de SMS';

  @override
  String get education => 'Educación';

  @override
  String get elementPositionsSetting => 'Posiciones de los elementos';

  @override
  String get email => 'Correo electrónico';

  @override
  String get emailOptional => 'Correo electrónico (Opcional)';

  @override
  String get enableCallFilter => 'Habilitar filtro de llamadas';

  @override
  String get enableCallFilterDescription =>
      'Cuando está habilitado, las llamadas entrantes se verifican con la lista de reglas a continuación. Las reglas de filtrado de llamadas no se sincronizan entre dispositivos de forma predeterminada.';

  @override
  String get enabled => 'Activado';

  @override
  String get enabledStatus => 'Activado';

  @override
  String get enableEncryption => 'Habilitar cifrado';

  @override
  String get enableEncryptionDescription =>
      'Cifrar archivos de copia de seguridad';

  @override
  String get enableEncryptionLabel => 'Habilitar cifrado';

  @override
  String get enableEncryptionSubtitle =>
      'Los archivos de copia de seguridad se cifrarán';

  @override
  String get enableEncryptionTitle => 'Habilitar cifrado';

  @override
  String get enableGlobalPlugins => 'Habilitar plugins globales';

  @override
  String get enableLocalCountFilter => 'Habilitar filtro de conteo local';

  @override
  String get enableLocalCountFilterDescription =>
      'Filtrar automáticamente las llamadas de spam según el recuento de marcas de llamadas';

  @override
  String get enableLocalNotification => 'Usar notificación local';

  @override
  String get enableLocalNotificationDescription =>
      'Cuando está habilitado, las notificaciones para mensajes filtrados se mostrarán en el dispositivo';

  @override
  String get enableLocationSummary => 'Ubicación';

  @override
  String get enableMuteRules => 'Habilitar Reglas de Silencio';

  @override
  String get enableMuteRulesDesc =>
      'Aplicar la configuración de reglas de intercepción de silencio';

  @override
  String get enableNoneActionRules => 'Habilitar Reglas Sin Acción';

  @override
  String get enableNoneActionRulesDesc =>
      'Permitir configuraciones de reglas sin acciones de intercepción';

  @override
  String get enableNotifications => 'Habilitar Notificaciones';

  @override
  String get enableRemoteNumberFilter => 'Habilitar Filtro de Número Remoto';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Usar la base de datos remota para filtrar números';

  @override
  String get enableRule => 'Habilitar Regla';

  @override
  String get enableSmsFilter => 'Habilitar Filtrado de SMS';

  @override
  String get enableSmsFilterDescription =>
      'Cuando está habilitado, los mensajes se filtrarán automáticamente según las reglas';

  @override
  String get enableStatisticsNotifications =>
      'Habilitar Notificaciones de Estadísticas';

  @override
  String get enableSubscriptionSuccessfully =>
      'Suscripción habilitada con éxito';

  @override
  String get enableTimeInterception => 'Habilitar Intercepción de Tiempo';

  @override
  String get enableTimeInterceptionDescription =>
      'Interceptar llamadas repetidas en un corto período de tiempo';

  @override
  String get enableTimeInterceptor => 'Habilitar Interceptor de Tiempo';

  @override
  String get endCallImmediately => 'Finalizar llamada inmediatamente';

  @override
  String get endColor => 'Color de Finalización';

  @override
  String get endDate => 'Fecha de Finalización';

  @override
  String get enhancedFilterInstructionsTitle => 'Sistema de Filtro Mejorado';

  @override
  String get enhancedFilterSettings => 'Configuración de Filtro Mejorado';

  @override
  String get enhancedFilterSettingsTitle => 'Configuración de Filtro Mejorado';

  @override
  String get enhancedFilterSystemDescription =>
      'El sistema de filtro mejorado admite tanto reglas globales como configuraciones de filtrado por tarjeta SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Por favor, ingrese tanto el número de teléfono como el patrón regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Por favor, ingrese tanto el número de teléfono como el patrón regex.';

  @override
  String get enterContactName => 'Por favor, ingrese el nombre del contacto';

  @override
  String get enterCurrentPasswordHint =>
      'Por favor, ingrese la contraseña actual';

  @override
  String get enterDeviceName => 'Ingrese el nombre del dispositivo';

  @override
  String get enterDeviceNameHint =>
      'Por favor, ingrese el nombre del dispositivo';

  @override
  String get enterEmail => 'Ingrese el correo electrónico';

  @override
  String get enterEmailOptional => 'Ingrese el correo electrónico (opcional)';

  @override
  String get enterEncryptionPasswordHint =>
      'Ingrese la contraseña de encriptación';

  @override
  String get enterEncryptionPasswordTitle =>
      'Ingrese la Contraseña de Encriptación';

  @override
  String get enterFilterName => 'Por favor, ingrese el nombre del filtro';

  @override
  String get enterFilterPattern => 'Por favor, ingrese el patrón de filtro';

  @override
  String get enterIconCode => 'Ingrese el código del icono';

  @override
  String get enterName => 'Ingrese el nombre del contacto';

  @override
  String get enterNewDeviceNameHint =>
      'Ingrese un nuevo nombre para este dispositivo';

  @override
  String get enterNewPasswordHint => 'Por favor, ingrese la nueva contraseña';

  @override
  String get enterPasswordAgain => 'Ingrese la Contraseña Nuevamente';

  @override
  String get enterPasswordHint => 'Por favor, ingrese la contraseña';

  @override
  String get enterPhoneNumber => 'Ingrese el número de teléfono';

  @override
  String get enterPhoneNumberHint =>
      'Ingrese el número de teléfono para probar';

  @override
  String get enterPhoneNumberMultiple =>
      'Por favor, ingrese el número de teléfono, varios números separados por comas';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Ingrese el número de teléfono para iniciar la búsqueda';

  @override
  String get enterPhoneNumberToVerify =>
      'Ingrese el número de teléfono para verificar';

  @override
  String get enterPluginName => 'Ingrese el Nombre del Plugin';

  @override
  String get enterPluginUrl => 'Ingrese la dirección URL del plugin';

  @override
  String get enterRegexHint => 'Ingrese el patrón regex';

  @override
  String get enterRuleNameAndPattern =>
      'Por favor, ingrese el nombre y el patrón de la regla';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Por favor, introduzca el nombre de la regla y el patrón regex.';

  @override
  String get enterRuleNameHint => 'Introduzca el nombre de la regla';

  @override
  String get enterSearchContent =>
      'Por favor, introduzca el contenido de búsqueda';

  @override
  String get enterSubscriptionName => 'Introduzca el nombre de la suscripción';

  @override
  String get enterSubscriptionUrl => 'Introduzca la URL de la suscripción';

  @override
  String get enterSyncFolderNameHint =>
      'Por favor, introduzca el nombre de la carpeta de sincronización (predeterminado: NotificationManager)';

  @override
  String get entertainment => 'Entretenimiento';

  @override
  String get enterValidNameAndUrl =>
      'Por favor, introduzca un nombre y una URL válidos';

  @override
  String get enterValidUrl => 'Por favor, introduzca una URL válida';

  @override
  String get enterVersion => 'Introducir versión';

  @override
  String get enterWebDAVPasswordHint =>
      'Por favor, introduzca la contraseña de WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Por favor, introduzca la dirección del servidor WebDAV';

  @override
  String get enterWebDAVUsernameHint =>
      'Por favor, introduzca el nombre de usuario de WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Error al eliminar el dispositivo: $error';
  }

  @override
  String get errorLoadingPlugin => 'Error al cargar el plugin';

  @override
  String errorOccurredMessage(Object error) {
    return 'Ocurrió un error: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Error al renombrar el dispositivo: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Error al sincronizar los dispositivos: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Error al sincronizar los dispositivos: $error';
  }

  @override
  String get errorText => 'Error';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Error al anular el registro del dispositivo: $error';
  }

  @override
  String get exampleBlock400Prefix => 'p. ej. Bloquear números con prefijo 400';

  @override
  String get exampleBlockMarketingSms => 'p. ej. Bloquear SMS de marketing';

  @override
  String get exampleContentRegex => 'p. ej., .*oferta.*';

  @override
  String get exampleContentRegexHint => 'Ejemplo de Regex de Contenido';

  @override
  String get exampleCouponPromotionDiscount =>
      'p. ej. .*(cupón|promoción|descuento).*';

  @override
  String get exampleFamilyFriends => 'p. ej. Familia, Amigos, etc.';

  @override
  String get examplePhoneNumber => 'p. ej. 10086, 12345, etc.';

  @override
  String get exampleRegex400Prefix => 'Ejemplo de regex para el prefijo 400';

  @override
  String get exampleRegexFormat => 'Ejemplo: formato ^10086\$';

  @override
  String get exampleSenderRegexHint => 'Ejemplo';

  @override
  String get exchange => 'Intercambio';

  @override
  String get exchangeNow => 'Intercambiar ahora';

  @override
  String get exchangeVip => 'Intercambiar VIP';

  @override
  String get expandLabelSelector => 'Expandir Selector de Etiquetas';

  @override
  String expiryTime(Object time) {
    return 'Tiempo de caducidad: $time';
  }

  @override
  String get export => 'Exportar';

  @override
  String get exportAllApplicationSettings =>
      'Exportar todos los ajustes de la aplicación';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Exportar todos los ajustes de la aplicación';

  @override
  String get exportAllRuleConfigurations =>
      'Exportar todas las configuraciones de reglas';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Exportar todas las configuraciones de reglas';

  @override
  String get exportComplete => 'Exportación completa';

  @override
  String get exportConfig => 'Exportar Configuración';

  @override
  String get exportContacts => 'Exportar Contactos';

  @override
  String get exportData => 'Exportar Datos';

  @override
  String get exportError => 'Error de exportación';

  @override
  String get exportFailed => 'Error al exportar';

  @override
  String get exportFailure => 'Error al exportar la configuración';

  @override
  String get exportFeatureComingSoon =>
      'La función de exportación estará disponible próximamente';

  @override
  String get exporting => 'Exportando...';

  @override
  String get exportLabels => 'Exportar etiquetas';

  @override
  String exportLabelsFailed(Object error) {
    return 'Error al exportar etiquetas: $error';
  }

  @override
  String get exportPluginList => 'Exportar lista de plugins';

  @override
  String exportPluginListFailed(Object error) {
    return 'Error al exportar la lista de plugins: $error';
  }

  @override
  String get exportRules => 'Exportar reglas';

  @override
  String get exportRulesDialogTitle => 'Exportar reglas';

  @override
  String get exportRulesTitle => 'Exportar reglas';

  @override
  String get exportSmsRules => 'Exportar reglas de SMS';

  @override
  String get exportStatisticsData => 'Exportar datos de estadísticas';

  @override
  String get exportSuccess => 'Exportación exitosa';

  @override
  String get exportSuccesslly => 'Configuración exportada correctamente';

  @override
  String get failedToAddContact => 'Error al agregar contacto';

  @override
  String failedToAddRule(Object error) {
    return 'Error al agregar regla: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Error al agregar regla de SMS: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Error al agregar suscripción de SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Error al hacer copia de seguridad de la configuración: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Error al descifrar el archivo de copia de seguridad';

  @override
  String get failedToDeleteDevice => 'Error al eliminar el dispositivo';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Error al eliminar la regla de SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Error al exportar reglas: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Error al exportar reglas de SMS: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Error al obtener información del identificador de llamadas: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Error al importar reglas: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Error al importar reglas de SMS: $error';
  }

  @override
  String get failedToLoadContacts => 'Error al cargar contactos';

  @override
  String get failedToLoadPlugin => 'Error al cargar el plugin';

  @override
  String get failedToRenameDevice =>
      'Error al cambiar el nombre del dispositivo';

  @override
  String get failedToRestoreSettings => 'Error al restaurar la configuración';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Error al restaurar la configuración: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Error al establecer la contraseña: $error';
  }

  @override
  String get failedToSyncDevices => 'Error al sincronizar dispositivos';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Error al cambiar el estado de la regla: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Error al cambiar el estado de la suscripción';

  @override
  String get failedToUpdateContact => 'Error al actualizar el contacto';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Error al actualizar la regla de SMS: $error';
  }

  @override
  String get failure => 'Error';

  @override
  String get favoriteContacts => 'Contactos favoritos';

  @override
  String get featureAddRules =>
      '• Agregar reglas específicas para números de teléfono';

  @override
  String get featureCenter => 'Centro de funciones';

  @override
  String get featureEnableDisable =>
      '• Activar/desactivar diferentes filtros por SIM';

  @override
  String get featureListTitle => 'Funciones:';

  @override
  String get featureManageRules => '• Administrar listas de reglas por SIM';

  @override
  String get features => 'Funciones';

  @override
  String get fetchingCallerIdInfo =>
      'Obteniendo información del identificador de llamadas...';

  @override
  String fileSavedTo(Object path) {
    return 'Archivo guardado en: $path';
  }

  @override
  String get filter => 'Filtrar';

  @override
  String get filterByLabel => 'Filtrar por etiqueta';

  @override
  String get filterClear => 'Borrar filtro';

  @override
  String get filterControlPanelTitle => 'Panel de control de filtros';

  @override
  String get filterControlSubtitle =>
      'Administrar el estado de encendido/apagado de todos los filtros';

  @override
  String get filterControlTitle => 'Control de filtro';

  @override
  String get filterDeleteFailed => 'Error al eliminar el filtro';

  @override
  String get filterDeleteSuccess => 'Filtro eliminado correctamente';

  @override
  String get filterDetails => 'Detalles del filtro';

  @override
  String get filtered => 'Filtrado';

  @override
  String get filteredSms => 'SMS filtrados';

  @override
  String get filteredSmsLabel => 'SMS filtrados';

  @override
  String get filterExplanation => 'Explicación del filtro';

  @override
  String get filterManagement => 'Gestión de filtros';

  @override
  String get filterName => 'Nombre del filtro';

  @override
  String get filterPattern => 'Patrón del filtro';

  @override
  String get filterPriorityNote =>
      'Nota: Existen relaciones de prioridad entre los filtros, consulte la documentación de ayuda para obtener más detalles.';

  @override
  String get filterSaveFailed => 'Error al guardar el filtro';

  @override
  String get filterSaveSuccess => 'Filtro guardado correctamente';

  @override
  String get filterSettings => 'Ajustes del filtro';

  @override
  String get filterSettingsTitle => 'Ajustes del filtro';

  @override
  String get filterSMS => 'Filtrar SMS';

  @override
  String get filterToggleInstructions =>
      'Activar o desactivar los filtros para esta ranura SIM:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filtro: $filterName';
  }

  @override
  String get filterType => 'Tipo de filtro';

  @override
  String get financial => 'Financiero';

  @override
  String get flexibleCombinationFeature =>
      '• Combinaciones flexibles: Activar/desactivar filtros por ranura SIM';

  @override
  String get fontSizesSetting => 'Tamaños de fuente';

  @override
  String foundRules(Object count) {
    return 'Se encontraron $count reglas';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Se encontraron $count reglas. ¿Desea importarlas?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Se encontraron $count reglas. ¿Desea importarlas?';
  }

  @override
  String get fraudAlert => 'ALERTA DE FRAUDE: cuelgue la llamada';

  @override
  String get fraudScamLikely => 'Es probable que sea un fraude o una estafa';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Ajustes de función';

  @override
  String generalUpdateFailure(Object error) {
    return 'Error al actualizar: $error';
  }

  @override
  String get getFree => 'Obtener gratis';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Configurar filtros globales para todas las tarjetas SIM:';

  @override
  String get globalFilterFeature =>
      '• Filtros globales: Reglas básicas para todas las llamadas entrantes';

  @override
  String get globalFilterSettings => 'Ajustes del filtro global';

  @override
  String get globalFilterToggleInstructions =>
      'Configurar ajustes de filtro global que se aplican a todas las ranuras SIM:';

  @override
  String get globalSearchSubtitle =>
      'Buscar contactos, etiquetas, listas negras, listas blancas, etc.';

  @override
  String get globalSearchTitle => 'Búsqueda global';

  @override
  String get globalSettings => 'Ajustes globales';

  @override
  String get googleAdDisplayPosition =>
      'Posición de visualización de anuncios de Google';

  @override
  String get googleAdMobIntegrationText =>
      'Los anuncios de Google AdMob se pueden integrar aquí';

  @override
  String get googleDriveAuthDescription =>
      'Autorizar usando el ID de cliente y la clave de Google Drive configurados por el sistema';

  @override
  String get googleDriveAuthorizationHint =>
      'Autorizar usando el ID de cliente y la clave de Google Drive configurados por el sistema';

  @override
  String get googleDriveConfigTitle => 'Configuración de Google Drive';

  @override
  String get googleDriveConfigurationTitle => 'Configuración de Google Drive';

  @override
  String get government => 'Gobierno';

  @override
  String get granted => 'Concedido';

  @override
  String get grantNecessaryPermissions => 'Conceder los permisos necesarios';

  @override
  String get grantPermissions => 'Conceder permisos';

  @override
  String get headhunter => 'Cazatalentos';

  @override
  String get height => 'Altura';

  @override
  String get homePageTitle => 'Página de inicio';

  @override
  String get homeTab => 'Inicio';

  @override
  String get howItWorksPoint1 =>
      '• El sistema permitirá automáticamente las llamadas del mismo número dentro del período de tiempo establecido';

  @override
  String get howItWorksPoint2 =>
      '• Los períodos de tiempo más cortos resultan en una intercepción más estricta; los períodos de tiempo más largos resultan en una intercepción más flexible';

  @override
  String get howItWorksPoint3 =>
      '• El sistema verifica los registros de llamadas para determinar si es una llamada repetida';

  @override
  String get howItWorksTitle => 'Cómo funciona:';

  @override
  String get iconCodeOptional => 'Código de icono (opcional)';

  @override
  String get iconSize => 'Tamaño del icono';

  @override
  String get import => 'Importar';

  @override
  String get important => 'Importante';

  @override
  String get importButton => 'Importar';

  @override
  String get importConfig => 'Importar configuración';

  @override
  String get importContacts => 'Importar contactos';

  @override
  String get importExportContacts => 'Importar/Exportar contactos';

  @override
  String get importExportContactsTooltip => 'Importar/Exportar contactos';

  @override
  String get importExportRules => 'Importar/Exportar reglas';

  @override
  String importFailed(Object error) {
    return 'Error al importar: $error';
  }

  @override
  String get importFailure => 'Error al importar la configuración';

  @override
  String get importFeatureComingSoon =>
      'La función de importación estará disponible próximamente';

  @override
  String get importLabels => 'Importar etiquetas';

  @override
  String importLabelsFailed(Object error) {
    return 'Error al importar etiquetas: $error';
  }

  @override
  String get importPluginList => 'Importar lista de plugins';

  @override
  String importPluginListFailed(Object error) {
    return 'Error al importar la lista de plugins: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Se importaron $count plugins correctamente';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importar configuraciones de reglas desde un archivo';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Importar configuraciones de reglas desde un archivo';

  @override
  String get importRules => 'Importar reglas';

  @override
  String get importRulesButton => 'Importar reglas';

  @override
  String get importRulesDialogTitle => 'Importar reglas';

  @override
  String importRulesError(Object error) {
    return 'Error al importar reglas: $error';
  }

  @override
  String get importRulesInstructions => 'Importar reglas desde un archivo CSV';

  @override
  String get importRulesSuccess => 'Reglas importadas correctamente';

  @override
  String get importRulesTitle => 'Importar reglas';

  @override
  String get importSuccess => 'Importación exitosa';

  @override
  String get incomingCallInterceptAction =>
      'Acción de intercepción de llamada entrante';

  @override
  String get incomingCallNotification => 'Notificación de llamada entrante';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get initializing => 'Inicializando';

  @override
  String get installed => 'Instalado';

  @override
  String get insufficientMarks => 'Marcas insuficientes';

  @override
  String get insurance => 'Seguro';

  @override
  String get interceptAction => 'Acción de intercepción';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Establecer cómo se manejan las llamadas bloqueadas';

  @override
  String get interceptionActionSettingsTitle =>
      'Configuración de acción de intercepción';

  @override
  String get interceptionTimeInterval => 'Intervalo de tiempo de intercepción';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Intervalo de actualización de $service establecido en $days días';
  }

  @override
  String get invalidContentRegex => 'Regex de contenido no válido';

  @override
  String get invalidLabel => 'Etiqueta no válida';

  @override
  String get invalidRegexPattern => 'Patrón regex no válido';

  @override
  String get invalidSenderRegex => 'Regex de remitente no válida';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Únete al Canal y Grupo de Telegram para más información';

  @override
  String get jsLogsTitle => 'Registros JS';

  @override
  String get jsonFormat => 'Formato JSON';

  @override
  String get keepAllVersions => 'Conservar todas las versiones';

  @override
  String get keepAllVersionsDescription =>
      'Conserva todas las versiones históricas de cada copia de seguridad';

  @override
  String get keepAllVersionsLabel => 'Conservar todas las versiones';

  @override
  String get keepAllVersionsSubtitle =>
      'Conserva las versiones históricas de cada copia de seguridad';

  @override
  String get keepAllVersionsTitle => 'Conservar todas las versiones';

  @override
  String get label => 'Etiqueta';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Etiqueta \"$name\" añadida correctamente';
  }

  @override
  String get labelCategories => 'Categorías de etiquetas';

  @override
  String get labelDeleted => 'Etiqueta eliminada';

  @override
  String get labelDescription =>
      'Las etiquetas te ayudan a administrar mejor los contactos, añade etiquetas personalizadas a los números de teléfono para una fácil identificación de llamadas y mensajes.';

  @override
  String get labelFilter => 'Filtro de etiquetas';

  @override
  String get labelFilterTooltip => 'Filtro de etiquetas';

  @override
  String get labelIconColor => 'Color del icono de la etiqueta';

  @override
  String get labelManagement => 'Administración de etiquetas';

  @override
  String get labelNotFound => 'Etiqueta no encontrada';

  @override
  String get labelRemoved => 'Etiqueta eliminada';

  @override
  String labelRemoveFailed(Object error) {
    return 'Error al eliminar la etiqueta: $error';
  }

  @override
  String get labels => 'Etiquetas';

  @override
  String get labelsColor => 'Color de las etiquetas';

  @override
  String labelsDeleted(Object count) {
    return '$count etiquetas eliminadas';
  }

  @override
  String get labelsExportedSuccessfully => 'Etiquetas exportadas correctamente';

  @override
  String get labelsFontSize => 'Tamaño de fuente de las etiquetas';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Se importaron $count etiquetas correctamente';
  }

  @override
  String get labelsPosition => 'Posición de las etiquetas';

  @override
  String labelTag(Object labelId) {
    return 'Etiqueta: $labelId';
  }

  @override
  String get labelUpdated => 'Etiqueta actualizada';

  @override
  String labelUpdateFailed(Object error) {
    return 'Error al actualizar la etiqueta: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Etiqueta \"\$labelText\" actualizada correctamente';

  @override
  String get languageSettings => 'Ajustes de idioma';

  @override
  String get languageSettingsSubtitle =>
      'Cambiar el idioma de visualización de la aplicación';

  @override
  String get languageSettingsTitle => 'Ajustes de idioma';

  @override
  String get last30Days => 'Últimos 30 días';

  @override
  String get last7Days => 'Últimos 7 días';

  @override
  String get lastSyncLabel => 'Última sincronización';

  @override
  String lastUpdated(Object date) {
    return 'Última actualización: $date';
  }

  @override
  String get lifetimeMembership => 'Membresía de por vida';

  @override
  String get lifetimeMembershipDescription =>
      'Compra única, desbloquea permanentemente todas las funciones premium y futuras actualizaciones';

  @override
  String loadContactsFailed(Object error) {
    return 'Error al cargar los contactos: $error';
  }

  @override
  String get loadDataFailed => 'Error al cargar los datos';

  @override
  String get loadFailed => 'Error al cargar';

  @override
  String get loading => 'Cargando...';

  @override
  String get loadingData => 'Cargando datos...';

  @override
  String get loadingTags => 'Cargando etiquetas...';

  @override
  String loadLabelFailed(Object error) {
    return 'Error al cargar las etiquetas: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Error al cargar las etiquetas: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Error al cargar los números de teléfono marcados: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Error al cargar los teléfonos marcados: $error';
  }

  @override
  String get loadMore => 'Cargar más';

  @override
  String get loadPluginButton => 'Cargar plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Error al cargar los plugins: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Error al cargar la configuración: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Error al cargar las reglas de SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Error al cargar el estado';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Error al cargar las suscripciones: $error';
  }

  @override
  String get loan => 'Préstamo';

  @override
  String get localBackupTitle => 'Copia de seguridad local';

  @override
  String get localCounterFilter => 'Filtro de contador local';

  @override
  String get localCounterFilterSubtitle =>
      'Filtrar automáticamente las llamadas spam según la frecuencia de las llamadas';

  @override
  String get localCountFilter => 'Filtro de conteo local';

  @override
  String get localCountFilterDescription =>
      'Interceptar llamadas frecuentes basadas en el conteo de números locales';

  @override
  String get localCountFilterExplanationContent =>
      'El filtro de conteo local analiza los registros del historial de llamadas para identificar y bloquear automáticamente las llamadas spam frecuentes.';

  @override
  String get localCountFilterExplanationTitle =>
      'Explicación del filtro de conteo local';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Determine si desea bloquear según el valor de conteo del número';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Cuando el conteo de un número supera el umbral establecido, puede optar por bloquearlo automáticamente';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Puede permitir selectivamente los números que no superen el umbral';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Puede elegir si desea registrar todos los registros de consultas';

  @override
  String get localCountFiltering => 'Filtrado de conteo local';

  @override
  String get localCountFilteringExplanation =>
      '• Filtrado de conteo local: reglas de filtrado basadas en el conteo de marcado local';

  @override
  String get localCountFilterSettings =>
      'Configuración del filtro de conteo local';

  @override
  String get localCountFilterUseCases =>
      'Este filtro es particularmente adecuado para identificar llamadas spam con marcación automática y llamadas de marketing.';

  @override
  String get localFilterSettings => 'Configuración del filtro local';

  @override
  String get localNotificationDisabled => 'Notificación local desactivada';

  @override
  String get localNotificationEnabled => 'Notificación local activada';

  @override
  String get localServices => 'Servicios locales';

  @override
  String get locationColor => 'Color de la ubicación';

  @override
  String get locationFontSize => 'Tamaño de fuente de la ubicación';

  @override
  String get locationIconColor => 'Color del icono de ubicación';

  @override
  String get locationPosition => 'Posición de la ubicación';

  @override
  String get logAllLocalQueries => 'Registrar todas las consultas locales';

  @override
  String get logAllLocalQueriesDescription =>
      'Registrar registros para todas las consultas de números locales';

  @override
  String get logAllRemoteQueries => 'Registrar todas las consultas remotas';

  @override
  String get logAllRemoteQueriesDescription =>
      'Registrar todas las operaciones de consulta de números remotos';

  @override
  String get manage => 'Administrar contactos';

  @override
  String get manageContacts => 'Administrar';

  @override
  String get manageFavoriteContacts => 'Administrar contactos favoritos';

  @override
  String get manageFilterRules => 'Administrar reglas de filtro';

  @override
  String get manageFilterRulesDescription =>
      'Agregar, editar o eliminar reglas de filtro de SMS';

  @override
  String get manageFrequentContacts => 'Administrar contactos frecuentes';

  @override
  String get markCounts => 'Recuentos de marcas';

  @override
  String get markCount => 'Recuento de marcas';

  @override
  String markedByCount(Object count) {
    return 'Marcado por $count';
  }

  @override
  String get markedPhonesList => 'Números de teléfono marcados';

  @override
  String get markExchange => 'Marcar intercambio';

  @override
  String get markPhone => 'Marcar número de teléfono';

  @override
  String markPhoneFailed(Object error) {
    return 'Error al marcar el número de teléfono: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'Para marcar números de teléfono';

  @override
  String get markPhoneManagementTitle => 'Administración de marcado';

  @override
  String get markPhoneSuccess => 'Número de teléfono marcado correctamente';

  @override
  String get matchFailed => '¡La coincidencia falló!';

  @override
  String get matchFailedMessage => 'La coincidencia falló.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'coincide con un formato de número específico';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Coincidir números con caracteres especiales:';

  @override
  String get matchSpecificDigitPatterns =>
      'coincide con el formato XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Coincidir patrones de dígitos específicos:';

  @override
  String get matchSuccessful => '¡Coincidencia exitosa!';

  @override
  String get matchSuccessfulMessage => '¡Coincidencia exitosa!';

  @override
  String get medical => 'Médico';

  @override
  String get membershipPrivileges => 'Privilegios de membresía';

  @override
  String get migrationTool => 'Herramienta de migración';

  @override
  String get migrationToolTitle => 'Herramienta de migración';

  @override
  String get minutes => 'minutos';

  @override
  String get month => 'Mes';

  @override
  String get monthly => 'Mensual';

  @override
  String get monthlyCallCount => 'Llamadas mensuales';

  @override
  String get monthlyChartTitle => 'Llamadas bloqueadas mensuales';

  @override
  String get monthlyMembership => 'Membresía mensual';

  @override
  String get monthlyMembershipDescription =>
      'Desbloquea todas las funciones premium, renovación automática mensual';

  @override
  String get monthlyTotal => 'Total mensual';

  @override
  String get monthlyTotalLabel => 'Total mensual';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get mute => 'Silenciar';

  @override
  String get name => 'Nombre';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'El nombre y el número de teléfono no pueden estar vacíos';

  @override
  String get nameAndPhoneNumberRequired =>
      'El nombre y el número de teléfono no pueden estar vacíos';

  @override
  String get nameColor => 'Color del nombre';

  @override
  String get nameFontSize => 'Tamaño de fuente del nombre';

  @override
  String nameLabel(Object name) {
    return 'Nombre: $name';
  }

  @override
  String get namePosition => 'Posición del nombre';

  @override
  String get nameUnknown => 'Nombre: Desconocido';

  @override
  String nameWithValue(String name) {
    return 'Nombre: $name';
  }

  @override
  String get newPasswordLabel => 'Nueva contraseña';

  @override
  String get nextStep => 'Siguiente';

  @override
  String get noAction => 'Sin acción';

  @override
  String get noActionRules => 'Sin reglas de acción';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'No hay ningún servicio de sincronización en la nube activo';

  @override
  String get noCallLogs => 'Sin registros de llamadas';

  @override
  String get noCallRecords => 'Sin registros de llamadas';

  @override
  String get noContacts => 'Aún no hay contactos';

  @override
  String get noContactsYet => 'Aún no hay contactos';

  @override
  String get noData => 'Sin datos';

  @override
  String get noDevicesRegisteredMessage => 'No hay dispositivos registrados';

  @override
  String get noDevicesRegisteredYet => 'Aún no hay dispositivos registrados.';

  @override
  String get noFilters => 'Aún no hay filtros';

  @override
  String get noLabels => 'Aún no hay etiquetas';

  @override
  String get noMarkedPhones => 'No hay números de teléfono marcados';

  @override
  String get noMatchingContacts => 'No hay contactos coincidentes';

  @override
  String get noMatchingContactsFound =>
      'No se encontraron contactos coincidentes';

  @override
  String get noMatchingNumbersFound => 'No se encontraron números coincidentes';

  @override
  String get noMatchingRecords => 'No hay registros de llamadas coincidentes';

  @override
  String noMatchingRules(Object ruleType) {
    return 'No hay $ruleType coincidentes';
  }

  @override
  String get none => 'Ninguno';

  @override
  String get noneServiceType => 'Ninguno';

  @override
  String get noPlugins => 'Aún no hay plugins';

  @override
  String get noRecords => 'No hay registros de llamadas';

  @override
  String get noResultReturned => 'No se devolvió ningún resultado';

  @override
  String get noResultReturnedLog =>
      'No se devolvió ningún resultado del plugin';

  @override
  String noRules(Object ruleType) {
    return 'Aún no hay $ruleType';
  }

  @override
  String get noRulesPrompt =>
      'No se encontraron reglas, por favor agregue reglas';

  @override
  String get noRulesToExport => 'No hay reglas para exportar';

  @override
  String get noSmsFilterRulesYet => 'Aún no hay reglas de filtro de SMS';

  @override
  String get noSmsRulesYet => 'Aún no hay reglas de SMS';

  @override
  String get noSubscriptions => 'No hay suscripciones';

  @override
  String get noSubscriptionsYet => 'Aún no hay suscripciones';

  @override
  String get notGranted => 'No concedido';

  @override
  String get notificationModeDescription =>
      'Mostrar información de la persona que llama en la barra de notificaciones';

  @override
  String get notificationPermission => 'Permiso de notificación';

  @override
  String get notificationPermissionDescription =>
      'Se utiliza para mostrar las notificaciones de llamadas y mensajes entrantes.';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationSettings => 'Configuración de notificaciones';

  @override
  String get notificationSettingsSaved =>
      'Configuración de notificaciones guardada correctamente';

  @override
  String get notSet => 'No establecido';

  @override
  String get notVerifiedText => 'No verificado';

  @override
  String get noValidSmsRulesFoundInFile =>
      'No se encontraron reglas de SMS válidas en el archivo';

  @override
  String get number => 'Número';

  @override
  String get numberColor => 'Color del número';

  @override
  String get numberFontSize => 'Tamaño de fuente del número';

  @override
  String get numberPosition => 'Posición del número';

  @override
  String get numberSearch => 'Búsqueda de número';

  @override
  String get numberTypeColor => 'Color del tipo de número';

  @override
  String get numberTypeFontSize => 'Tamaño de fuente del tipo de número';

  @override
  String get numberTypePosition => 'Posición del tipo de número';

  @override
  String get ok => 'Aceptar';

  @override
  String get okButton => 'Aceptar';

  @override
  String get onboardingCompleteDescription =>
      'Su administrador de seguridad de llamadas está listo, ¡comience a disfrutar de una experiencia de llamadas segura!';

  @override
  String get onboardingLanguageDescription =>
      'Elija su idioma preferido para la mejor experiencia.';

  @override
  String get onboardingPermissionsDescription =>
      'Para brindar un servicio completo, necesitamos los siguientes permisos:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Bloqueo con un clic de llamadas y mensajes de spam, personalice las reglas de bloqueo y brinde un entorno tranquilo.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identifique automáticamente las llamadas desconocidas, marque los números sospechosos y proteja la seguridad de sus llamadas.';

  @override
  String get onboardingWelcomeDescription =>
      'Su experto en administración de llamadas, que brinda servicios integrales de identificación y bloqueo de llamadas.';

  @override
  String get oneDriveAuthDescription =>
      'Autorizar usando la clave y el ID de cliente de OneDrive configurados por el sistema';

  @override
  String get oneDriveAuthorizationHint =>
      'Autorizar usando la clave y el ID de cliente de OneDrive configurados por el sistema';

  @override
  String get oneDriveConfigTitle => 'Configuración de OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'Configuración de OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Suscripción al identificador de llamadas en línea';

  @override
  String get openAppSettings => 'Abrir la configuración de la aplicación';

  @override
  String openAppSettingsFailed(Object error) {
    return 'No se pudo abrir la configuración de la aplicación: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operación fallida: $error';
  }

  @override
  String get operationFailure => 'Operación fallida';

  @override
  String get operationSuccess => 'Operación exitosa';

  @override
  String get other => 'Otro';

  @override
  String get ourOtherApps => 'Nuestras otras aplicaciones';

  @override
  String get overlayMode => 'Ventana flotante';

  @override
  String get overlayModeDescription =>
      'Mostrar información de la persona que llama en una ventana flotante';

  @override
  String get overlayPermission => 'Permiso de superposición';

  @override
  String get overlayPermissionDescription =>
      'Se utiliza para mostrar la superposición de llamadas entrantes.';

  @override
  String get overview => 'Resumen';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordCannotBeEmpty => 'La contraseña no puede estar vacía';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get passwordSetSuccessfully => 'Contraseña establecida correctamente';

  @override
  String get pattern => 'Patrón';

  @override
  String get pendingSync => 'Sincronización pendiente';

  @override
  String get periodMonth => 'Mes';

  @override
  String get periodWeek => 'Semana';

  @override
  String get periodYear => 'Año';

  @override
  String get permissionDenied => 'Solicitud de permiso denegada';

  @override
  String get permissionGranted => 'Permiso concedido';

  @override
  String get permissionManagement => 'Gestión de permisos';

  @override
  String get phoneCallsTab => 'Teléfono';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get phoneNumberCannotBeEmpty =>
      'El número de teléfono no puede estar vacío';

  @override
  String get phoneNumberHintText =>
      'Ingrese el número de teléfono para agregar la regla';

  @override
  String get phoneNumberLabel => 'Número de teléfono';

  @override
  String get phoneNumberRegexRequired =>
      'Por favor, ingrese el número de teléfono y el patrón regex';

  @override
  String get phoneNumberTypeFixedLine => 'Línea fija';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Fijo o móvil';

  @override
  String get phoneNumberTypeMobile => 'Móvil';

  @override
  String get phoneNumberTypePager => 'Buscapersonas';

  @override
  String get phoneNumberTypePersonalNumber => 'Número personal';

  @override
  String get phoneNumberTypePremiumRate => 'Tarifa premium';

  @override
  String get phoneNumberTypeSharedCost => 'Costo compartido';

  @override
  String get phoneNumberTypeTollFree => 'Llamada gratuita';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Desconocido';

  @override
  String get phoneNumberTypeVoicemail => 'Correo de voz';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Permiso telefónico';

  @override
  String get phonePermissionDescription =>
      'Se utiliza para identificar y bloquear las llamadas entrantes.';

  @override
  String get phoneRule => 'Regla de teléfono';

  @override
  String get phoneRuleEditDialog => 'Diálogo de edición de regla de teléfono';

  @override
  String get phoneRuleManagement => 'Gestión de reglas telefónicas';

  @override
  String get phoneRuleSubscription => 'Suscripción a reglas telefónicas';

  @override
  String get phoneSubscription => 'Suscripción telefónica';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Suscríbase a listas de reglas telefónicas a través de URL para actualizar automáticamente las reglas de la lista blanca y la lista negra. Admite archivos de reglas en formato JSON.';

  @override
  String get phoneSubscriptionTitle => 'Suscripciones a reglas telefónicas';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Por favor, seleccione una etiqueta e introduzca un número de teléfono válido';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" añadido correctamente';
  }

  @override
  String get pluginDeleted => 'Plugin eliminado';

  @override
  String get pluginLatestVersion => 'El plugin ya está en la última versión';

  @override
  String get pluginListExportSuccess =>
      'Lista de plugins exportada correctamente';

  @override
  String get pluginLoadedSuccessfully => 'Plugin cargado correctamente';

  @override
  String get pluginManagement => 'Gestión de plugins';

  @override
  String get pluginManagementSubtitle =>
      'Administre y configure plugins de terceros';

  @override
  String get pluginManagementTitle => 'Gestión de plugins';

  @override
  String get pluginName => 'Nombre del plugin';

  @override
  String get pluginNotLoaded =>
      'El plugin aún no está cargado. Por favor, cargue el plugin primero.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins eliminados correctamente.';
  }

  @override
  String get pluginService => 'Servicio de plugins';

  @override
  String get pluginTestPageTitle => 'Prueba de plugin';

  @override
  String get pluginUpdateSuccess => 'Plugin actualizado correctamente';

  @override
  String get pluginUrl => 'URL del plugin';

  @override
  String get pluginUrlCannotBeEmpty => 'La URL del plugin no puede estar vacía';

  @override
  String get pluginUrlHint => 'Introduzca la URL del plugin';

  @override
  String get pluginUrlLabel => 'URL del plugin';

  @override
  String get pluginVersion => 'Versión del plugin';

  @override
  String get political => 'Político';

  @override
  String get powerfulSpamBlocking => 'Bloqueo de spam potente';

  @override
  String get previousStep => 'Anterior';

  @override
  String get prioritizeRemoteAction =>
      'Priorizar la configuración de acción remota';

  @override
  String get prioritizeRemoteActionDescription =>
      'Priorizar la configuración de acciones desde la base de datos remota';

  @override
  String get processing => 'Procesando...';

  @override
  String get processingOperation => 'Procesando...';

  @override
  String get purchase => 'Comprar';

  @override
  String get quarterlyMembership => 'Membresía trimestral';

  @override
  String get quarterlyMembershipDescription =>
      'Desbloquea todas las funciones premium, renovación automática trimestral';

  @override
  String get queryButton => 'Consultar';

  @override
  String get queryFailed => 'Error en la consulta';

  @override
  String get queryFailedLog => 'Error en la consulta';

  @override
  String get querying => 'Consultando...';

  @override
  String get queryingPhoneNumber => 'Consultando número de teléfono';

  @override
  String get queryResultTitle => 'Resultado de la consulta';

  @override
  String get ready => '¡Listo!';

  @override
  String get receiveWeeklyStatistics => 'Recibir estadísticas semanales';

  @override
  String get recruiter => 'Reclutador';

  @override
  String get reEnterPasswordHint =>
      'Por favor, vuelva a introducir la contraseña';

  @override
  String get refresh => 'Actualizar';

  @override
  String get refreshPermissionStatus => 'Actualizar el estado del permiso';

  @override
  String get refreshTooltip => 'Actualizar';

  @override
  String regexError(Object error) {
    return 'Error de Regex: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Error de Regex: $error';
  }

  @override
  String get regexPattern => 'Patrón Regex';

  @override
  String get regexPatternExplanation => 'Explicación del patrón Regex';

  @override
  String get regexPatternExplanationButton => 'Explicación del patrón Regex';

  @override
  String get regexPatternLabel => 'Patrón Regex';

  @override
  String get regexPatternsExamples =>
      'Utilice la sintaxis regex estándar para definir patrones. Ejemplos:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Patrones Regex para la coincidencia de números de teléfono';

  @override
  String get regexRule => 'Regla Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Error al agregar la regla regex: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regla regex agregada correctamente';

  @override
  String get regexRuleManagement => 'Gestión de reglas Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'El nombre de la regla y el patrón regex no pueden estar vacíos';

  @override
  String get regexRules => 'Reglas Regex';

  @override
  String get regexTesterTitle => 'Probador Regex';

  @override
  String regexValidationFailed(Object error) {
    return 'Error en la validación regex: $error';
  }

  @override
  String get regexValidationSuccess => 'Validación regex exitosa';

  @override
  String get region => 'Región';

  @override
  String get registeredDevicesTitle => 'Dispositivos Registrados';

  @override
  String get rejectAllCalls => 'Rechazar todas las llamadas';

  @override
  String get rejectAllCallsDescription =>
      'Cuando está habilitado, todas las llamadas se rechazarán con la máxima prioridad';

  @override
  String get rejectAllNumbers => 'Rechazar todos los números';

  @override
  String get rejectAllNumbersDesc =>
      'Rechazar todas las llamadas entrantes cuando esté habilitado';

  @override
  String get rejectExceededNumbers => 'Rechazar números excedidos';

  @override
  String get rejectExceededNumbersDescription =>
      'Rechaza automáticamente los números que exceden el umbral de conteo';

  @override
  String get remoteFilterSettings => 'Ajustes del filtro remoto';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Ajustes del filtro de números remotos';

  @override
  String get remoteNumberFilter => 'Filtro de números remotos';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Este filtro utiliza una base de datos remota independiente para obtener la información de números más reciente.';

  @override
  String get remoteNumberFilterDescription =>
      'Intercepta las llamadas de acoso basadas en la información de la base de datos remota';

  @override
  String get remoteNumberFilterExplanationContent =>
      'El filtro de números remotos identifica y bloquea las llamadas de spam consultando una base de datos remota basada en el recuento de números.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Explicación del filtro de números remotos';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Umbral de conteo: Determine según la frecuencia de aparición del número';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Acciones de filtro: Configure cómo manejar los números que exceden el umbral';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Ajustes de prioridad: Establezca la prioridad para las acciones remotas';

  @override
  String get remoteNumberFilterFeatures => 'Características:';

  @override
  String get remoteNumberFiltering => 'Filtrado de números remotos';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Filtrado de números remotos: Reglas de filtrado basadas en información de la base de datos remota';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifique llamadas de spam utilizando la base de datos en la nube y los informes de la comunidad';

  @override
  String get removeAdsDescription =>
      'Elimina permanentemente todos los anuncios en la aplicación para una experiencia más fluida';

  @override
  String get removeAdsTitle => 'Eliminar anuncios';

  @override
  String get removedFromFavoriteContacts =>
      'Eliminado de los contactos favoritos';

  @override
  String get removedFromFavorites => 'Eliminado de los contactos favoritos';

  @override
  String get removeFavorite => 'Eliminar favorito';

  @override
  String get removeFromFavorites => 'Eliminar de favoritos';

  @override
  String get renameButton => 'Renombrar';

  @override
  String get renameDeviceDialogTitle => 'Renombrar dispositivo';

  @override
  String get renameDeviceTitle => 'Renombrar dispositivo';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Esto reemplazará todos sus ajustes actuales. ¿Está seguro de que quiere continuar?';

  @override
  String get requestAllPermissions => 'Solicitar todos los permisos';

  @override
  String get requestPermission => 'Solicitar permiso';

  @override
  String requestPermissionFailed(Object error) {
    return 'Error al solicitar el permiso: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Marcas';
  }

  @override
  String get reset => 'Restablecer';

  @override
  String get restore => 'Restaurar';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Restaurar la configuración de la aplicación desde la copia de seguridad';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Restaurar la configuración de la aplicación desde la copia de seguridad';

  @override
  String get restoreButton => 'Restaurar';

  @override
  String restoreFailedWithError(Object error) {
    return 'Error al restaurar desde la nube: $error';
  }

  @override
  String get restoreFromCloud => 'Restaurar desde la nube';

  @override
  String get restoreFromCloudDescription =>
      'Restaurar la configuración y las reglas desde el almacenamiento en la nube';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Error al restaurar desde la nube: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Restaurar desde la nube';

  @override
  String get restoreFromCloudSuccess =>
      'Restaurado correctamente desde la nube';

  @override
  String get restoreFromCloudTitle => 'Restaurar desde la nube';

  @override
  String get restoreFromLocal => 'Restaurar desde local';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get restoreSectionTitle => 'Restaurar';

  @override
  String get restoreSettings => 'Restaurar configuración';

  @override
  String get restoreSettingsConfirmation =>
      'Esto reemplazará toda su configuración actual. ¿Está seguro de que desea continuar?';

  @override
  String get restoreSettingsDialogTitle => 'Restaurar configuración';

  @override
  String get restoreSettingsTitle => 'Restaurar configuración';

  @override
  String get restoreSuccessFromLocal => 'Restaurado correctamente desde local';

  @override
  String get restoreSuccessMessage => 'Restaurado correctamente desde la nube';

  @override
  String get retry => 'Reintentar';

  @override
  String get ridesharing => 'Viajes compartidos';

  @override
  String get risk => 'Riesgo';

  @override
  String get robocall => 'Llamada automática';

  @override
  String get ruleAction => 'Acción de regla';

  @override
  String get ruleAddButton => 'Agregar regla';

  @override
  String get ruleAddedSuccess => 'Regla agregada con éxito';

  @override
  String ruleAddFailure(Object error) {
    return 'Error al agregar regla: $error';
  }

  @override
  String get ruleAddSuccess => 'Regla agregada con éxito';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return '¿Está seguro de que desea eliminar este $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Eliminar regla';

  @override
  String get ruleDeletedSuccess => 'Regla eliminada con éxito';

  @override
  String get ruleDeletedSuccessfully => 'Regla eliminada con éxito';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Error al eliminar regla: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Error al eliminar regla: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regla eliminada con éxito';

  @override
  String get ruleDisabledSuccessfully => 'Regla deshabilitada con éxito';

  @override
  String get ruleEnabledSuccessfully => 'Regla habilitada con éxito';

  @override
  String ruleLoadFailed(Object error) {
    return 'Error al cargar reglas: $error';
  }

  @override
  String get ruleManagement => 'Gestión de reglas';

  @override
  String get ruleManagementTitle => 'Gestión de reglas';

  @override
  String get ruleName => 'Nombre de la regla';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'El nombre de la regla y la expresión regular del contenido no pueden estar vacíos';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'El nombre de la regla y el número de teléfono no pueden estar vacíos';

  @override
  String get ruleNameHint => 'p. ej., Familia, Amigos, etc.';

  @override
  String get ruleNameLabel => 'Nombre de la regla';

  @override
  String get ruleNamePatternRequired =>
      'Por favor, introduzca el nombre y el patrón de la regla';

  @override
  String get ruleNameRequired =>
      'El nombre de la regla y el número de teléfono no pueden estar vacíos';

  @override
  String get ruleNotExist => 'La regla no existe o ha sido eliminada';

  @override
  String ruleNotFound(Object error) {
    return 'Regla no encontrada: $error';
  }

  @override
  String get ruleSavedSuccessfully => '¡Regla guardada exitosamente!';

  @override
  String get ruleSavedSuccessMessage => '¡Regla guardada exitosamente!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Error al guardar: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Error al guardar: $error';
  }

  @override
  String get ruleSaveSuccess => '¡Regla guardada exitosamente!';

  @override
  String get rulesExportedSuccessfully => 'Reglas exportadas exitosamente';

  @override
  String rulesExportedTo(Object path) {
    return 'Reglas exportadas a: $path';
  }

  @override
  String get rulesImported => 'Reglas importadas exitosamente';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count reglas importadas exitosamente';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Error al importar reglas: $error';
  }

  @override
  String get ruleStatistics => 'Estadísticas de reglas';

  @override
  String ruleStatusChanged(Object status) {
    return 'Regla $status exitosamente';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operación fallida: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regla $status exitosamente';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Error al actualizar la regla: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regla actualizada exitosamente';

  @override
  String get ruleVerification => 'Verificación de reglas';

  @override
  String get save => 'Guardar';

  @override
  String get saveButton => 'Guardar';

  @override
  String get saveButtonLabel => 'GUARDAR';

  @override
  String get saveButtonText => 'Guardar';

  @override
  String saveFailed(Object error) {
    return 'Error al guardar: $error';
  }

  @override
  String get saveFilter => 'Guardar filtro';

  @override
  String get saveSettings => 'Guardar ajustes';

  @override
  String saveSettingsFailed(Object error) {
    return 'Error al guardar los ajustes: $error';
  }

  @override
  String get scamsLikely => 'Posible fraude';

  @override
  String get search => 'Buscar';

  @override
  String get searchContacts => 'Buscar contactos';

  @override
  String searchError(Object error) {
    return 'Error de búsqueda: $error';
  }

  @override
  String get searchFilters => 'Filtros de búsqueda';

  @override
  String get searchForContacts => 'Buscar contactos';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get searchSettingsSubtitle =>
      'Buscar contactos, etiquetas, listas negras, listas blancas, etc.';

  @override
  String get searchSettingsTitle => 'Ajustes de búsqueda';

  @override
  String get securityMessage =>
      'No confíe en ninguna llamada telefónica. Siempre verifique los números de atención al cliente de forma independiente. Nunca comparta contraseñas, códigos de verificación, números de tarjeta o información personal.';

  @override
  String get selectActionToPerform =>
      'Seleccione la acción a realizar cuando la regla coincida';

  @override
  String get selectActionWhenBlockingCalls =>
      'Seleccione la acción al bloquear llamadas';

  @override
  String get selectActionWhenRuleMatches =>
      'Seleccione la acción cuando la regla coincida';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get selectCountry => 'Seleccionar país';

  @override
  String get selectDateRange => 'Seleccionar rango de fechas';

  @override
  String get selectedDateRange => 'Rango de fechas seleccionado';

  @override
  String selectedItems(Object count) {
    return '$count elementos seleccionados';
  }

  @override
  String get selectedLabel => 'Seleccionado:';

  @override
  String get selectExportFormat => 'Seleccionar formato de exportación';

  @override
  String get selectLabel => 'Seleccionar etiqueta';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Por favor, seleccione una etiqueta e introduzca un número de teléfono válido';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get selectMultiple => 'Seleccionar múltiple';

  @override
  String get selectPeriod => 'Seleccionar período';

  @override
  String get selectSimCard => 'Seleccionar tarjeta SIM';

  @override
  String get selectSimSlot => 'Seleccionar ranura SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Seleccione la acción específica a realizar al bloquear llamadas';

  @override
  String get selectTag => 'Seleccionar etiqueta';

  @override
  String get selectTags => 'Seleccionar etiquetas';

  @override
  String get selectTrustedDataSource =>
      'Por favor, seleccione fuentes de datos confiables';

  @override
  String get selectYourLanguage => 'Seleccione su idioma';

  @override
  String get sender => 'Remitente';

  @override
  String get senderRegexOptional => 'Regex del remitente (opcional)';

  @override
  String get serverAddressLabel => 'Dirección del servidor';

  @override
  String get serviceTypeContact => 'Suscripción de contacto';

  @override
  String get serviceTypeLabel => 'Tipo de servicio';

  @override
  String get serviceTypePhone => 'Suscripción telefónica';

  @override
  String get serviceTypePlugin => 'Actualización de plugin';

  @override
  String get serviceTypeSms => 'Suscripción SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Establecer';

  @override
  String get setEncryptionPassword => 'Establecer contraseña de cifrado';

  @override
  String get setEncryptionPasswordDescription =>
      'Establecer contraseña de cifrado para copia de seguridad y restauración';

  @override
  String get setEncryptionPasswordLabel => 'Establecer contraseña de cifrado';

  @override
  String get setEncryptionPasswordTitle => 'Establecer contraseña de cifrado';

  @override
  String get setPasswordButton => 'Establecer';

  @override
  String get settings => 'Ajustes';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Copia de seguridad de la configuración en: $path';
  }

  @override
  String get settingsLoaded => 'Ajustes cargados';

  @override
  String settingsLoadFailed(Object error) {
    return 'Error al cargar la configuración: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Configuración restaurada correctamente. Por favor, reinicie la aplicación para que los cambios surtan efecto.';

  @override
  String get settingsSaved => 'Ajustes guardados';

  @override
  String settingsSaveFailed(Object error) {
    return 'Error al guardar la configuración: $error';
  }

  @override
  String get settingsTab => 'Ajustes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get setup => 'Configuración';

  @override
  String get showContactEditDialogStaticMethod =>
      'Método estático para mostrar el diálogo de edición de contacto';

  @override
  String get showExplanation => 'Mostrar explicación';

  @override
  String get silence => 'Silencio';

  @override
  String get silenceAndNoAnswer => 'Silencio y sin respuesta';

  @override
  String get silenceNoAnswer => 'Silenciar sin contestar';

  @override
  String get silentCallVoiceClone => 'Clon de voz de llamada silenciosa';

  @override
  String get silentRules => 'Reglas silenciosas';

  @override
  String simCard(Object simNumber) {
    return 'Tarjeta SIM $simNumber';
  }

  @override
  String get simCardColor => 'Color de la tarjeta SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Configuración de la tarjeta SIM: establezca reglas de filtrado independientes para cada tarjeta SIM';

  @override
  String get simCardFilterRules => 'Reglas de filtrado de la tarjeta SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Establezca diferentes reglas de filtrado basadas en las ranuras de la tarjeta SIM';

  @override
  String get simCardFontSize => 'Tamaño de fuente de la tarjeta SIM';

  @override
  String get simCardPosition => 'Posición de la tarjeta SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Error al cargar la información de la tarjeta SIM: $error';
  }

  @override
  String get simRuleInstructions =>
      'Las reglas de ranura SIM le permiten configurar reglas de filtrado independientes para cada ranura SIM.';

  @override
  String get simRuleInstructionsTitle => 'Reglas de ranura SIM';

  @override
  String get simRuleManagement => 'Gestión de reglas de ranura SIM';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'Error al cargar los datos de la SIM: $error';
  }

  @override
  String get simSlotFilterConfiguration =>
      'Configuración de filtro de ranura SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'Permite establecer reglas de filtro por ranura SIM';

  @override
  String get simSlotFilterDescription =>
      'Configure reglas de filtrado independientes para cada tarjeta SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Configuración de filtro de ranura SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Error al cargar las ranuras SIM: $error';
  }

  @override
  String get simSlotManagement => 'Gestión de ranuras SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'Error en la operación de ranura SIM: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Posición de la ranura SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Reglas de ranura SIM: Estrategias de filtrado independientes por SIM';

  @override
  String get simSlotRuleListTitle => 'Lista de reglas de ranura SIM';

  @override
  String get simSlotRuleManagement => 'Reglas de ranura SIM';

  @override
  String get simSlotRuleManagementTitle => 'Gestión de reglas';

  @override
  String get simSlotSettings => 'Configuración de ranura SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Ranura SIM $slotNumber';
  }

  @override
  String get skip => 'Omitir';

  @override
  String get smartCallerId => 'Identificación inteligente de llamadas';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'El filtrado de SMS le ayuda a filtrar automáticamente los mensajes de spam y a mantener limpia su lista de mensajes. Puede establecer reglas de filtro y métodos de notificación.';

  @override
  String get smsFilterDisabled => 'Filtrado de SMS desactivado';

  @override
  String get smsFilterEnabled => 'Filtrado de SMS activado';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Regla de filtro de SMS añadida correctamente';

  @override
  String get smsFilterRules => 'Reglas de filtro de SMS';

  @override
  String get smsFilterSettings => 'Configuración de filtro de SMS';

  @override
  String get smsHistory => 'Historial de SMS';

  @override
  String get smsManagement => 'Gestión de SMS';

  @override
  String get smsPermission => 'Permiso de SMS';

  @override
  String get smsPermissionDescription =>
      'Se utiliza para filtrar mensajes de spam.';

  @override
  String get smsRuleAddedSuccessfully => 'Regla de SMS añadida correctamente';

  @override
  String get smsRuleDeletedSuccessfully =>
      'Regla de SMS eliminada correctamente';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Error al cargar las reglas de SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Gestión de reglas de SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'Reglas de SMS exportadas correctamente a $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'Reglas de SMS importadas correctamente';

  @override
  String get smsRuleSubscription => 'Suscripción a reglas de SMS';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'Regla de SMS actualizada correctamente';

  @override
  String get smsSettingsSubtitle =>
      'Filtrado de SMS y bloqueo de palabras clave';

  @override
  String get smsSettingsTitle => 'Configuración de SMS';

  @override
  String get smsSubscription => 'Suscripción a SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Suscripción a SMS añadida correctamente';

  @override
  String get smsSubscriptionRulesDescription =>
      'Suscríbase a listas de reglas de SMS a través de URL, admitiendo la coincidencia de expresiones regulares. Puede establecer acciones de bloqueo o permiso.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied =>
      'Algunas solicitudes de permiso fueron denegadas';

  @override
  String get spamLikely => 'Probablemente spam';

  @override
  String get startColor => 'Color de inicio';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get startUsing => 'Empezar';

  @override
  String get statAnswered => 'Respondidas';

  @override
  String get statBlocked => 'Bloqueadas';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Método estático para mostrar el diálogo de información del identificador de llamadas';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Método estático para mostrar el diálogo de selección de país';

  @override
  String get staticMethodToDisplayDialog =>
      'Método estático para mostrar el diálogo';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get statisticsExportFeatureComingSoon =>
      'La función de exportación de estadísticas estará disponible pronto';

  @override
  String get statisticsGrid => 'Cuadrícula de estadísticas';

  @override
  String get statisticsPageTitle => 'Análisis de datos';

  @override
  String get stirColor => 'Color STIR';

  @override
  String get stirFontSize => 'Tamaño de fuente STIR';

  @override
  String get stirPosition => 'Posición STIR';

  @override
  String get storagePermission => 'Permiso de almacenamiento';

  @override
  String get storagePermissionDescription =>
      'Se utiliza para guardar la configuración y las reglas.';

  @override
  String get subscribe => 'Suscribirse';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Suscripción \"$name\" añadida correctamente';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      '¿Estás seguro de que quieres eliminar esta suscripción?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Eliminar suscripción';

  @override
  String get subscriptionDeleted => 'Suscripción eliminada';

  @override
  String get subscriptionDeletedSuccessfully =>
      'Suscripción eliminada correctamente';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Error al eliminar la suscripción: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Suscripción eliminada';

  @override
  String get subscriptionEmptyState => 'No hay suscripciones disponibles';

  @override
  String get subscriptionEmptyText => 'Aún no hay suscripciones';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Error al cargar las suscripciones: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Error al cargar las suscripciones: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Gestión de suscripciones';

  @override
  String get subscriptionName => 'Nombre de la suscripción';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'El nombre y la URL de la suscripción no pueden estar vacíos';

  @override
  String get subscriptionNameHint => 'Introduce el nombre de la suscripción';

  @override
  String get subscriptionPageTitle => 'Gestión de suscripciones';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Error al cambiar el estado de la suscripción: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Error al alternar el estado de la suscripción: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Error al actualizar la suscripción: $error';
  }

  @override
  String get subscriptionUpdateSuccess =>
      'Suscripción actualizada correctamente';

  @override
  String get subscriptionUrl => 'URL de la suscripción';

  @override
  String get subscriptionUrlHint => 'Introduce la URL de la suscripción';

  @override
  String successfullyImportedRules(Object count) {
    return 'Se importaron $count reglas correctamente';
  }

  @override
  String get supportSync => 'Sincronización de soporte';

  @override
  String get survey => 'Encuesta';

  @override
  String get syncDevicesButton => 'Sincronizar dispositivos';

  @override
  String get syncFailed => 'Error de sincronización';

  @override
  String get syncFailedMessage => 'Error de sincronización';

  @override
  String get syncFolderNameHint =>
      'Introduce el nombre de la carpeta de sincronización (predeterminado: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Nombre de la carpeta de sincronización';

  @override
  String get synchronized => 'Sincronizado';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get syncNow => 'Sincronizar ahora';

  @override
  String get syncNowButton => 'Sincronizar ahora';

  @override
  String get syncStatusTitle => 'Estado de sincronización';

  @override
  String get syncStatusUpdatedMessage => 'Estado de sincronización actualizado';

  @override
  String get syncSuccessful => 'Sincronización exitosa';

  @override
  String get syncSuccessMessage => 'Sincronización exitosa';

  @override
  String get syncWithCloudStorage =>
      'Sincronizar con el almacenamiento en la nube';

  @override
  String get syncWithCloudStorageSubtitle =>
      'Sincronizar con el almacenamiento en la nube';

  @override
  String get systemFeatures => 'Características del sistema:';

  @override
  String get systemSettingsTitle => 'Configuración del sistema';

  @override
  String get tabAll => 'Todos';

  @override
  String get tabAnswered => 'Contestadas';

  @override
  String get tabBlocked => 'Bloqueadas';

  @override
  String get tabMissed => 'Perdidas';

  @override
  String get tabOutgoing => 'Salientes';

  @override
  String tagLabel(String tag) {
    return 'Etiqueta: $tag';
  }

  @override
  String get tagsUpdated => 'Etiquetas actualizadas';

  @override
  String get takeaway => 'Comida para llevar';

  @override
  String get telecommunication => 'Telecomunicación';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'PRUEBA';

  @override
  String get testButtonLabel => 'PRUEBA';

  @override
  String get testConnectionButton => 'Probar conexión';

  @override
  String get textColorsSetting => 'Colores de texto y etiqueta';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Esta aplicación es una poderosa herramienta de identificación de llamadas que te permite identificar y bloquear llamadas no deseadas.';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get timeInterceptor => 'Interceptor de tiempo';

  @override
  String get timeInterceptorDescription =>
      'Intercepta/permite automáticamente llamadas potenciales basadas en la frecuencia de las llamadas';

  @override
  String get timeInterceptorExplanation =>
      '• Interceptor de tiempo: Intercepta/permite llamadas repetidas en un corto tiempo';

  @override
  String get timeInterceptorExplanationContent =>
      'La función de intercepción de frecuencia de llamadas analiza la frecuencia de las llamadas para identificar e interceptar/permitir automáticamente las llamadas de spam frecuentes.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Explicación de la intercepción de frecuencia de llamadas';

  @override
  String get timeInterceptorSettingsTitle =>
      'Configuración de la intercepción de frecuencia de llamadas';

  @override
  String get timeInterceptorSubtitle =>
      'Intercepta automáticamente llamadas de spam potenciales basadas en la frecuencia de las llamadas';

  @override
  String get timeInterceptorTitle =>
      'Habilitar la intercepción de frecuencia de llamadas';

  @override
  String get timeWindowDescription =>
      'Establece el tamaño de la ventana de tiempo para permitir llamadas repetidas. Se permitirán las llamadas del mismo número dentro de esta ventana';

  @override
  String timeWindowLabel(int minutes) {
    return 'Ventana de tiempo de intercepción (minutos): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Establece el tamaño de la ventana de tiempo para permitir llamadas repetidas. Se permitirán las llamadas del mismo número dentro de esta ventana';

  @override
  String get today => 'Hoy';

  @override
  String get total => 'Total';

  @override
  String get totalBlocked => 'Total bloqueadas';

  @override
  String get totalFiltered => 'Total filtradas';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Transferir datos entre dispositivos o plataformas';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Transferir datos entre dispositivos o plataformas';

  @override
  String get travelTicketing => 'Venta de billetes de viaje';

  @override
  String get trend => 'Tendencia';

  @override
  String get trendChart => 'Gráfico de tendencias';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Tipo';

  @override
  String get unassignedSIMCard => 'Tarjeta SIM no asignada';

  @override
  String get unknown => 'Desconocido';

  @override
  String get unknownLabel => 'Etiqueta desconocida';

  @override
  String get unknownTag => 'Etiqueta: Desconocida';

  @override
  String get unregisterButton => 'Anular registro';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '¿Está seguro de que desea anular el registro de $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Anular registro del dispositivo';

  @override
  String get unsupportedFileFormat => 'Formato de archivo no compatible';

  @override
  String get update => 'Actualizar';

  @override
  String get updateAllNow => 'Actualizar todo ahora';

  @override
  String get updateCallFilterConfig =>
      'Actualizar configuración del filtro de llamadas';

  @override
  String updateContactFailed(Object error) {
    return 'Error al actualizar el contacto: $error';
  }

  @override
  String get updateFavoriteStatus => 'Actualizar estado de favorito';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Error al actualizar el estado de favorito: $error';
  }

  @override
  String get updateInterval => 'Intervalo de actualización';

  @override
  String get updateLabelFailed => 'Error al actualizar la etiqueta';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get updatePlugin => 'Actualizar plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Error al actualizar el plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Error al actualizar la regla: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Error al actualizar la suscripción: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service actualizado correctamente ($count reglas)';
  }

  @override
  String get updateTags => 'Actualizar etiquetas';

  @override
  String get useCasesPoint1 =>
      '• Identificar llamadas spam de rellamada automática';

  @override
  String get useCasesPoint2 =>
      '• Interceptar llamadas de marketing que llaman varias veces en un corto período';

  @override
  String get useCasesPoint3 => '• Prevenir el bombardeo telefónico y el acoso';

  @override
  String get useCasesTitle => 'Casos de uso:';

  @override
  String get useGlobalSettings => 'Usar configuración global';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Nombre de usuario';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Utilice la sintaxis de expresiones regulares estándar para definir patrones. Ejemplos:';

  @override
  String get validateRegex => 'Validar Regex';

  @override
  String get verificationFailedText => 'Fallido';

  @override
  String get verifiedText => 'Verificado';

  @override
  String get verify => 'Verificar';

  @override
  String version(Object version) {
    return 'Versión: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Intercambiar membresía VIP con conteos de marcado de números de teléfono';

  @override
  String get vipExchangeTitle => 'Marcar intercambio VIP';

  @override
  String get watchAd => 'Ver anuncio';

  @override
  String get watchAdForTemp => 'Ver anuncio para privilegios temporales';

  @override
  String get watchAdForTempDescription =>
      'Mira un anuncio corto para desbloquear temporalmente algunas funciones premium';

  @override
  String get webDAVConfigTitle => 'Configuración WebDAV';

  @override
  String get webdavConfigurationTitle => 'Configuración WebDAV';

  @override
  String get webdavPasswordHint =>
      'Por favor, introduzca la contraseña de WebDAV';

  @override
  String get webdavServerAddressHint =>
      'Por favor, introduzca la dirección del servidor WebDAV';

  @override
  String get webdavUsernameHint =>
      'Por favor, introduzca el nombre de usuario de WebDAV';

  @override
  String get week => 'Semana';

  @override
  String get weekly => 'Semanalmente';

  @override
  String get weeklyBlockedCallsSummary =>
      'Resumen semanal de llamadas bloqueadas';

  @override
  String get weeklyChartTitle => 'Llamadas bloqueadas semanalmente';

  @override
  String get weeklyReport => 'Informe semanal';

  @override
  String get weeklyReportDesc =>
      'Reciba un informe de resumen semanal de la actividad de bloqueo de llamadas';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get whitelist => 'Lista blanca';

  @override
  String get whitelistLabel => 'Lista blanca';

  @override
  String get width => 'Ancho';

  @override
  String get wildcardMatchingDescription =>
      'Use \'.\' para que coincida con cualquier carácter (p. ej., \'123.456\' coincide con 123-456)';

  @override
  String get wildcardMatchingTitle => 'Coincidencia de comodines:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Soporte de comodines para filtrado flexible';

  @override
  String get windowSizeSetting => 'Tamaño de la ventana';

  @override
  String get year => 'Año';

  @override
  String get yearly => 'Anual';

  @override
  String get yearlyChartTitle => 'Llamadas bloqueadas anuales';

  @override
  String get noSimCardsDetected => 'No se detectaron tarjetas SIM';

  @override
  String get filterManagementDescription => 'Establecer filtros de llamadas';

  @override
  String get callerIdCustomizationSubtitle =>
      'Personalizar el diseño del identificador de llamadas';

  @override
  String get fraudAlerSettingTitle => 'Configuración de alerta de fraude';

  @override
  String get fraudAlerSettingSubtitle => 'Para configurar la alerta de fraude';

  @override
  String get enableFraudAlert => 'Habilitar alerta de fraude';

  @override
  String get enableFraudAlertDescription =>
      'Alerta de posibles llamadas de estafa';

  @override
  String get enableVibration => 'Habilitar vibración';

  @override
  String get enableVibrationDescription =>
      'Vibrar cuando se sospecha que la llamada es una llamada de estafa';

  @override
  String get notificationSettingsTitle => 'Configuración de notificaciones';

  @override
  String get useLocalNotification => 'Usar notificaciones locales';

  @override
  String get useLocalNotificationDescription =>
      'Habilitar las notificaciones locales para las llamadas entrantes';

  @override
  String get cancelLocalNotification => 'Cerrar notificaciones locales';

  @override
  String get useStirNotification => 'Usar la notificación de STIR';

  @override
  String get useStirNotificationDescription =>
      'Habilitar las notificaciones de STIR para llamadas entrantes';

  @override
  String get cancelLocalNotificationDescription =>
      'Cerrar notificaciones locales automáticamente';

  @override
  String get callerIdSettingsTitle => 'Configuración de ID de llamada';

  @override
  String get callerIdSettingsSubtitle =>
      'Para configurar la notificación de llamadas entrantes y el modo de visualización';

  @override
  String get purchaseTitle => 'Compra';

  @override
  String get purchaseSubtitle => 'Para comprar el servicio';

  @override
  String get callerIdNotificationTitle => 'Información de llamada entrante';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Número: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Llamada bloqueada';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Llamada bloqueada de $phoneNumber';
  }

  @override
  String get stirVerified => 'Verificado';

  @override
  String get stirNotVerified => 'No verificado';

  @override
  String get stirFailed => 'Verificación fallida';

  @override
  String get stirUnknown => 'Estado de verificación desconocido';

  @override
  String get stirVerificationTitle => 'Verificación STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage para el número $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Configuración de mensajes de seguridad de desplazamiento';

  @override
  String get messageColor => 'Color del mensaje';

  @override
  String get messageFontSize => 'Tamaño de fuente del mensaje';

  @override
  String get messagePosition => 'Posición del mensaje';

  @override
  String get containerWidth => 'Ancho del contenedor';

  @override
  String get scrollSpeed => 'Velocidad de desplazamiento';

  @override
  String get enableSecurityMessage => 'Habilitar mensaje de seguridad';

  @override
  String get fraudAlertTitle => 'Alerta de fraude';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Posible llamada de fraude de $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Error al cargar las reglas: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Error al cargar el registro de llamadas: $error';
  }

  @override
  String get noBlockedTypeData => 'No hay datos de tipo bloqueado disponibles';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importar $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName importado correctamente, total de $count registros importados';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Error al importar $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Exportar $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName exportado correctamente';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Error al exportar $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Servicio de sincronización en la nube';

  @override
  String get membershipCenter => 'Centro de membresía';

  @override
  String get redeemVipWithMarks => 'Canjear VIP con Marks';

  @override
  String get currentMarkCount => 'Conteo actual de Marks';

  @override
  String get markMoreNumbersForMore =>
      'Marca más números para obtener más marks';

  @override
  String get noAds => 'Sin anuncios';

  @override
  String get cloudBackup => 'Copia de seguridad en la nube';

  @override
  String get callerIdEnhancement => 'Mejora del identificador de llamadas';

  @override
  String get voiceRecognition => 'Reconocimiento de voz';

  @override
  String get feature => 'Característica';

  @override
  String get normalUser => 'Usuario normal';

  @override
  String get vipUser => 'Usuario VIP';

  @override
  String get temporaryVip => 'VIP temporal';

  @override
  String get removeAds => 'Eliminar anuncios';

  @override
  String get unknownAction => 'Acción desconocida';

  @override
  String get settingsBackup => 'Copia de seguridad de la configuración';

  @override
  String get allServicesStatusTitle => 'Estado actual del servicio';

  @override
  String get allServicesStatusSubtitle =>
      'Estado actual de cada servicio en la nube';

  @override
  String get redirect => 'Redirigir';

  @override
  String get notify => 'Notificar';

  @override
  String get log => 'Registro';

  @override
  String get custom => 'Personalizado';

  @override
  String get allowActionDescription =>
      'Se permitirán las llamadas, incluso si el número está en la lista de bloqueo.';

  @override
  String get blockActionDescription =>
      'Las llamadas se bloquearán y se mostrarán en el registro de llamadas.';

  @override
  String get silenceActionDescription =>
      'Las llamadas se silenciarán, pero se mostrarán en el registro de llamadas.';

  @override
  String get noneActionDescription =>
      'No se tomará ninguna acción especial para la llamada.';

  @override
  String get redirectActionDescription =>
      'Redirija la llamada a un número específico.';

  @override
  String get labelActionDescription =>
      'Agregue una etiqueta a la llamada para facilitar la identificación.';

  @override
  String get notifyActionDescription =>
      'Enviar una notificación cuando se reciba una llamada.';

  @override
  String get logActionDescription =>
      'Registre la información de la llamada sin realizar ninguna otra acción.';

  @override
  String get customActionDescription => 'Realizar una acción personalizada.';

  @override
  String get synced => 'Sincronizado';

  @override
  String get needVipAccess => 'Necesitas acceso VIP para usar esta función';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importar o exportar datos de $entityTypeName';
  }

  @override
  String get importExportTitle => 'Importar/Exportar';

  @override
  String get noPhoneRules => 'No se encontraron reglas de teléfono';

  @override
  String get noRegexRules => 'No se encontraron reglas de regex';

  @override
  String get noAllowedBlockedRules =>
      'No se encontraron reglas permitidas/bloqueadas';

  @override
  String get importExport => 'Importar/Exportar';

  @override
  String get filterByAction => 'Filtrar por acción';

  @override
  String get upgradeToVip => 'Actualizar a VIP';

  @override
  String get batteryOptimizationPermission => 'Optimización de batería';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Permite que la aplicación se ejecute en segundo plano para proporcionar servicios como la identificación de llamadas.';

  @override
  String get permissionTitle => 'Permisos especiales';

  @override
  String get permissionSubtitle =>
      'Administrar permisos de superposición y optimización de batería';

  @override
  String get themeSettingsTitle => 'Configuración del tema';

  @override
  String get themeSettingsSubtitle => 'Elige tu tema favorito';

  @override
  String get databaseSyncTitle => 'Sincronización de la base de datos';

  @override
  String get countrySyncSettingsTitle =>
      'Configuración de sincronización de la base de datos basada en el país';

  @override
  String get countrySyncSettingsSubtitle =>
      'Seleccione países para la sincronización de datos';

  @override
  String get countryDataDisclaimer =>
      'Tenga en cuenta: Es posible que la base de datos no incluya datos para todos los países o regiones específicos.';

  @override
  String get editSubscription => 'Editar suscripción';

  @override
  String get searchByNameOrPhoneNumber =>
      'Buscar por nombre o número de teléfono';

  @override
  String get allowedBlockedRulesInfo =>
      'Las reglas permitidas/bloqueadas se utilizan para relacionar las llamadas con números de teléfono específicos, que tienen la máxima prioridad.';

  @override
  String get searchPhoneRulesHint => 'Buscar reglas de teléfono';

  @override
  String get phoneRulesInfo =>
      'Las reglas telefónicas se utilizan para relacionar las llamadas con números de teléfono específicos, que tienen una prioridad más baja. Algunos provienen de las suscripciones de phoneRule';

  @override
  String get searchSubscriptionsHint => 'Buscar suscripciones';

  @override
  String get searchPluginsHint => 'Buscar complementos';

  @override
  String get searchLabelsHint => 'Buscar etiquetas';

  @override
  String get pluginDescription => 'Descripción del complemento';

  @override
  String get enterPluginDescription => 'Ingrese la descripción del complemento';

  @override
  String get searchRegexRulesHint => 'Buscar reglas de expresiones regulares';

  @override
  String get regexRulesInfo =>
      'Las reglas de expresiones regulares se utilizan para filtrar llamadas basadas en patrones de expresiones regulares.';

  @override
  String get searchMarkedPhonesHint => 'Buscar teléfonos marcados';

  @override
  String get searchContactSubscriptionsHint =>
      'Buscar suscripciones de contactos';

  @override
  String get showAllContacts => 'Mostrar todos los contactos';

  @override
  String get showFavorites => 'Mostrar favoritos';

  @override
  String get manualEntry => 'Información de entrada manual';

  @override
  String get scriptSaved => 'Script guardado';

  @override
  String editScriptFor(String pluginName) {
    return 'Editar script para $pluginName';
  }

  @override
  String get saveScript => 'Guardar script';

  @override
  String get testPlugin => 'Probar complemento';

  @override
  String get description => 'Descripción';

  @override
  String get accessTargetUrl => 'Acceder a la URL de destino';

  @override
  String get result => 'Resultado';

  @override
  String get editScript => 'Editar script';

  @override
  String get numberFormat => 'Formato de número';

  @override
  String get nationalNumber => 'Número nacional';

  @override
  String get e164Number => 'Número E.164';

  @override
  String get pluginRulesInfo =>
      'Por seguridad, utilice solo complementos de fuentes confiables. ¡Siéntase libre de utilizar nuestras plantillas para crear sus propios complementos personalizados!';

  @override
  String get advancedMode => 'Modo avanzado';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Por favor, ingrese al menos un número.';

  @override
  String get openInWebView => 'Abrir en WebView';

  @override
  String get pluginLabel => 'Etiqueta del complemento';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Color de fondo del mensaje';

  @override
  String get clearAllCallLogs => 'Borrar todos los registros de llamadas';

  @override
  String get clearAllCallLogsConfirmation =>
      'Confirme para borrar todos los registros de llamadas';

  @override
  String get allCallLogsCleared => 'Todos los registros de llamadas borrados';

  @override
  String get unblocked => 'Desbloqueado';

  @override
  String get blockNumber => 'Número de Bloqueo';

  @override
  String get blockNumberSuccess => 'Número bloqueado con éxito';

  @override
  String get blockNumberFailed => 'Error al bloquear el número';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '¿Estás seguro de que quieres desbloquear a $phoneNumber?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'Llamando a $phoneNumber...';
  }

  @override
  String get viewDetails => 'Ver Detalles';

  @override
  String get unblock => 'Desbloquear';

  @override
  String get unblockNumber => 'Desbloquear Número';

  @override
  String get unblockNumberSuccess => 'Número desbloqueado con éxito';

  @override
  String get unblockNumberFailed => 'Error al desbloquear el número';

  @override
  String get serviceNotAvailable => 'Servicio no disponible';

  @override
  String get callingNumberFailed => 'Error al llamar al número';

  @override
  String get listView => 'Vista de Lista';

  @override
  String get timelineView => 'Vista de Cronología';

  @override
  String get nameCannotBeEmpty => 'El nombre no puede estar vacío';

  @override
  String get selectAction => 'Selecciona la acción';

  @override
  String get selectTargetService => 'Selecciona el servicio objetivo';

  @override
  String get callDetails => 'Detalles de la Llamada';

  @override
  String get callType => 'Tipo de Llamada';

  @override
  String get callTime => 'Hora de la Llamada';

  @override
  String get numberInvalidFormat => 'Formato de número no válido';

  @override
  String get membershipFeature => 'Función de Membresía';

  @override
  String get medium => 'Medio';

  @override
  String get finalRisk => 'Riesgo Final';

  @override
  String get simState => 'Estado de la SIM';

  @override
  String get ipCountry => 'País de IP';

  @override
  String get simCountry => 'País de la SIM';

  @override
  String get isRoaming => 'En Roaming';

  @override
  String get isNumberMatch => 'Número Coincide';

  @override
  String get support => 'Soporte';

  @override
  String get rewardedAdService => 'Servicio de Anuncios Recompensados';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Ya tienes privilegios VIP (excepto para anuncios)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Ya tienes privilegios temporales, fecha de caducidad: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Necesitas ver $count anuncios más para obtener privilegios VIP temporales';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Se te han concedido $days días de privilegios de compra temporales. Fecha de caducidad: $expiryDate';
  }

  @override
  String get tempPurchaseExpired =>
      'El privilegio de compra temporal ha caducado';

  @override
  String get loadingAd => 'Cargando Anuncio...';

  @override
  String get earnedTempVip => 'VIP temporal ganado';

  @override
  String get vipExchangeService => 'Servicio de Intercambio VIP';

  @override
  String get marksInsufficient => 'Marcas insuficientes para intercambiar';

  @override
  String get invalidExchangeRule => 'Regla de intercambio inválida';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Intercambiado con éxito por $description, fecha de caducidad: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Error al intercambiar: $error';
  }

  @override
  String get vip3DaysWithAds =>
      'VIP de 3 días con anuncios (solo sincronización)';

  @override
  String get vip5DaysNoAds =>
      'VIP de 5 días con todas las funciones y sin publicidad';

  @override
  String get vip7DaysNoAds =>
      'VIP de 7 días con todas las funciones y sin publicidad';

  @override
  String get noNotifications => 'No hay notificaciones';

  @override
  String get clearAllNotifications => 'Borrar todas las notificaciones';

  @override
  String get clearAllNotificationsConfirmation =>
      'Confirmar para borrar todas las notificaciones';

  @override
  String get allNotificationsCleared => 'Todas las notificaciones borradas';

  @override
  String get clearButton => 'Borrar';

  @override
  String get justNow => 'Recién ahora';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count minutos',
      one: 'Hace 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count horas',
      one: 'Hace 1 hora',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Hace $count días',
      one: 'Hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Ayer';

  @override
  String get deletionProposal => 'Propuesta de eliminación';

  @override
  String get createProposal => 'Crear propuesta';

  @override
  String get createProposalTitle => 'Crear propuesta de eliminación';

  @override
  String get reason => 'Razón';

  @override
  String get reasonOutdated => 'Número obsoleto';

  @override
  String get reasonPrivacy => 'Problema de privacidad';

  @override
  String get reasonNotInService => 'Fuera de servicio';

  @override
  String get reasonWronglyIdentified => 'Identificado erróneamente';

  @override
  String get reasonInaccurateInfo => 'Información inexacta';

  @override
  String get reasonWrongMarked => 'Marcado incorrectamente';

  @override
  String get reasonOther => 'Otro';

  @override
  String get submit => 'Enviar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get proposalStatus => 'Estado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusActive => 'Activo';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get statusExpired => 'Caducado';

  @override
  String get riskLevel => 'Nivel de riesgo';

  @override
  String get riskLevelVerified => 'Verificado';

  @override
  String get riskLevelLow => 'Bajo';

  @override
  String get riskLevelHigh => 'Alto';

  @override
  String get riskLevelUnknown => 'Desconocido';

  @override
  String get votingProgress => 'Progreso de la votación';

  @override
  String agreeVotes(int count) {
    return 'A favor: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'En contra: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Total: $count';
  }

  @override
  String get voteAgree => 'A favor';

  @override
  String get voteDisagree => 'En contra';

  @override
  String createdAt(String date) {
    return 'Creado: $date';
  }

  @override
  String get verificationReport => 'Informe de Verificación';

  @override
  String get showReport => 'Mostrar informe';

  @override
  String get hideReport => 'Ocultar informe';

  @override
  String get proposalStatistics => 'Estadísticas de la propuesta';

  @override
  String get totalProposals => 'Propuestas totales';

  @override
  String get activeProposals => 'Propuestas activas';

  @override
  String get completedProposals => 'Propuestas completadas';

  @override
  String get myVotes => 'Mis votos';

  @override
  String get proposalCreated => 'Propuesta creada con éxito';

  @override
  String get proposalCreateFailed => 'Error al crear la propuesta';

  @override
  String get voteSubmitted => 'Voto enviado con éxito';

  @override
  String get voteSubmitFailed => 'Error al enviar el voto';

  @override
  String get noProposalsFound => 'No se encontraron propuestas';

  @override
  String get loadingProposals => 'Cargando propuestas...';

  @override
  String get refreshProposals => 'Actualizar Propuestas';

  @override
  String get totalPendingProposals => 'Total de Propuestas Pendientes';

  @override
  String get highRisk => 'Alto Riesgo';

  @override
  String get mediumRisk => 'Riesgo Medio';

  @override
  String get lowRisk => 'Bajo Riesgo';

  @override
  String get communityImpact => 'Impacto Comunitario';

  @override
  String get criticalIssues => 'Problemas Críticos';

  @override
  String get communityParticipation => 'Participación Comunitaria';

  @override
  String get noActivity => 'Sin Actividad';

  @override
  String get low => 'Bajo';

  @override
  String get moderate => 'Moderado';

  @override
  String get high => 'Alto';

  @override
  String get veryHigh => 'Muy Alto';

  @override
  String get voted => 'Votado';

  @override
  String get communityVotes => 'Votos de la comunidad';

  @override
  String get waitingForMoreVotes => 'Esperando más votos de la comunidad';

  @override
  String get proposalProcessed => 'Esta propuesta ha sido procesada';

  @override
  String get supported => 'APOYADO';

  @override
  String get opposed => 'OPUESTO';

  @override
  String get approved => 'APROBADO';

  @override
  String get rejected => 'RECHAZADO';

  @override
  String get completed => 'COMPLETADO';

  @override
  String get pending => 'PENDIENTE';

  @override
  String get critical => 'Crítico';

  @override
  String get oppose => 'Oponerse';

  @override
  String get veryLow => 'Muy Bajo';

  @override
  String get deletionProposals => 'Propuestas de eliminación';

  @override
  String get deletionProposalNotificationDescription =>
      'Notificaciones sobre los resultados y actualizaciones de la votación de la propuesta de eliminación.';

  @override
  String get deletionProposalCreated => 'Propuesta de Eliminación Creada';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Su propuesta de eliminación para $phoneNumber ha sido enviada para revisión de la comunidad.';
  }

  @override
  String get proposalApproved => 'Propuesta Aprobada ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La propuesta de eliminación para $phoneNumber ha sido aprobada por la comunidad ($supportPercentage% de apoyo, $totalVotes votos).';
  }

  @override
  String get proposalRejected => 'Propuesta Rechazada ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La propuesta de eliminación para $phoneNumber ha sido rechazada por la comunidad ($supportPercentage% de apoyo, $totalVotes votos).';
  }

  @override
  String get communityVotingStarted => 'Votación Comunitaria Iniciada';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Una nueva propuesta de eliminación para $phoneNumber ahora está abierta para la votación de la comunidad.';
  }

  @override
  String get votingCompleted => 'Votación Completada';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'La votación comunitaria para $phoneNumber ha finalizado. Resultado: $result ($supportPercentage% de apoyo).';
  }

  @override
  String get newVoteReceived => 'Nuevo Voto Recibido';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Alguien votó para $voteType la eliminación de $phoneNumber. Votos actuales: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Error al cargar el conteo de votos';

  @override
  String get voteCount => 'Conteo de Votos';

  @override
  String get deletionProposalInfo =>
      'Información de la Propuesta de Eliminación';

  @override
  String get deletionProposalDescription =>
      'Proponga números para su eliminación que violen las pautas de la comunidad. Su participación ayuda a mantener la plataforma segura.';

  @override
  String get voteToEarnVip =>
      '¡Vota en las propuestas para obtener privilegios VIP!';

  @override
  String get voteFailed => 'Error al votar';

  @override
  String get searchProposals => 'Buscar Propuestas';

  @override
  String get defaultNotifications => 'Notificaciones Predeterminadas';

  @override
  String get defaultNotificationsDescription =>
      'Canal de notificaciones predeterminado para la aplicación.';

  @override
  String get blockedCallNotifications =>
      'Notificaciones de Llamadas Bloqueadas';

  @override
  String get blockedCallNotificationsDescription =>
      'Muestra información sobre llamadas bloqueadas.';

  @override
  String get stirVerification => 'Verificación STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Muestra los resultados de la verificación STIR/SHAKEN para los números.';

  @override
  String get fraudAlerts => 'Alertas de Fraude';

  @override
  String get fraudAlertsDescription =>
      'Muestra advertencias para posibles llamadas fraudulentas.';

  @override
  String get notificationFrequencyDescription =>
      'Elige con qué frecuencia recibes notificaciones sobre nuevas propuestas de eliminación. Puedes recibirlas inmediatamente, en lotes o en un intervalo personalizado.';

  @override
  String get notificationMode => 'Modo de notificación';

  @override
  String get immediateNotifications => 'Inmediato';

  @override
  String get immediateNotificationsDescription =>
      'Recibe una notificación tan pronto como se cree una propuesta.';

  @override
  String get batchNotifications => 'Por lotes';

  @override
  String get batchNotificationsDescription =>
      'Recibe un resumen de las notificaciones periódicamente.';

  @override
  String get customNotifications => 'Personalizado';

  @override
  String get customNotificationsDescription =>
      'Define tu propio intervalo para recibir notificaciones.';

  @override
  String get customFrequency => 'Frecuencia Personalizada';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours h';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get pendingProposals => 'Propuestas Pendientes';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count propuestas pendientes',
      one: '1 propuesta pendiente',
      zero: 'ninguna propuesta pendiente',
    );
    return 'Tienes $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Directrices';

  @override
  String get riskLevelLabel => 'Nivel de Riesgo';

  @override
  String get riskLevelDescription => 'Nivel de riesgo del número';

  @override
  String get phoneNumberMinDigits =>
      'El número de teléfono debe tener al menos 7 dígitos';

  @override
  String get provideDetailedExplanation =>
      'Proporciona una explicación detallada (mínimo 10 caracteres)';

  @override
  String get reasonMinCharacters =>
      'La razón debe tener al menos 10 caracteres';

  @override
  String get countryCodeTwoLetters => 'Código de país (ISO 3166-1 alfa-2) *';

  @override
  String get countryCodeLabel => 'Código de país (ISO 3166-1 alfa-2) *';

  @override
  String get countryCodeHint => 'p. ej., US, CN, GB';

  @override
  String get countryCodeRequired => 'Se requiere el código de país';

  @override
  String get countryCodeLengthError => 'El código de país debe tener 2 letras';

  @override
  String get phoneNumberHint => 'Ingrese el número de teléfono';

  @override
  String get phoneNumberRequired => 'Se requiere el número de teléfono';

  @override
  String get phoneNumberLengthError =>
      'El número de teléfono debe tener al menos 7 dígitos';

  @override
  String get reasonHint =>
      'Proporciona una explicación detallada (mínimo 10 caracteres)';

  @override
  String get reasonRequired => 'Se requiere una razón';

  @override
  String get reasonLengthError => 'La razón debe tener al menos 10 caracteres';

  @override
  String get guidelinesTitle => 'Directrices';

  @override
  String get guidelinesText =>
      '• Solo informa sobre números que sean genuinamente problemáticos\n• Proporciona razones precisas y detalladas\n• Elige el nivel de riesgo adecuado según la gravedad\n• Los informes falsos pueden dar lugar a restricciones de la cuenta';

  @override
  String get riskLevelCritical => 'Crítico';

  @override
  String get riskLevelMedium => 'Medio';

  @override
  String get riskLevelVeryLow => 'Muy Bajo';

  @override
  String get riskDescriptionVeryLow =>
      'Muy bajo: molestia menor, llamadas poco frecuentes';

  @override
  String get riskDescriptionLow => 'Bajo: llamadas no deseadas ocasionales';

  @override
  String get riskDescriptionMedium => 'Medio: spam o telemarketing regulares';

  @override
  String get riskDescriptionHigh =>
      'Alto: acoso persistente o intentos de estafa';

  @override
  String get riskDescriptionCritical =>
      'Crítico: estafas o amenazas peligrosas';

  @override
  String get notificationFrequencyTitle => 'Frecuencia de Notificación';

  @override
  String get notificationFrequencyLabel => 'Frecuencia de Notificación (horas)';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Votos: $totalVotes ($supportPercentage% apoyo)';
  }

  @override
  String get timeJustNow => 'Recién ahora';

  @override
  String timeMinutesAgo(int minutes) {
    return 'Hace ${minutes}m';
  }

  @override
  String timeHoursAgo(int hours) {
    return 'Hace ${hours}h';
  }

  @override
  String timeDaysAgo(int days) {
    return 'Hace ${days}d';
  }

  @override
  String get reportingGuidelines =>
      '• Solo informa sobre números que sean genuinamente problemáticos\n• Proporciona razones precisas y detalladas\n• Elige el nivel de riesgo adecuado según la gravedad\n• Los informes falsos pueden dar lugar a restricciones de la cuenta';

  @override
  String get notificationFrequencyHours => 'Frecuencia de Notificación (Horas)';

  @override
  String supportCount(int supportCount) {
    return 'Apoyo ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Oposición ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes votos ($supportPercentage% de apoyo)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '1 hora',
      zero: '0 horas',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Aviso Importante';

  @override
  String get dataSourceDisclaimer =>
      'Los números provienen de internet y de envíos de usuarios. No podemos garantizar que un número, una vez eliminado, no sea reenviado por otros usuarios o fuentes. Por favor, busque y verifique activamente la información.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Ubicación';

  @override
  String get simCardTitle => 'Tarjeta SIM';

  @override
  String get liveActivitiesSettingsTitle => 'Ajustes de Actividades en Vivo';

  @override
  String get elementsSettingsTitle => 'Ajustes de Elementos';

  @override
  String get liveActivityMode => 'Actividad en Vivo';

  @override
  String get liveActivityModeDescription =>
      'Muestra la información de la llamada como una notificación persistente en la pantalla de bloqueo y en la Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Tipo de Número de Teléfono';

  @override
  String get liveActivitiesTestEndActivity => 'Finalizar Actividad';

  @override
  String get liveActivitiesTestSendNewActivity => 'Enviar Nueva Actividad';

  @override
  String get liveActivitiesTestUpdateActivity => 'Actualizar Actividad';

  @override
  String get liveActivityControlsTitle => 'Controles de Actividad en Vivo';

  @override
  String get liveActivitiesTestTitle => 'Prueba de Actividades en Vivo';

  @override
  String get liveActivitiesTestSubtitle =>
      'Prueba la notificación de actividad en vivo.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Personalización de Notificación en Vivo';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Personaliza la apariencia de las notificaciones en vivo.';

  @override
  String get notification_instructions =>
      'Instrucciones:\n1. Toca \"ENVIAR\" para crear o actualizar una notificación.\n2. Ve a tu pantalla de inicio o desliza hacia abajo la bandeja de notificaciones para ver el resultado.\n3. Toca \"FINALIZAR\" para descartar la notificación.';

  @override
  String get autoCancelNotification => 'Cancelar Notificación Automáticamente';

  @override
  String get autoCancelNotificationDescription =>
      'Si está marcada, la notificación se descartará automáticamente cuando el usuario la toque.';

  @override
  String get setDelayTime => 'Establecer Tiempo de Retraso';

  @override
  String get proposalDetails => 'Detalles de la Propuesta';

  @override
  String get filterByStatus => 'Filtrar por Estado';

  @override
  String get proposalNotFound => 'Propuesta no encontrada';

  @override
  String get processed => 'Procesado';

  @override
  String get showAll => 'Mostrar Todos';

  @override
  String get filterAndSortTitle => 'Filtrar y Ordenar';

  @override
  String get filterVerifiedOwner => 'Filtrar Propietario Verificado';

  @override
  String get filterBy => 'Filtrar Por';

  @override
  String get sortOldest => 'Ordenar Más Antiguo';

  @override
  String get sortNewest => 'Ordenar Más Reciente';

  @override
  String get sortMostPopular => 'Ordenar Más Popular';

  @override
  String get sortLeastPopular => 'Ordenar Menos Popular';

  @override
  String get sortBy => 'Ordenar Por';

  @override
  String get simRulesNotFound => 'Reglas de la SIM no encontradas';

  @override
  String get simSlotRules => 'Reglas de la Ranura SIM';

  @override
  String get noSimCardDetected => 'No se detectó ninguna tarjeta SIM';

  @override
  String get invalidSimData => 'Datos SIM no válidos';

  @override
  String get simCardData => 'Datos de la Tarjeta SIM';

  @override
  String get simSlot => 'Ranura SIM';

  @override
  String get enableFiltering => 'Habilitar Filtrado';

  @override
  String get detailedSettingsTitle => 'Ajustes Detallados';

  @override
  String get entryPointViewTitle => 'Vista del punto de entrada';

  @override
  String get callTypeRejected => 'Rechazada';

  @override
  String get callTypeSilenced => 'Silenciada';

  @override
  String get callTypeVoicemail => 'Correo de voz';

  @override
  String get callTypeUnknownIntercept => 'Interceptación desconocida';

  @override
  String andMoreItems(int count) {
    return 'y $count elementos más';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

  @override
  String get localDatabaseSyncSubtitle => 'Sync data across devices';

  @override
  String get localDatabaseSyncDescription =>
      'Connect your personal Supabase database to sync data across devices.';

  @override
  String get supabaseProjectUrl => 'Supabase Project URL';

  @override
  String get supabaseAnonKey => 'Anon Key';

  @override
  String get supabaseAnonKeyHint => 'API Key, anon public key';

  @override
  String get connectionString => 'Connection String (URI)';

  @override
  String get connectionStringHelper =>
      'Only needed for \'Initialize Database\'';

  @override
  String get syncCallHistory => 'Sync Call History';

  @override
  String get syncCallHistorySubtitle => 'Include private call logs in sync';

  @override
  String get requiredField => 'Required';

  @override
  String get requiredInitField => 'Required for initialization';

  @override
  String get initDbButton => 'Initialize Database';

  @override
  String get dbInitSuccess => 'Database Initialized Successfully!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Sync Complete. Sent: $pushed, Received: $pulled';
  }

  @override
  String get errorPrefix => 'Error';

  @override
  String get errorLoadingSettings => 'Error loading settings';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusConnected => 'Connected / Configured';

  @override
  String get statusNotConfigured => 'Not Configured';

  @override
  String get configSaved => 'Configuration Saved!';

  @override
  String get masterDeviceLabel => 'Is Master Device (Admin)';

  @override
  String get masterDeviceHelp =>
      'Only the master device can initialize the database structure.';

  @override
  String get syncIntervalLabel => 'Auto-sync Interval';

  @override
  String syncIntervalValue(int hours) {
    return 'Every $hours hours';
  }

  @override
  String get leaveEmptyToUseDefault => 'Leave empty to use default';

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Failed to load settings schema: $error';
  }

  @override
  String get noSettingsAvailable => 'No settings available for this plugin.';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get answerThenHangupDescription =>
      'Automatically answer the incoming call and then immediately hang up to terminate it';

  @override
  String get stirUnverified => 'Not Verified';

  @override
  String markedCountDisplay(int count) {
    return 'Marked: $count';
  }
}
