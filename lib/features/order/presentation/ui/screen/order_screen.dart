import 'package:ambuhub/config/app_colour.dart';

import 'package:ambuhub/config/routes.dart';

import 'package:ambuhub/core/widgets/client_app_scaffold.dart';

import 'package:ambuhub/core/widgets/empty_content_page_builder.dart';

import 'package:ambuhub/features/order/presentation/bloc/order/order_bloc.dart';

import 'package:ambuhub/features/order/presentation/bloc/order/order_event.dart';

import 'package:ambuhub/features/order/presentation/bloc/order/order_state.dart';

import 'package:ambuhub/features/order/presentation/ui/widget/orders_header.dart';

import 'package:ambuhub/features/order/presentation/ui/widget/orders_list_builder.dart';

import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_bloc.dart';

import 'package:ambuhub/features/services/presentation/bloc/get_service_categories/get_service_category_state.dart';

import 'package:ambuhub/features/services/presentation/ui/listing/widgets/error_widget.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



class OrderScreen extends StatefulWidget {

  const OrderScreen({super.key});



  static const String _description =

      'Purchases and bookings you have made on Ambuhub. Open a receipt for the full breakdown.';



  @override

  State<OrderScreen> createState() => _OrderScreenState();

}



class _OrderScreenState extends State<OrderScreen> {

  @override

  void initState() {

    super.initState();

    final bloc = context.read<OrderBloc>();

    final s = bloc.state;

    if (!s.hasLoaded || s is OrderCreated || s is OrderCreatedFailure) {

      bloc.add(const GetOrders());

    }

  }



  @override

  Widget build(BuildContext context) {

    return ClientAppScaffold(

      body: BlocBuilder<OrderBloc, OrderState>(

        builder: (context, state) {

          if (state is OrderFailure) {

            return Center(

              child: ErrorSection(

                onPressed: () =>

                    context.read<OrderBloc>().add(const GetOrders()),

                errorMessage: state.errorMessage ?? 'Failed to load orders',

              ),

            );

          }



          if (!state.hasLoaded) {

            return const Center(child: CupertinoActivityIndicator());

          }



          if (state.orders.isEmpty) {

            return BlocBuilder<GetServiceCategoriesBloc,

                GetServiceCategoriesState>(

              builder: (context, categoriesState) {

                return _buildEmptyState(context, categoriesState);

              },

            );

          }



          return SizedBox.expand(

            child: OrdersListBuilder(

              orders: state.orders,

              description: OrderScreen._description,

            ),

          );

        },

      ),

    );

  }



  Widget _buildEmptyState(

    BuildContext context,

    GetServiceCategoriesState categoriesState,

  ) {

    final serviceCategories = categoriesState.serviceCategories;



    return EmptyContentPageBuilder(

      dottedBorderColor: AppColours.hireCyanBright,

      icon: const Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [

          OrdersHeader(description: OrderScreen._description),

        ],

      ),

      placeholderLines: const [

        'No orders yet. Complete a purchase, hire, or booking ',

        'to see your receipts here.',

      ],

      navigationText: 'Explore the marketplace',

      onTap: () {

        if (serviceCategories != null && serviceCategories.isNotEmpty) {

          Navigator.pushNamed(

            context,

            AppRoutes.markerScreen,

            arguments: serviceCategories.first,

          );

        } else {

          Navigator.pushNamed(context, AppRoutes.clientDashBoardScreen);

        }

      },

    );

  }

}

