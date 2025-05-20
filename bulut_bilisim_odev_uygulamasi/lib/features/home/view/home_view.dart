import 'package:bulut_bilisim_odev_uygulamasi/core/model/folow_state_model.dart';

import '../../../core/model/list_model.dart';
import '../../../core/routes/routes.dart';
import '../../../core/service/snapshot_manager.dart';
import '../viewModel/home_view_model.dart';
import '../../../product/constant/product_border_radius.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/util/product_util.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        context.read<HomeViewModel>().init();
      }
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer2<HomeViewModel, SnapshotManager>(
      builder: (context, homeViewModel, snapshotManager, _) {
        return TabBarView(
          children: [
            StreamBuilder<List<ListModel>>(
              stream: snapshotManager.listSnapshot(
                homeViewModel.username ?? "",
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
                      (context, index) => buildListCard(
                        context: context,
                        list: lists[index],
                        onEdit: () {
                          Navigator.pushNamed(
                            context,
                            Routes.USER_LIST_UPDATE,
                            arguments: {'listModel': lists[index]},
                          );
                        },
                        onDelete: () {
                          homeViewModel.deleteList(
                            context,
                            lists[index].uuid ?? "",
                          );
                        },
                        onShow: () {
                          Navigator.pushNamed(
                            context,
                            Routes.LIST_PRODUCTS,
                            arguments: {
                              'listId': lists[index].uuid,
                              'listName': lists[index].title,
                            },
                          );
                        },
                      ),
                );
              },
            ),
            StreamBuilder<List<ListModel>>(
              stream: snapshotManager.joinedListSnapshot(
                homeViewModel.username ?? "",
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
                      (context, index) => buildListCard(
                        context: context,
                        list: lists[index],
                        onShow: () {
                          Navigator.pushNamed(
                            context,
                            Routes.LIST_PRODUCTS,
                            arguments: {
                              'listId': lists[index].uuid,
                              'listName': lists[index].title,
                            },
                          );
                        },
                      ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text("Hoş Geldin 👋", style: context.general.textTheme.headlineSmall),
        ],
      ),
      actions: [
        Padding(
          padding: ProductPadding.horizontalLow(),
          child: Consumer2<SnapshotManager, HomeViewModel>(
            builder: (context, snapshotManager, viewModel, _) {
              return StreamBuilder<List<FollowStateModel>>(
                stream: snapshotManager.getActiveFollowNotifications(
                  viewModel.username ?? "",
                ),
                builder: (context, snapshot) {
                  final count = snapshot.data?.length ?? 0;

                  return InkWell(
                    borderRadius: ProductBorderRadius.circularHigh(),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.FOLLOW_NOTIFICATIONS,
                        arguments: {"username": viewModel.username ?? ""},
                      );
                    },
                    child: Badge(
                      isLabelVisible: count > 0,
                      label: Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      smallSize: context.sized.dynamicWidth(0.03),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ProductColors.instance.firefly,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_none,
                          color: ProductColors.instance.firefly,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
      bottom: const TabBar(
        tabs: [
          Tab(text: "Listelerim", icon: Icon(Icons.list_alt)),
          Tab(text: "Katıldıklarım", icon: Icon(Icons.group)),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ProductColors.instance.green6),
            child: Center(
              child: Text(
                "LISTNOW",
                style: context.general.textTheme.displayLarge!.copyWith(
                  color: ProductColors.instance.firefly,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: ProductPadding.allMedium(),
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<HomeViewModel>().logout(context);
              },
              icon: Icon(Icons.logout, color: ProductColors.instance.errorRed),
              label: Text(
                "Çıkış Yap",
                style: context.general.textTheme.titleMedium!.copyWith(
                  color: ProductColors.instance.errorRed,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: ProductColors.instance.errorRed,
                side: BorderSide(color: Colors.red.shade200, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: ProductBorderRadius.circularMedium(),
                ),
                padding: ProductPadding.allMedium(),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListCard({
    required BuildContext context,
    required ListModel list,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    VoidCallback? onShow,
  }) {
    final creationDate =
        list.creationDate != null
            ? ProductUtil.formatTimestamp(list.creationDate!)
            : "Bilinmiyor";
    final userCount = list.usersOfList?.length ?? 0;

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
          padding: const EdgeInsets.all(16.0),
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
                        "$userCount kişi",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      onEdit != null
                          ? IconButton(
                            onPressed: onEdit,
                            icon: Icon(
                              Icons.edit,
                              color: ProductColors.instance.electricBlue,
                            ),
                            tooltip: "Düzenle",
                          )
                          : SizedBox.shrink(),
                      onDelete != null
                          ? IconButton(
                            onPressed: onDelete,
                            icon: Icon(
                              Icons.delete,
                              color: ProductColors.instance.errorRed,
                            ),
                            tooltip: "Sil",
                          )
                          : SizedBox.shrink(),
                    ],
                  ),
                  TextButton(
                    onPressed: onShow,
                    child: Row(
                      children: [
                        Text(
                          "Görüntüle",
                          style: context.general.textTheme.titleMedium!
                              .copyWith(
                                color: ProductColors.instance.darkGreen,
                              ),
                        ),
                        CustomSizedBox.getSmall001HorizontalSeperator(context),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ProductColors.instance.darkGreen,
                        ),
                      ],
                    ),
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
