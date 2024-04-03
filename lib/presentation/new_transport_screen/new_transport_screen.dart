import 'package:boat_rent/presentation/new_transport_screen/new_transport_bloc/new_transport_bloc.dart';
import 'package:boat_rent/presentation/new_transport_screen/new_transport_states/new_transport_second_info_state_screen.dart';
import 'package:boat_rent/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import 'new_transport_states/new_transport_main_info_state_screen.dart';

class NewTransportScreen extends StatefulWidget {
   NewTransportScreen({super.key});

  static Widget builder(BuildContext context) {
    return NewTransportScreen();
  }

  @override
  State<NewTransportScreen> createState() => _NewTransportScreenState();
}

class _NewTransportScreenState extends State<NewTransportScreen> {
  bool isSecond = false;

  @override
  void initState() {
    context.read<NewTransportBloc>().add(NewTransportMainEvent());
    isSecond = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 52.v,
        leadingWidth: 100.h,
        leading: Container(
          width: 85.h,
          child: TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(width: 4.h),
                Text(
                  'Back',
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ],
            ),
            onPressed: () {
              if (isSecond) {
                context.read<NewTransportBloc>().add(NewTransportMainEvent());
              } else {
                NavigatorService.goBack();
              }
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'New transport',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 32.v,
              ),
              BlocBuilder<NewTransportBloc, NewTransportState>(
                builder: (context, state) {
                  final bloc = context.read<NewTransportBloc>();
                  if (state is NewTransportMainInfoState) {
                    isSecond = false;
                    return NewTransportMainInfoStateScreen(
                      bloc: bloc,
                    );
                  } else if (state is NewTransportSecondaryInfoState) {
                    isSecond = true;
                    return NewTransportSecondInfoStateScreen(
                        bloc: bloc, state: state);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
