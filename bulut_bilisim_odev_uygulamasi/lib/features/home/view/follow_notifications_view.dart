// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_colors.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/constant/product_padding.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_sized_box.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/product_util.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/model/folow_state_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/service/snapshot_manager.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/home/viewModel/home_view_model.dart';

class FollowNotificationsView extends StatelessWidget {
  const FollowNotificationsView({super.key, required this.currentUsername});

  final String currentUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gelen İstekler"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer2<SnapshotManager, HomeViewModel>(
        builder: (context, snapshotManager, viewModel, _) {
          return StreamBuilder<List<FollowStateModel>>(
            stream: snapshotManager.getActiveFollowNotifications(
              currentUsername,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Gelen istek yok"));
              }

              final follow_notifications = snapshot.data!;

              return ListView.builder(
                itemCount: follow_notifications.length,
                itemBuilder: (context, index) {
                  final follow_notification = follow_notifications[index];

                  return Card(
                    margin: ProductPadding.allLow(),
                    color: ProductColors.instance.white,
                    elevation: 4,
                    child: Padding(
                      padding: ProductPadding.allMedium(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ProductColors.instance.grey700,
                                child: Icon(
                                  Icons.person,
                                  color: ProductColors.instance.grey300,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Gönderen: ",
                                        style: context
                                            .general
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color:
                                                  ProductColors
                                                      .instance
                                                      .grey700,
                                            ),
                                      ),
                                      TextSpan(
                                        text: follow_notification.userFrom,
                                        style: context
                                            .general
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Liste başlığı:",
                                style: context.general.textTheme.titleMedium!
                                    .copyWith(
                                      color: ProductColors.instance.grey700,
                                    ),
                              ),
                              CustomSizedBox.getSmall0005Seperator(context),
                              Text(
                                follow_notification.listTitle,
                                style: context.general.textTheme.bodyMedium!
                                    .copyWith(
                                      color: ProductColors.instance.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          CustomSizedBox.getSmall015Seperator(context),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: ProductColors.instance.grey600,
                              ),
                              CustomSizedBox.getSmall001HorizontalSeperator(
                                context,
                              ),
                              Text(
                                ProductUtil.formatTimestamp(
                                  follow_notification.time,
                                ),
                                style: context.general.textTheme.titleSmall!
                                    .copyWith(
                                      color: ProductColors.instance.grey,
                                    ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  viewModel.declineRequest(
                                    context: context,
                                    notificationId: follow_notification.id,
                                  );
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ProductColors.instance.errorRed,
                                ),
                                label: Text(
                                  "Reddet",
                                  style: context.general.textTheme.titleSmall!
                                      .copyWith(
                                        color: ProductColors.instance.errorRed,
                                      ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      ProductColors.instance.errorRed,
                                  side: BorderSide(
                                    color: ProductColors.instance.errorRed,
                                  ),
                                ),
                              ),
                              CustomSizedBox.getSmall0025HorizontalSeperator(
                                context,
                              ),
                              FilledButton.icon(
                                onPressed: () {
                                  viewModel.acceptRequest(
                                    context: context,
                                    notificationId: follow_notification.id,
                                    listId: follow_notification.listId,
                                    username: follow_notification.userFrom,
                                  );
                                },
                                icon: const Icon(Icons.check),
                                label: Text(
                                  "Kabul Et",
                                  style: context.general.textTheme.titleSmall!
                                      .copyWith(
                                        color: ProductColors.instance.white,
                                      ),
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor:
                                      ProductColors.instance.successGreen,
                                  foregroundColor: ProductColors.instance.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
