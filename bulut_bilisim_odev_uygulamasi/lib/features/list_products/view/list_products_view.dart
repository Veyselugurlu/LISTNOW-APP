import 'package:bulut_bilisim_odev_uygulamasi/features/home/view/home_view.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/home/viewModel/home_view_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kartal/kartal.dart';

import '../../../core/model/item_model.dart';
import '../../../core/routes/routes.dart';
import '../../../core/service/snapshot_manager.dart';
import '../viewModel/list_products_view_model.dart';
import '../widget/item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductsView extends StatelessWidget {
  const ListProductsView({
    super.key,
    required this.listId,
    required this.listName,
  });

  final String listId;
  final String listName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCustomFab(context),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer2<ListProductsViewModel, SnapshotManager>(
      builder: (context, viewModel, snapshotManager, _) {
        return StreamBuilder<List<ItemModel>>(
          stream: snapshotManager.getListItems(listId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Bu listede hiç öğe yok."));
            }

            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemCard(
                  item: item,
                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      Routes.LIST_PRODUCT_UPDATE,
                      arguments: {"itemModel": items[index]},
                    );
                  },
                  onDelete: () {
                    viewModel.deleteProduct(context, items[index].uuid ?? "");
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildCustomFab(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      icon: Icons.add,
      overlayColor: ProductColors.instance.black,
      overlayOpacity: 0.5,
      childrenButtonSize: Size(
        context.sized.dynamicWidth(0.15),
        context.sized.dynamicHeight(0.075),
      ),
      children: [
        SpeedDialChild(
          child: Icon(Icons.add, color: ProductColors.instance.white),
          label: "Ürün Ekle",

          backgroundColor: ProductColors.instance.darkGreen,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.LIST_PRODUCT_ADD,
              arguments: {'listId': listId},
            );
          },
        ),
        SpeedDialChild(
          child: Icon(
            Icons.barcode_reader,
            color: ProductColors.instance.white,
          ),
          label: "Barcode ile Ürün Ara",
          backgroundColor: ProductColors.instance.darkGreen,
          onTap: () {
            context.read<ListProductsViewModel>().scanAndSearch(
              context: context,
              listId: listId,
            );
          },
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(listName),
      ),
    );
  }
}
