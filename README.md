# queue 
This project is for pad view, if phone view is not finish yet.
queue  to take a number for test  

many bugs not fixed
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



# flutter build_runner command

flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

# Use the [watch] flag to watch the files' system for edits and rebuild as necessary.
dart run build_runner watch

# If you want the generator to run one time and exit, use

dart run build_runner build



# flutter env command
example 
 flutter build apk --release --dart-define-from-file=env/dev.json

 flutter run --release -v --dart-define-from-file=env/stage.json 
# no shrink version
 flutter build apk --no-shrink --dart-define-from-file=env/stage.json 

# 使用easy_localization
 context.tr("");