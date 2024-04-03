import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:boat_rent/presentation/new_transport_screen/new_transport_bloc/new_transport_bloc.dart';
import 'package:boat_rent/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_elevated_button.dart';

class NewTransportMainInfoStateScreen extends StatefulWidget {
  final NewTransportBloc bloc;

  const NewTransportMainInfoStateScreen({
    super.key,
    required this.bloc,
  });

  @override
  State<NewTransportMainInfoStateScreen> createState() =>
      _NewTransportMainInfoStateScreenState();
}

class _NewTransportMainInfoStateScreenState
    extends State<NewTransportMainInfoStateScreen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController rentalController = TextEditingController();
  TextEditingController whoController = TextEditingController();

  bool allFieldFills = false;
  bool isOptionChoose = false;
  String chooseOption = '';
  List options = [
    {'title': 'Weekly', 'isActive': false},
    {'title': 'Monthly', 'isActive': false},
    {'title': 'Annually', 'isActive': false},
  ];

  @override
  void initState() {
    super.initState();
  }

  void fillsTextFields() {
    allFieldFills = typeController.text.isNotEmpty &&
        rentalController.text.isNotEmpty &&
        whoController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _textField(
          context,
          name: 'Type of water transport',
          controller: typeController,
        ),
        _textField(
          context,
          name: 'Rental cost',
          inputType: TextInputType.number,
          controller: rentalController,
        ),
        _textField(
          context,
          name: 'Who rents from you?',
          controller: whoController,
        ),
        _buildChooser(context),
      ],
    );
  }

  Widget _textField(
    BuildContext context, {
    String name = '',
    String text = '',
    TextInputType inputType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          name,
          style: CustomTextStyles.bodyLargeOnPrimaryContainer_2,
        ),
        SizedBox(
          height: 8.v,
        ),
        CustomTextFormField(
          textStyle: theme.textTheme.bodyLarge,
          textInputType: inputType,
          controller: controller,
          maxLines: 1,
          onChanged: (value) {
            if (value == '' || value.length == 1)
              setState(() {
                fillsTextFields();
              });
          },
        ),
        SizedBox(
          height: 16.v,
        ),
      ],
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('How often payment is made?',
              style: CustomTextStyles.bodyLargeOnPrimaryContainer_2),
        ),
        SizedBox(
          height: 4.v,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: options
              .map(
                (option) => Container(
                  // margin: EdgeInsets.symmetric(horizontal: 4.v),
                  height: 52.v,
                  width: 110.h,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${option['title']}',
                          textAlign: TextAlign.center,
                          style: option['isActive']
                              ? CustomTextStyles.bodyLargePrimary
                              : theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 20.v,
        ),
        CustomElevatedButton(
          isDisabled: !allFieldFills || !isOptionChoose,
          text: 'Continue',
          onPressed: () {
            widget.bloc.add(NewTransportSecondEvent(
              typeBoat: typeController.text,
              rentalCost: double.parse(rentalController.text),
              whoRents: whoController.text,
              paymentType: TypesMapper.paymentTypeParse(chooseOption),
            ));
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
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
          chooseOption = item['title'];
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
