library;

/// ***********************************************************************************
/// *                                  LOCAL ENUMS                                    *
/// ***********************************************************************************

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

///* APPLICATION NOTIFICATION STATES
enum NotificationState { open, background, kill }

///* APP BUTTON VARIANTS
enum ButtonType {
  elevated(id: 0, label: "Elevated", slug: "elevated"),
  gradient(id: 1, label: "Gradient", slug: "gradient"),
  outline(id: 2, label: "Outline", slug: "outline");

  final int id;
  final String label;
  final String slug;

  const ButtonType({
    required this.id,
    required this.label,
    required this.slug,
  });

  static ButtonType fromSlug(String slug) {
    return ButtonType.values.firstWhere((e) => e.slug == slug);
  }
}

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
