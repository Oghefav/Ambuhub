import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/core/utililty/app_formatter.dart';
  import 'package:ambuhub/features/hire/domain/entities/hire_params.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/icon_non_gradient_container.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalPriceAndPayment extends StatelessWidget {
  final ServiceEntity service;
  final ValueNotifier<int> quantity;
  final ValueNotifier<String?> errorText;
  final ValueNotifier<int?> billingUnits;
  final DateTime hireStartDate;
  final DateTime hireEndDate;

  const TotalPriceAndPayment({
    super.key,
    required this.service,
    required this.quantity,
    required this.errorText,
    required this.billingUnits,
    required this.hireStartDate,
    required this.hireEndDate,
  });

  String _totalPriceLabel(int qty, int? units) {
    if (units == null) return '—';
    return formatCurrency((service.price ?? 0) * qty * units);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<int?>(
      valueListenable: billingUnits,
      builder: (context, units, _) {
        return ValueListenableBuilder<int>(
          valueListenable: quantity,
          builder: (context, qty, __) {
            return ValueListenableBuilder<String?>(
              valueListenable: errorText,
              builder: (context, _, ___) {
                final priceLabel = _totalPriceLabel(qty, units);

                return Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColours.darkVividTeal,
                        AppColours.penBlue,
                        AppColours.darkVividTeal,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColours.hireCyanTeal),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      spacing: 10.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 10.w,
                          children: [
                            IconNonGradientContainer(
                              icon: LucideIcons.credit_card,
                              color: AppColours.teal,
                              addBorder: true,
                              borderColor: AppColours.hireCyanTeal,
                              iconColor: AppColours.white,
                              size: 15.sp,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total price',
                                  style: textTheme.titleSmall?.copyWith(
                                    color: AppColours.veryLightGrey,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                
                                Text(
                                  priceLabel,
                                  style: textTheme.titleSmall?.copyWith(
                                    color: AppColours.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _hirePaymentButton(context, units, qty, priceLabel, hireStartDate, hireEndDate),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _hirePaymentButton(
    BuildContext context,
    int? units,
    int quantity,
    String priceLabel,
    DateTime hireStartDate,
    DateTime hireEndDate,
  ) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final isLoading = state is OrderLoading;
        final isDisabled =
            isLoading || errorText.value != null;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isDisabled
                ? null
                : () => BlocProvider.of<OrderBloc>(context).add(
                    CheckoutHire(
                      params: HireParams(
                        serviceId: service.id,
                        quantity: quantity,
                        hireStart: hireStartDate,
                        hireEnd: hireEndDate,
                      ),
                    ),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColours.white,
              disabledBackgroundColor: AppColours.hireBlueGrey,
              disabledForegroundColor: AppColours.penBlue,
              foregroundColor: AppColours.penBlue,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading) ...[
                  const CupertinoActivityIndicator(color: AppColours.penBlue),
                  SizedBox(width: 8.w),
                ],
                Text(
                  'Pay with Paystck (simuated)',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColours.penBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
