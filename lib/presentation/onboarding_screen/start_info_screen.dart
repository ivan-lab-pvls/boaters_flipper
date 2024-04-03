import 'package:boat_rent/core/app_export.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class StartInfoScreen extends StatefulWidget {
  StartInfoScreen({super.key});

  static Widget builder(BuildContext context) {
    return StartInfoScreen();
  }

  @override
  State<StartInfoScreen> createState() => _StartInfoScreenState();
}

class _StartInfoScreenState extends State<StartInfoScreen> {
  bool isOptionChoose = false;

  TextEditingController _textFieldController = TextEditingController();

  bool isTextFieldFilled() {
    setState(() {});
    return _textFieldController.text.isNotEmpty;
  }

  String _textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_updateTextFieldValue);
  }

  void _updateTextFieldValue() {
    setState(() {
      _textFieldValue = _textFieldController.text;
    });
  }

  List options = [
    {'title': '1-3', 'isActive': false},
    {'title': '4-7', 'isActive': false},
    {'title': 'More than 7', 'isActive': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 80.v,
              ),
              Text(
                'Let\'s start',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 25.v,
              ),
              Text('Which water transport you rent out?',
                  style: CustomTextStyles.bodyLargeOnPrimaryContainer_2),
              SizedBox(
                height: 4.v,
              ),
              CustomTextFormField(
                controller: _textFieldController,
                textStyle: theme.textTheme.bodyLarge,
              ),
              SizedBox(
                height: 16.v,
              ),
              _buildChooser(context),
              SizedBox(
                height: 100.v,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: CustomElevatedButton(
          isDisabled: !isTextFieldFilled() || !isOptionChoose,
          text: 'Continue',
          onPressed: () {
            NavigatorService.popAndPushNamed(AppRoutes.mainScreen);
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
        ),
      ),
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'How many of them?',
            style: CustomTextStyles.bodyLargeOnPrimaryContainer_2,
          ),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8.v),
                  height: 52.v,
                  //width: double.infinity,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${option['title']}',
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  changeState(option) {
    setState(() {
      for (var item in options) {
        if (item == option) {
          isOptionChoose = true;
          item['isActive'] = true;
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? appTheme.blueGray900 : appTheme.blueGray900,
      border: isActive
          ? Border.all(color: theme.colorScheme.primary)
          : Border.all(color: appTheme.blueGray900),
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
  }
}
