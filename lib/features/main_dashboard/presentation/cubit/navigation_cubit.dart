import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<String> {
  NavigationCubit() : super('dashboard');
  ServiceEntity? selectedService;
  void setPage(String page) => emit(page);
  
}
