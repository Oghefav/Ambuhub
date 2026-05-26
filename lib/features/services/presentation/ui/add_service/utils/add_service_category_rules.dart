/// Listing-type rules for the add-service form by category name (from API).
class AddServiceCategoryRules {
  static String _norm(String name) => name.trim().toLowerCase();

  static bool isMedicalTransport(String category) =>
      _norm(category) == 'medical transport';

  static bool isAmbulancePersonnel(String category) =>
      _norm(category) == 'ambulance personnel';

  static bool isAmbulanceServicingOrSales(String category) {
    final n = _norm(category);
    return n == 'ambulance servicing' ||
        n == 'ambulance sales and services' ||
        (n.contains('ambulance') && n.contains('sales'));
  }

  static bool isAmbulanceEquipment(String category) =>
      _norm(category) == 'ambulance equipment';

  /// When non-null, listing type is fixed for this category.
  static String? forcedListingType(String category) {
    if (isMedicalTransport(category)) return 'Hire';
    if (isAmbulancePersonnel(category) || isAmbulanceServicingOrSales(category)) {
      return 'Book';
    }
    return null;
  }

  static List<String> listingTypeOptions(String category) {
    if (category.isEmpty) return [];
    if (isAmbulanceEquipment(category)) {
      return ['Sale', 'Hire'];
    }
    final forced = forcedListingType(category);
    if (forced != null) return [forced];
    return ['Sale', 'Hire', 'Book'];
  }

  static bool isListingTypeLocked(String category) =>
      forcedListingType(category) != null;

  static String listingTypeDisabledHint(String category) {
    if (category.isEmpty) return 'Choose a category first';
    if (isMedicalTransport(category)) {
      return 'Hire';
    }
    if (isAmbulancePersonnel(category) || isAmbulanceServicingOrSales(category)) {
      return 'Book';
    }
    if (isAmbulanceEquipment(category)) {
      return 'Equipment can be sale or hire only';
    }
    return 'Choose a category first';
  }

  static bool isHire(String? listingType) =>
      listingType?.trim().toLowerCase() == 'hire';

  static bool isSale(String? listingType) =>
      listingType?.trim().toLowerCase() == 'sale';

  static bool isBook(String? listingType) =>
      listingType?.trim().toLowerCase() == 'book';

  static bool areStockAndPriceAllowed(String? listingType) =>
      isSale(listingType) || isHire(listingType);

  /// Hint when stock/price fields are disabled (Book-only category or Book listing).
  static String stockAndPriceDisabledHint({
    required String category,
    required String? listingType,
  }) {
    if (category.isEmpty) return 'Choose a category first';
    final forced = forcedListingType(category);
    if (forced != null && isBook(forced)) {
      return 'Available for Sale and Hire listings';
    }
    final type = listingType?.trim() ?? '';
    if (type.isEmpty) return 'Choose a listing type first';
    if (isBook(listingType)) {
      return 'Available for Sale and Hire listings';
    }
    return 'Choose a listing type first';
  }
}
