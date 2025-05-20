import '../../../core/model/list_model.dart';
import '../viewModel/home_view_model.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/util/product_validators.dart';
import '../../../product/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class ListUpdateView extends StatelessWidget {
  final ListModel listModel;

  const ListUpdateView({super.key, required this.listModel});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        context.read<HomeViewModel>().updateListInit(listModel);
      }
    });

    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const ProductPadding.horizontalLow5(),
            child: Text(
              "Başlık",
              style: context.general.textTheme.titleMedium!.copyWith(
                color: ProductColors.instance.grey700,
              ),
            ),
          ),
          CustomSizedBox.getSmall0005Seperator(context),
          Form(
            key: context.read<HomeViewModel>().updateFormKey,
            child: CustomTextField(
              controller: context.read<HomeViewModel>().titleController,
              hintText: "Başlık",
              isObscure: false,
              validator:
                  (value) => ProductValidators.validateNotEmptyAndMinTwo(value),
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kullanıcılar",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          _buildUserList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(
                    context.sized.dynamicWidth(0.6),
                    context.sized.dynamicHeight(0.0075),
                  ),
                ),
                onPressed: () {
                  context.read<HomeViewModel>().updateList(context, listModel);
                },
                child: Text("Güncelle"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Expanded(
          child:
              listModel.usersOfList == null || listModel.usersOfList!.isEmpty
                  ? const Center(child: Text("Listede kullanıcı yok."))
                  : ListView.separated(
                    itemCount: listModel.usersOfList!.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final username = listModel.usersOfList![index];
                      final isActive =
                          viewModel.usernameAndState[username] ?? true;

                      return Card(
                        color:
                            isActive
                                ? ProductColors.instance.green6
                                : ProductColors.instance.grey,
                        elevation: 3,
                        margin: const ProductPadding.allLow5(),
                        child: Padding(
                          padding: const ProductPadding.allLow(),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    isActive
                                        ? ProductColors.instance.darkGreen
                                        : Colors.grey.shade300,
                                child: Icon(
                                  Icons.person,
                                  color:
                                      isActive
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  username,
                                  style: context.general.textTheme.titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        decoration:
                                            isActive
                                                ? null
                                                : TextDecoration.lineThrough,
                                        color:
                                            isActive
                                                ? ProductColors.instance.black
                                                : ProductColors
                                                    .instance
                                                    .grey700,
                                      ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  viewModel.changeUsernameState(username);
                                },
                                icon: Icon(
                                  isActive ? Icons.remove_circle : Icons.undo,
                                  color:
                                      isActive
                                          ? ProductColors.instance.errorRed
                                          : ProductColors.instance.successGreen,
                                ),
                                label: Text(
                                  isActive ? "Çıkar" : "Geri Al",
                                  style: TextStyle(
                                    color:
                                        isActive
                                            ? ProductColors.instance.errorRed
                                            : ProductColors
                                                .instance
                                                .successGreen,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      isActive
                                          ? ProductColors.instance.errorRed
                                          : ProductColors.instance.successGreen,
                                  side: BorderSide(
                                    color:
                                        isActive
                                            ? ProductColors.instance.errorRed
                                            : ProductColors
                                                .instance
                                                .successGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Liste Güncelleme"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<HomeViewModel>().clearFields();
        },
        icon: Icon(Icons.close),
      ),
    );
  }
}
