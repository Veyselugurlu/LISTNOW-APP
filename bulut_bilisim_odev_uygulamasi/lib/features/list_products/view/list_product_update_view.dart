import 'package:barcode_widget/barcode_widget.dart';
import '../../../core/model/item_model.dart';
import '../viewModel/list_products_view_model.dart';
import '../../../product/constant/product_border_radius.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/util/product_validators.dart';
import '../../../product/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class ListProductUpdateView extends StatelessWidget {
  const ListProductUpdateView({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () => {
        if (context.mounted)
          {context.read<ListProductsViewModel>().updateProductInit(itemModel)},
      },
    );

    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const ProductPadding.horizontalMedium(),
        child: Form(
          key: context.read<ListProductsViewModel>().formKey,
          child: Column(
            children: [
              CustomTextField(
                controller:
                    context.read<ListProductsViewModel>().titleController,
                hintText: "Başlık",
                isObscure: false,
                validator:
                    (value) =>
                        ProductValidators.validateNotEmptyAndMinTwo(value),
              ),
              CustomSizedBox.getSmall015Seperator(context),
              CustomTextField(
                controller:
                    context.read<ListProductsViewModel>().contentController,
                hintText: "Açıklama",
                isObscure: false,
                lineNumber: 3,
                validator:
                    (value) =>
                        ProductValidators.validateNotEmptyAndMinTwo(value),
              ),
              CustomSizedBox.getSmall015Seperator(context),
              _buildBarcodeRow(context),
              CustomSizedBox.getSmall015Seperator(context),
              _buildBarcodeContainer(),
              CustomSizedBox.getSmall025Seperator(context),
              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(
                    context.sized.dynamicWidth(0.6),
                    context.sized.dynamicHeight(0.0075),
                  ),
                ),
                onPressed: () {
                  context.read<ListProductsViewModel>().updateProduct(
                    context,
                    itemModel,
                  );
                },
                child: Text("Güncelle"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarcodeContainer() {
    return Consumer<ListProductsViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          padding: ProductPadding.allLow(),
          decoration: BoxDecoration(
            color: ProductColors.instance.green6,
            border: Border.all(color: ProductColors.instance.firefly),
            borderRadius: ProductBorderRadius.circularHigh(),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.barcode_reader,
                    color: ProductColors.instance.grey700,
                  ),
                  CustomSizedBox.getSmall001HorizontalSeperator(context),
                  Text(
                    "Barkod Numarası",
                    style: context.general.textTheme.titleMedium!.copyWith(
                      color: ProductColors.instance.grey700,
                    ),
                  ),
                ],
              ),
              CustomSizedBox.getSmall0005Seperator(context),
              viewModel.scanResult.isEmpty
                  ? Column(
                    children: [
                      Center(
                        child: Text(
                          "Herhangi bir barkod okutulmadı",
                          textAlign: TextAlign.center,
                          style: context.general.textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )
                  : BarcodeWidget(
                    color: ProductColors.instance.firefly,
                    padding: ProductPadding.allLow5(),
                    data: viewModel.scanResult,
                    barcode: Barcode.code128(),
                  ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBarcodeRow(BuildContext context) {
    return SizedBox(
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.1),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Barkod ekleyip işleri daha da kolaylaştırmaya ne dersin?",
              style: context.general.textTheme.titleMedium!.copyWith(
                color: ProductColors.instance.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          CustomSizedBox.getSmall001HorizontalSeperator(context),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              fixedSize: Size(
                context.sized.dynamicWidth(0.4),
                context.sized.dynamicHeight(0.075),
              ),
            ),
            onPressed: () {
              context.read<ListProductsViewModel>().scan(context: context);
            },
            child: Padding(
              padding: ProductPadding.allLow(),
              child: Column(
                children: [
                  Icon(Icons.barcode_reader),
                  CustomSizedBox.getSmall0005Seperator(context),
                  Text("Barkod Okut"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Ürün Düzünleme"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<ListProductsViewModel>().clearFields();
        },
        icon: Icon(Icons.close),
      ),
    );
  }
}
