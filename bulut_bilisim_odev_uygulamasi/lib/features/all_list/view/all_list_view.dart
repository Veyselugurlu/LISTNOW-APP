import 'package:bulut_bilisim_odev_uygulamasi/core/model/list_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/service/snapshot_manager.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/all_list/viewmodel/all_list_view_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_border_radius.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_colors.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_padding.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_dialogs.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_sized_box.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/product_util.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class AllListView extends StatelessWidget {
  const AllListView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        context.read<AllListViewModel>().init();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProductColors.instance.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Listelerde ara...",
            prefixIcon: Icon(Icons.search, color: ProductColors.instance.black),
            filled: false,
            fillColor: ProductColors.instance.grey100,
            contentPadding: ProductPadding.allHigh(),
            border: OutlineInputBorder(
              borderRadius: ProductBorderRadius.circularHigh(),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            context.read<AllListViewModel>().ara2(value);
          },
        ),
      ),

      body: Consumer2<AllListViewModel, SnapshotManager>(
        builder: (context, allListViewModel, snapshotManager, _) {
          return StreamBuilder<List<ListModel>>(
            stream: snapshotManager.allListSnapshot(
              allListViewModel.searchWord,
              allListViewModel.currentUsername ?? "",
            ),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: const Text("Hiç liste yok."));
              }

              final lists = snapshot.data!;
              return ListView.builder(
                itemCount: lists.length,
                itemBuilder:
                    (context, index) =>
                        buildListCard(context, lists[index], () {}, () {}),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildListCard(
    BuildContext context,
    ListModel list,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  ) {
    final creationDate =
        list.creationDate != null
            ? ProductUtil.formatTimestamp(list.creationDate!)
            : "Bilinmiyor";

    return Padding(
      padding: const ProductPadding.allLow(),
      child: Container(
        decoration: BoxDecoration(
          color: ProductColors.instance.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ProductColors.instance.grey.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: ProductPadding.allLow(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                list.title ?? "Başlıksız",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ProductColors.instance.darkGreen,
                ),
              ),
              Padding(
                padding: ProductPadding.allLow(),
                child: Row(
                  children: [
                    Icon(Icons.person, color: ProductColors.instance.darkGreen),

                    Text(
                      list.ownerUsername ?? "Başlıksız",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ProductColors.instance.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox.getSmall0005Seperator(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: ProductColors.instance.darkGreen,
                      ),
                      CustomSizedBox.getSmall001HorizontalSeperator(context),
                      Text(
                        creationDate,
                        style: context.general.textTheme.bodyMedium!.copyWith(
                          color: ProductColors.instance.grey600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: ProductColors.instance.darkGreen,
                      ),
                      CustomSizedBox.getSmall001HorizontalSeperator(context),
                      Text(
                        "${list.usersOfList?.length ?? 0} kişi",
                        style: context.general.textTheme.bodyMedium!.copyWith(
                          color: ProductColors.instance.grey600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              CustomSizedBox.getSmall025Seperator(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<bool>(
                    stream: context
                        .read<SnapshotManager>()
                        .followRequestStatusStream(
                          context.read<AllListViewModel>().currentUsername!,
                          list.uuid ?? "",
                        ),
                    builder: (context, snapshot) {
                      final isPending = snapshot.data ?? false;
                      return FilledButton(
                        onPressed:
                            isPending
                                ? null
                                : () async {
                                  await context
                                      .read<AllListViewModel>()
                                      .sendFollowRequestToUser(
                                        context,
                                        list.uuid ?? "",
                                        list.ownerUsername ?? "",
                                        list.title ?? "",
                                      );
                                },
                        style: FilledButton.styleFrom(
                          fixedSize: Size(
                            context.sized.dynamicWidth(0.45),
                            context.sized.dynamicHeight(0.0075),
                          ),
                          disabledBackgroundColor:
                              ProductColors.instance.grey600,
                        ),
                        child: Text(
                          isPending ? "Beklemede" : "Takip Et",
                          style: context.general.textTheme.titleMedium!
                              .copyWith(
                                color: ProductColors.instance.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
