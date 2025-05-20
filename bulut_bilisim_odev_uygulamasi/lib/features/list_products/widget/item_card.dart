import 'package:barcode_widget/barcode_widget.dart';
import '../../../core/model/item_model.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ItemCard({super.key, required this.item, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        item.creationDate != null
            ? DateFormat(
              'dd MMM yyyy HH:mm',
            ).format(item.creationDate!.toDate())
            : 'Tarih yok';

    return Card(
      margin: ProductPadding.allLow(),
      color: ProductColors.instance.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title ?? "Başlıksız",
              style: context.general.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            if (item.content != null && item.content!.isNotEmpty)
              Text(
                item.content!,
                style: context.general.textTheme.bodyLarge!.copyWith(
                  color: ProductColors.instance.grey700,
                ),
              ),
            CustomSizedBox.getSmall01Seperator(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (item.barcode != null && item.barcode!.isNotEmpty)
                    ? BarcodeWidget(
                      width: context.sized.dynamicWidth(0.35),
                      height: context.sized.dynamicHeight(0.07),
                      data: item.barcode!,
                      barcode: Barcode.code128(),
                    )
                    : Text(
                      "Barkod mevcut değil",
                      style: context.general.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18),
                    CustomSizedBox.getSmall001HorizontalSeperator(context),
                    Text(formattedDate),
                  ],
                ),
              ],
            ),
            CustomSizedBox.getSmall0005Seperator(context),

            const Divider(),
            CustomSizedBox.getSmall0005Seperator(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                onEdit != null
                    ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ProductColors.instance.electricBlue,
                        side: BorderSide(
                          color: ProductColors.instance.electricBlue,
                        ),
                      ),
                      onPressed: onEdit,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: ProductColors.instance.electricBlue,
                          ),
                          CustomSizedBox.getSmall001HorizontalSeperator(
                            context,
                          ),
                          Text("Düzenle"),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
                CustomSizedBox.getSmall001HorizontalSeperator(context),
                onDelete != null
                    ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ProductColors.instance.errorRed,
                        side: BorderSide(
                          color: ProductColors.instance.errorRed,
                        ),
                      ),
                      onPressed: onDelete,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: ProductColors.instance.errorRed,
                          ),
                          CustomSizedBox.getSmall001HorizontalSeperator(
                            context,
                          ),
                          Text("Sil"),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
