import 'package:ambuhub/config/app_colour.dart';
import 'package:ambuhub/features/order/core/util/order_receipt_pdf_exporter.dart';
import 'package:ambuhub/features/order/domain/entities/order_entity.dart';
import 'package:ambuhub/features/services/presentation/ui/market_place/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveReceiptContainer extends StatefulWidget {
  final OrderEntity order;

  const SaveReceiptContainer({super.key, required this.order});

  @override
  State<SaveReceiptContainer> createState() => _SaveReceiptContainerState();
}

class _SaveReceiptContainerState extends State<SaveReceiptContainer> {
  bool _isSharing = false;

  Future<void> _onSharePdf() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await OrderReceiptPdfExporter.share(widget.order);
    } catch (e, st) {
      debugPrint('Receipt PDF share failed: $e\n$st');
      if (!mounted) return;
      showCustomFlushBar(
        context,
        message: 'Could not create or share the receipt PDF. Try again.',
        title: 'Error',
        type: AppFlushBarType.error,
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _isSharing ? null : _onSharePdf,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: AppColours.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColours.hireCyanBright),
        ),
        alignment: Alignment.center,
        child: _isSharing
            ? const CupertinoActivityIndicator(color: AppColours.darkVividTeal)
            : Text(
                'Print / Save as PDF',
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  color: AppColours.darkVividTeal,
                ),
              ),
      ),
    );
  }
}
