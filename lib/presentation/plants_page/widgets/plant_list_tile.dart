import 'package:flutter/material.dart';
import 'package:garden_app/config/config.dart';

import 'package:garden_app/data/entity/plant.dart';
import 'package:intl/intl.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;

  const PlantListTile({
    Key? key,
    required this.plant,
  }) : super(key: key);

  static const double _plantTileSize = 100;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: Navigate to plant editing
      onTap: () {},
      child: Container(
        height: _plantTileSize,
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: AppColors.mainColor,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: _plantTileSize,
              width: _plantTileSize,
              color: AppColors.mainColor,
              child: Center(
                child: Text(
                  plant.plantSignature,
                  style: AppStyles.whiteMedium(32),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Text(
                      plant.name,
                      style: AppStyles.blackMedium(16),
                    ),
                    Positioned(
                      top: 24,
                      child: Text(
                        plant.type.name,
                        style: AppStyles.blackRegular(12),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        DateFormat('dd-mm-yyyy').format(plant.plantDate),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
