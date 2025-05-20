import '../viewModel/home_view_model.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/widget/divider_close_button.dart';
import '../../../product/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class ListAddView extends StatelessWidget {
  const ListAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          color: ProductColors.instance.offgreen,
          width: context.sized.dynamicWidth(1),
          height: context.sized.dynamicHeight(0.3),
          child: Column(
            children: [
              DividerCloseButton(),
              Padding(
                padding: const ProductPadding.horizontalMedium(),
                child: Row(
                  children: [
                    Text(
                      "Liste Oluşturma",
                      style: context.general.textTheme.titleMedium!.copyWith(
                        color: ProductColors.instance.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox.getSmall0005Seperator(context),
              Padding(
                padding: const ProductPadding.allMedium(),
                child: CustomTextField(
                  controller: context.read<HomeViewModel>().titleController,
                  hintText: "Başlık",
                  isObscure: false,
                ),
              ),
              CustomSizedBox.getSmall025Seperator(context),
              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(
                    context.sized.dynamicWidth(0.6),
                    context.sized.dynamicHeight(0.0075),
                  ),
                ),
                onPressed: () {
                  context.read<HomeViewModel>().createList(context);
                },
                child: Text("Oluştur"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
