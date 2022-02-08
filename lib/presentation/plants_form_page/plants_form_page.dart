import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/config/injection.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/logic/plants_page/plants_page_cubit.dart';
import 'package:garden_app/presentation/widgets/custom_button.dart';
import 'package:garden_app/presentation/widgets/custom_input_field.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:garden_app/gen/assets.gen.dart';
import 'package:keyboard_utils/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlantsFormPage extends StatelessWidget implements AutoRouteWrapper {
  final Plant? plant;
  final Map<String, dynamic> initialFormValues;

  PlantsFormPage({Key? key, this.plant})
      : initialFormValues = plant == null ? <String, dynamic>{} : plant.toMap(),
        super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PlantsPageCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          S.of(context).addNewPlant,
          style: AppStyles.whiteMedium(18),
        ),
        actions: [
          GestureDetector(
            onTap: () => _formKey.currentState!
              ..save()
              ..reset(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 8.0, 20.0, 8.0),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white70),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                S.of(context).clearForm,
                style: AppStyles.whiteMedium(12),
              ),
            ),
          )
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        initialValue: initialFormValues,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.gardenBackground.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              KeyboardAware(
                builder: (context, options) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomInputField.text(
                          name: 'name',
                          maxLength: 30,
                          maxLines: 1,
                          validator: FormBuilderValidators.required(context),
                          hintText: S.of(context).nameOfPlantQuestion,
                        ),
                        const SizedBox(height: 12),
                        CustomInputField.timePicker(
                          name: 'plantDate',
                          validator: FormBuilderValidators.required(context),
                          hintText: S.of(context).plantDateQuestion,
                        ),
                        const SizedBox(height: 12),
                        CustomInputField.dropdown(
                          name: 'type',
                          hintText: S.of(context).choosePlantType,
                          validator: FormBuilderValidators.required(context),
                          items: PlantType.values
                              .map(
                                (plantType) => DropdownMenuItem<PlantType>(
                                  value: plantType,
                                  child: Text(
                                    plantType.name,
                                    style: AppStyles.whiteMedium(14),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        CustomButton(
                          onTap: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final plant =
                                  Plant.fromMap(_formKey.currentState!.value);
                              await context
                                  .read<PlantsPageCubit>()
                                  .addPlant(plant);
                              await AutoRouter.of(context).pop();
                            }
                          },
                          color: AppColors.mainColor.dark,
                          text: S.of(context).addNewPlant,
                        ),
                        SizedBox(height: options.keyboardHeight),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
