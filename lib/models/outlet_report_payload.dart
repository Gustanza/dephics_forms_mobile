/// Payload model for the outlet interaction report API.
/// [toMap] only includes keys for non-null values so the server receives
/// only fields that were actually provided.
class OutletReportPayload {
  const OutletReportPayload({
    this.projectId,
    this.date,
    this.activator,
    this.outletName,
    this.outletPhone,
    this.outletPicture,
    this.outletStreet,
    this.region,
    this.district,
    this.category,
    this.awareKnauf,
    this.productAvailability,
    this.knaufProducts,
    this.stockingChallenges,
    this.competitorProducts,
    this.competitorOther,
    this.competitorTopSeller,
    this.customerFeedback,
    this.customerFeedbackOther,
    this.orderPressed,
    this.orderProducts,
    this.orderQuantities,
    this.orderStatus,
    this.brandingMaterials,
    this.outletPictureAfter,
    this.notes,
    this.gpsCoordinates,
  });

  final String? projectId;
  final String? date;
  final String? activator;
  final String? outletName;
  final String? outletPhone;
  final dynamic outletPicture; // File or URL when uploading
  final String? outletStreet;
  final String? region;
  final String? district;
  final String? category;
  final String? awareKnauf;
  final String? productAvailability;
  final List<String>? knaufProducts;
  final String? stockingChallenges;
  final List<String>? competitorProducts;
  final String? competitorOther;
  final String? competitorTopSeller;
  final List<String>? customerFeedback;
  final String? customerFeedbackOther;
  final String? orderPressed;
  final List<String>? orderProducts;
  final Map<String, int>? orderQuantities;
  final String? orderStatus;
  final List<String>? brandingMaterials;
  final dynamic outletPictureAfter; // File or URL when uploading
  final String? notes;
  final String? gpsCoordinates;

  /// Builds a JSON-like map containing only keys whose values are not null.
  /// Nested lists and maps are included as-is when non-null.
  Map<String, dynamic> toMap() {
    return _buildMap(<String, dynamic>{
      'projectId': projectId,
      'date': date,
      'activator': activator,
      'outletName': outletName,
      'outletPhone': outletPhone,
      'outletPicture': outletPicture,
      'outletStreet': outletStreet,
      'region': region,
      'district': district,
      'category': category,
      'awareKnauf': awareKnauf,
      'productAvailability': productAvailability,
      'knaufProducts': knaufProducts,
      'stockingChallenges': stockingChallenges,
      'competitorProducts': competitorProducts,
      'competitorOther': competitorOther,
      'competitorTopSeller': competitorTopSeller,
      'customerFeedback': customerFeedback,
      'customerFeedbackOther': customerFeedbackOther,
      'orderPressed': orderPressed,
      'orderProducts': orderProducts,
      'orderQuantities': orderQuantities,
      'orderStatus': orderStatus,
      'brandingMaterials': brandingMaterials,
      'outletPictureAfter': outletPictureAfter,
      'notes': notes,
      'gpsCoordinates': gpsCoordinates,
    });
  }

  /// Only adds entries for non-null values so the payload stays minimal.
  static Map<String, dynamic> _buildMap(Map<String, dynamic> source) {
    final map = <String, dynamic>{};
    for (final entry in source.entries) {
      if (entry.value != null) {
        map[entry.key] = entry.value;
      }
    }
    return map;
  }
}
