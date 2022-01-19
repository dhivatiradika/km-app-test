import 'package:flutter/material.dart';
import 'package:km_app_test/common/constants.dart';
import 'package:km_app_test/presentation/pages/page_two.dart';

class PageOne extends StatefulWidget {
  static const ROUTE_NAME = '/page-one';

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _palindromeController = TextEditingController();

  bool isPalindrome(String text) {
    var reversedText =
        text.split('').reversed.join().toLowerCase().replaceAll(' ', '');
    return reversedText == text.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 120),
                  Image.asset(
                    'assets/btn_add_photo.png',
                    width: 116,
                    height: 116,
                  ),
                  SizedBox(height: 60),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      autocorrect: false,
                      style: kMediumText,
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: kMediumText.apply(
                            color: kTextSoftDark.withOpacity(0.36)),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      autocorrect: false,
                      controller: _palindromeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Palindrome',
                        hintStyle: kMediumText.apply(
                            color: kTextSoftDark.withOpacity(0.36)),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        var text = _palindromeController.text;
                        if (isPalindrome(text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('\'$text\' is Palindrome')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('\'$text\' is not Palindrome')));
                        }
                      },
                      child: Text(
                        'CHECK',
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
                  SizedBox(height: 22),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        var name = _nameController.text;

                        if (name.trim().isNotEmpty) {
                          Navigator.pushNamed(
                            context,
                            PageTwo.ROUTE_NAME,
                            arguments: _nameController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please fill up name field')));
                        }
                      },
                      child: Text(
                        'NEXT',
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }
}
