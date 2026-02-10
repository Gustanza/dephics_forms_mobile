/// Configuration for the outlet report API.
/// Set [baseUrl] and [projectId] to match your server, then use
/// [OutletReportService.submitReport] (plug real HTTP there).
class ReportApiConfig {
  ReportApiConfig._();

  /// Base URL of the API (e.g. https://cornerstone.core.tz).
  static const String baseUrl = String.fromEnvironment(
    'REPORT_API_BASE_URL',
    defaultValue: 'https://cornerstone.core.tz',
  );

  /// Project ID for the promotion/report (e.g. 69820637477b92b80d5d5105).
  static const String projectId = String.fromEnvironment(
    'REPORT_PROJECT_ID',
    defaultValue: '69820637477b92b80d5d5105',
  );

  /// Path segment for form-data submission (append to baseUrl).
  static String submitPath(String projectId) =>
      '/promo/$projectId/form-data';
}
