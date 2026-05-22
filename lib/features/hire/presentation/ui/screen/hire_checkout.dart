import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_body.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/hire_top_section.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/utils.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
import 'package:ambuhub/features/order/presentation/ui/order_receipt_args.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HireCheckoutScreen extends HookWidget {
  final ServiceEntity service;

  const HireCheckoutScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = useState(1);
    final selectedStartDate = useState<DateTime?>(DateTime.now());
    final selectedEndDate = useState<DateTime?>(DateTime.now());
    final errorText = useState<String?>('Adjust the period so the end is after the start');
    final billingUnits = useState<int?>(null);
    final startDateController = useTextEditingController(
      text: selectedStartDate.value?.toString().split(' ')[0] ?? '',
    );
    final endDateController = useTextEditingController(
      text: selectedEndDate.value?.toString().split(' ')[0] ?? '',
    );
    useEffect(() {
      final start = selectedStartDate.value;
      final end = selectedEndDate.value;
      if (start != null && end != null) {
        billingUnits.value = hirePeriodUnitCount(
          start: start,
          end: end,
          pricePeriod: service.pricePeriod,
        );
      }
      return null;
    }, [selectedStartDate.value, selectedEndDate.value]);
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCreated) {
          Navigator.pushNamed(
            context,
            AppRoutes.orderReceiptScreen,
            arguments: OrderReceiptArgs.fromOrder(state.order!),
          );
        }
        if (state is OrderCreatedFailure) {
          showCustomFlushBar(
            context,
            message: state.errorMessage ?? 'Order failed',
            title: 'Error',
            type: AppFlushBarType.error,
          );
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            const HireTopSection(),
            HireBody(
              service: service,
              quantity: quantity,
              selectedStartDate: selectedStartDate,
              selectedEndDate: selectedEndDate,
              errorText: errorText,
              startDateController: startDateController,
              endDateController: endDateController,
              billingUnits: billingUnits,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.all(15.r).copyWith(top: 0),
                child: Text(
                  '← Back to category',
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11.sp,
                    color: AppColours.penBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
