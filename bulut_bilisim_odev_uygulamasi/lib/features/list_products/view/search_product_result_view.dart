import 'package:bulut_bilisim_odev_uygulamasi/core/model/item_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/routes/routes.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/list_products/viewModel/list_products_view_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/list_products/widget/item_card.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_colors.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_padding.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class SearchProductResultView extends StatelessWidget {
  const SearchProductResultView({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ListProductsViewModel>().clearFields();
          },
          icon: Icon(Icons.close),
        ),
        title: const Text("Barkod ile Ürün Arama"),
      ),
      body: Column(
        children: [
          CustomSizedBox.getSmall015Seperator(context),
          Card(
            margin: ProductPadding.allLow(),
            elevation: 2,
            color: ProductColors.instance.white,
            child: Padding(
              padding: const ProductPadding.allLow(),
              child: Row(
                children: [
                  Text(
                    "Bulunan Ürün",
                    style: context.general.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomSizedBox.getSmall0005Seperator(context),
          ItemCard(item: itemModel, onDelete: null),
        ],
      ),
    );
  }
}
