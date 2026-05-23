import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_period_card.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_quantity_container.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_service_details_card.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/total_price_and_payment.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/utils.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireBody extends StatelessWidget {
  final ServiceEntity service;
  final ValueNotifier<int> quantity;
  final ValueNotifier<DateTime?> selectedStartDate;
  final ValueNotifier<DateTime?> selectedEndDate;
  final ValueNotifier<String?> errorText;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final ValueNotifier<int?> billingUnits;

  const HireBody({
    super.key,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.errorText,
    required this.startDateController,
    required this.endDateController,
    required this.service,
    required this.quantity,
    required this.billingUnits,
  });

  String get _billingPeriod => hireBillingPeriodLabel(service.pricePeriod);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Column(
        spacing: 20.h,
        children: [
          HireServiceDetailsCard(
            service: service,
            billingPeriod: _billingPeriod,
          ),
          HireQuantityContainer(service: service, quantity: quantity),
          HirePeriodCard(
            service: service,
            selectedStartDate: selectedStartDate,
            selectedEndDate: selectedEndDate,
            errorText: errorText,
            startDateController: startDateController,
            endDateController: endDateController,
            billingPeriod: _billingPeriod,
            billingUnits: billingUnits,
          ),
          TotalPriceAndPayment(
            service: service,
            quantity: quantity,
            errorText: errorText,
            billingUnits: billingUnits,
            hireStartDate: selectedStartDate.value ?? DateTime.now(),
            hireEndDate: selectedEndDate.value ?? DateTime.now(),
          ),
        ],
      ),
    );
  }
}
