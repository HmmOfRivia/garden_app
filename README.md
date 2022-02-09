# garden_app

Project presenting app based on bloc, floor, dartz, freezed, auto_route and get_it+injectable packages.

Flutter version 2.10.0

## Setup
Get code and run : flutter pub get.

Launching setup is configured in .vscode directory. <br>
To run app from terminal run: flutter run --profile lib/main_prod.dart --flavor=prod


To regenerate all necessary generated files run:
1) dart pub global activate flutter_gen
2) fluttergen
3) flutter pub run build_runner build --delete-conflicting-outputs
