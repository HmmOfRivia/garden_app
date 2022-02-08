import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:garden_app/config/config.dart';
import 'package:garden_app/data/entity/plant.dart';
import 'package:garden_app/presentation/widgets/custom_button.dart';
import 'package:garden_app/presentation/widgets/custom_input_field.dart';
import 'package:garden_app/generated/l10n.dart';
import 'package:garden_app/gen/assets.gen.dart';
import 'package:keyboard_utils/widgets.dart';

class PlantsFormPage extends StatelessWidget {
  PlantsFormPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

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
            onTap: () => _formKey.currentState!.reset(),
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
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomInputField.text(
                          name: 'name',
                          maxLength: 30,
                          maxLines: 1,
                          hintText: S.of(context).nameOfPlantQuestion,
                        ),
                        const SizedBox(height: 12),
                        CustomInputField.timePicker(
                          name: 'plantDate',
                          initialTime: TimeOfDay.now(),
                          hintText: S.of(context).plantDateQuestion,
                        ),
                        const SizedBox(height: 12),
                        CustomInputField.dropdown(
                          name: 'type',
                          hintText: S.of(context).choosePlantType,
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
                          //TODO: trigger cubit method addPlant
                          onTap: () {},
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
