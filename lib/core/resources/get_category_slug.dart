String getCategorySlug(String categoryName) {
  switch (categoryName) {
    case 'Ambulance personnel':
      return 'personnel';
    case 'Ambulance servicing':
      return 'ambulance-servicing';
    case 'Medical transport':
      return 'medical-transport';
    default:
      // Fallback: convert to lowercase and replace spaces if no match found
      return categoryName.toLowerCase().replaceAll(' ', '-');
  }
}
