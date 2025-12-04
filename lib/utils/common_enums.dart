library;

/// ***********************************************************************************
/// *                                  LOCAL ENUMS                                    *
/// ***********************************************************************************
//* APPLICATION NOTIFICATION STATES
enum NotificationState { open, background, kill }

///* APP BUTTON VARIANTS
enum ButtonType { elevated, gradient, outline }

///* IMAGE OR ICON ALIGNS IN APP BUTTON
enum ImageAlign { start, startTitle, endTitle, end }

///* APP TEXT-FORM-FIELD VARIANTS
enum TextFieldType { normal, date, time, search }

///* CUSTOM SNACK-BAR TYPE
enum SnackBarType { complete, wrong, warning }

///* SCREEN STATES
enum ScreenState { add, update, readOnly }

///* API STATES
enum ApiState { initial, pagination, background, refresh }

///* LOCATION PERMISSION STATES
enum LocationStatus { serviceDisabled, granted, denied, permanentlyDenied, restricted, loading }

///* IMAGE OR ICON ALIGNS IN APP BUTTON
enum CustomAlign { start, startTitle, endTitle, end }

///* RADIO BUTTON TYPES
enum RadioButtonType { outline, filled, done }

///* APPLICATION ENVIRONMENT TYPES - USE IN API STATES
enum EnvironmentType {
  local(id: 0, label: 'Local', slug: 'local'),
  development(id: 1, label: 'Development', slug: 'development'),
  staging(id: 2, label: 'Staging', slug: 'staging'),
  production(id: 3, label: 'Production', slug: 'production');

  final int id;
  final String label;
  final String slug;

  const EnvironmentType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static EnvironmentType fromSlug(String slug) {
    return EnvironmentType.values.firstWhere((e) => e.slug == slug);
  }
}
