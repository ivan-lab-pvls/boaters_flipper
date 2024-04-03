import 'package:boat_rent/core/app_export.dart';
import 'package:boat_rent/data/data_manager.dart';
import 'package:boat_rent/data/models/boat_model/boat_model.dart';
import 'package:boat_rent/presentation/new_transport_screen/new_transport_bloc/new_transport_bloc.dart';
import 'package:boat_rent/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_elevated_button.dart';

class NewTransportSecondInfoStateScreen extends StatefulWidget {
  final NewTransportBloc bloc;
  final NewTransportSecondaryInfoState state;

  const NewTransportSecondInfoStateScreen({
    super.key,
    required this.bloc,
    required this.state,
  });

  @override
  State<NewTransportSecondInfoStateScreen> createState() =>
      _NewTransportSecondInfoStateScreenState();
}

class _NewTransportSecondInfoStateScreenState
    extends State<NewTransportSecondInfoStateScreen> {
  TextEditingController commentController = TextEditingController();

  bool allFieldFills = false;
  bool isOptionChoose = false;
  String chooseOption = '';
  List options = [
    {
      'title': 'Perfect',
      'isActive': false,
      'color': theme.colorScheme.secondaryContainer
    },
    {'title': 'Average', 'isActive': false, 'color': appTheme.deepOrange800},
    {'title': 'Bad', 'isActive': false, 'color': appTheme.red800},
  ];

  @override
  void initState() {
    super.initState();
  }

  void fillsTextFields() {
    allFieldFills = commentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _textField(
          context,
          name: 'Write a comment about transport',
          controller: commentController,
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
        SizedBox(
          height: 100,
          child: CustomTextFormField(
            maxLines: null,
            expanded: true,
            textStyle: theme.textTheme.bodyLarge,
            textInputType: inputType,
            controller: controller,
            onChanged: (value) {
              setState(() {
                fillsTextFields();
              });
            },
          ),
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
          child: Text('State of transport', style: theme.textTheme.titleLarge),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 4.v),
                  height: 52.v,
                  width: 110.h,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${option['title']}',
                                textAlign: TextAlign.right,
                                style: option['isActive']
                                    ? CustomTextStyles.bodyLargePrimary
                                    : theme.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          Container(
                            decoration: AppDecoration.circle
                                .copyWith(color: option['color']),
                            width: 25,
                            height: 25,
                          )
                        ],
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
          onPressed: () async {
            BoatModel boatModel = BoatModel(
              type: widget.state.typeBoat,
              rentalCost: widget.state.rentalCost,
              paymentType: widget.state.paymentType,
              whoRents: widget.state.whoRents,
              boatState: TypesMapper.boatStateParse(chooseOption),
              comment: commentController.text,
            );
            await DataManager.addBoatToList(boatModel);
            //widget.bloc.add(NewTransportEndEvent(boatModel: boatModel));

            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
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
