import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/core/widgets/gradient_background.dart';
import 'package:ambuhub/features/hire/presentation/ui/widgets/shadowed_container.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';
import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';
import 'package:ambuhub/features/order/presentation/ui/order_receipt_args.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/back_button_container.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/continue_shopping_container.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/items_builders.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/order_receipt_top_section.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/payment_reference_container.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/receipt_sub_total.dart';
import 'package:ambuhub/features/order/presentation/ui/widget/save_receipt_container.dart';
import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderReceiptScreen extends HookWidget {
  final OrderReceiptArgs args;

  const OrderReceiptScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (!args.hasLines) {
        context.read<OrderBloc>().add(GetOrderById(orderId: args.orderId));
      }
      return null;
    }, [args.orderId]);

    if (args.hasLines) {
      return _ReceiptScaffold(order: args.preview!);
    }

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final loadedOrder = state is OrderDetailLoaded &&
                state.order?.id == args.orderId
            ? state.order!
            : null;

        if (loadedOrder != null) {
          return _ReceiptScaffold(order: loadedOrder);
        }

        if (state is OrderDetailFailure) {
          return _ReceiptScaffold(
            body: Center(
              child: ErrorSection(
                onPressed: () => context.read<OrderBloc>().add(
                      GetOrderById(orderId: args.orderId),
                    ),
                errorMessage:
                    state.errorMessage ?? 'Failed to load order details',
              ),
            ),
          );
        }

        return _ReceiptScaffold(
          body: const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

class _ReceiptScaffold extends StatelessWidget {
  final OrderEntity? order;
  final Widget? body;

  const _ReceiptScaffold({this.order, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              const GradientBackground(),
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButtonContainer(),
                    SizedBox(height: 15.h),
                    if (body != null)
                      SizedBox(
                        height: 280.h,
                        width: double.infinity,
                        child: body,
                      )
                    else if (order != null)
                      _ReceiptContent(order: order!),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReceiptContent extends StatelessWidget {
  final OrderEntity order;

  const _ReceiptContent({required this.order});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      bodyStops: const [0.0, 0.1, 0.8, 1.0],
      topStops: const [0.0, 0.5, 1.0],
      shadowColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.7,
      )!,
      topGradientColors: const [
        AppColours.actionBlue,
        AppColours.hireCyanBright,
        AppColours.penBlue,
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      bodyGradientColors: [
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
        AppColours.white,
        AppColours.white,
        Color.lerp(AppColours.hireCyanBright, AppColours.white, 0.7)!,
      ],
      borderColor: Color.lerp(
        AppColours.hireCyanBright,
        AppColours.white,
        0.5,
      )!,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.h,
        children: [
          OrderReceiptTopSection(order: order),
          ItemsBuilders(items: order.lines),
          ReceiptSubTotalContainer(subtotalNgn: order.subtotalNgn),
          PaymentReferenceContainer(order: order),
          SaveReceiptContainer(order: order),
          const ContinueShoppingContainer(),
        ],
      ),
    );
  }
}
