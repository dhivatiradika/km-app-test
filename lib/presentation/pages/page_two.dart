import 'package:flutter/material.dart';
import 'package:km_app_test/common/constants.dart';
import 'package:km_app_test/presentation/pages/page_three.dart';
import 'package:km_app_test/presentation/provider/selected_user_notifier.dart';
import 'package:provider/provider.dart';

class PageTwo extends StatelessWidget {
  static const ROUTE_NAME = '/page-two';
  final String name;

  PageTwo({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Second Screen',
                      style: kHeading6,
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 0.8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Welcome',
                  style: kSmallText,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  name,
                  style: kHeading6,
                ),
              ),
              SizedBox(height: 250),
              Consumer<SelectedUserNotifier>(
                builder: (context, data, child) {
                  return Center(
                    child: Text(
                      data.selectedUser,
                      style: kHeading5,
                    ),
                  );
                },
              ),
              SizedBox(height: 250),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PageThree.ROUTE_NAME);
                  },
                  child: Text(
                    'Choose a User',
                    style: kMediumText.apply(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: kBlue,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
