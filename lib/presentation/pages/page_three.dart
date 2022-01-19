import 'package:flutter/material.dart';
import 'package:km_app_test/common/constants.dart';
import 'package:km_app_test/common/state_enum.dart';
import 'package:km_app_test/presentation/provider/selected_user_notifier.dart';
import 'package:km_app_test/presentation/provider/user_list_notifier.dart';
import 'package:provider/provider.dart';

class PageThree extends StatefulWidget {
  static const ROUTE_NAME = '/page-three';

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_pagination);
    super.initState();
    Future.microtask(() =>
        Provider.of<UserListNotifier>(context, listen: false).fetchUser(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: kStrongBlue,
                  ),
                  Text(
                    'Third Screen',
                    style: kHeading6,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
            Divider(thickness: 0.8),
            Expanded(
              child: Consumer<UserListNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    return RefreshIndicator(
                        child: ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            final user = data.users[index];
                            return InkWell(
                              onTap: () {
                                Provider.of<SelectedUserNotifier>(context,
                                        listen: false)
                                    .setSelectedUser(
                                        '${user.firstName} ${user.lastName}');
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, top: 14),
                                padding: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Theme.of(context).dividerColor),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 20),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        user.avatar,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${user.firstName} ${user.lastName}',
                                          style: kBigText,
                                        ),
                                        Text(
                                          user.email,
                                          style: kSmallText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: data.users.length,
                        ),
                        onRefresh: () {
                          return Future.microtask(
                            () => Provider.of<UserListNotifier>(context,
                                    listen: false)
                                .fetchUser(1),
                          );
                        });
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pagination() {
    if ((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)) {
      Future.microtask(() =>
          Provider.of<UserListNotifier>(context, listen: false)
              .fetchMoreUser());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
