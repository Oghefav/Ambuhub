import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/config/routes.dart';
import 'package:ambuhub/features/cart/domain/entities/cart.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:ambuhub/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:ambuhub/features/services/domain/enitities/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceButton extends StatelessWidget {
  final ServiceEntity service;
  const ServiceButton({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => service.available == true && service.stock != 0 && service.listingType != null ? _onPressed(context) : null,
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
        },
        child:  Container(
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              color: AppColours.darkVividTeal,
              borderRadius: BorderRadius.circular(10.r),
            ),
            
          )
        
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (service.listingType?.toLowerCase() == 'sale' ){
      context.read<CartBloc>().add(AddCartItem(item: CartItemEntity(service: service, quantity: 1)));
    } else if (service.listingType?.toLowerCase() == 'hire') {
      // TODO: Implement hire logic
      Navigator.pushNamed(context, AppRoutes.serviceDetailScreen, arguments: service);
    } else if (service.listingType?.toLowerCase() == 'book') {
      // TODO: Implement book logic
      Navigator.pushNamed(context, AppRoutes.serviceDetailScreen, arguments: service);
    }
  }
}
