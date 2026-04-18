String getDepartmentSlug(String deptName) {
  switch (deptName) {
    // Personnel
    case 'Ambulance Driver':
      return 'ambulance-driver';
    case 'Basic Emergency Medical Technician':
      return 'basic-emergency-medical-technician';
    case 'Paramedic (Air/Ground Ambulance)':
      return 'ambulance-paramedic';
    case 'Ambulance Nurse':
      return 'ambulance-nurse';
    case 'Ambulance Doctor':
      return 'ambulance-doctor';
    case 'Emergency Physician':
      return 'emergency-physician';
    case 'Intensivist':
      return 'intensivist';

    // Servicing
    case 'Ambulance Sales':
      return 'ambulance-sales';
    case 'Ambulance Maintenance':
      return 'ambulance-maintenance';
    case 'Ambulance equipment':
      return 'ambulance-equipment';

    // Medical Transport
    case 'Ground Ambulance':
      return 'ground-ambulance';
    case 'Air Ambulance':
      return 'air-ambulance';
    case 'Cargo for Remains (Local and international)':
      return 'cargo-for-remains-local-and-international';
    case 'Hearse for remains':
      return 'hearse-for-remains';
    case 'Community Provider':
      return 'community-provider';

    default:
      return deptName.toLowerCase().replaceAll(' ', '-');
  }
}
