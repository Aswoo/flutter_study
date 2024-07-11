import 'package:clean_architecture_riverpod/layer/data/character_repository_impl.dart';
import 'package:clean_architecture_riverpod/layer/data/source/local/local_storage.dart';
import 'package:clean_architecture_riverpod/layer/data/source/network/api.dart';
import 'package:clean_architecture_riverpod/layer/domain/usecase/get_all_characters.dart';
import 'package:clean_architecture_riverpod/layer/presentation/theme.dart';
import 'package:clean_architecture_riverpod/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'using_riverpod/app_using_riverpod.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late StateManagementOptions _currentOption;
  late GetAllCharacters _getAllCharacters;
  var themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _currentOption = StateManagementOptions.bloc;

    // Notice:
    //
    // Some state management packages are also D.I. (Dependency Injection)
    // solutions. To avoid polluting this example with unnecessary repetition,
    // we're creating the object instances here and passing them as parameters
    // to each state management's "root" widgets. Then we'll use the library's
    // specific D.I. widget to make the instance accessible to the rest of the
    // widget tree.
    //
    final api = ApiImpl();
    final localStorage = LocalStorageImpl(sharedPreferences: sharedPref);
    final repo = CharacterRepositoryImpl(api: api, localStorage: localStorage);

    _getAllCharacters = GetAllCharacters(repository: repo);
  }

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
          builder: (context) {
            final tt = Theme
                .of(context)
                .textTheme;
            final cs = Theme
                .of(context)
                .colorScheme;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Transform.translate(
                  offset: const Offset(10, 0),
                  child: Text(
                    'Rick & Morty\n(${getTitleToOption(_currentOption)})',
                    style: tt.headlineLarge!.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate().fadeIn(delay: .8.seconds, duration: .7.seconds),
                actions: [
                  IconButton(
                    onPressed: () {
                      final useLight = themeMode == ThemeMode.dark
                          ? true
                          : false;
                      handleBrightnessChange(useLight);
                    },
                    icon: const Icon(Icons.light_mode),
                  ),
                  PopupMenuButton<StateManagementOptions>(
                    onSelected: (value) =>
                        setState(() {
                          _currentOption = value;
                        }),
                    itemBuilder: (context) =>
                    [
                      // _menuEntry(StateManagementOptions.bloc, 'Bloc'),
                      // _menuEntry(StateManagementOptions.cubit, 'Cubit'),
                      // _menuEntry(StateManagementOptions.mobX, 'MobX'),
                      // _menuEntry(StateManagementOptions.getIt, 'GetIT'),
                      // _menuEntry(StateManagementOptions.provider, 'Provider'),
                      _menuEntry(StateManagementOptions.riverpod, 'Riverpod'),
                    ],
                  ),
                ],
              ),
              body: _getAppUsing(stateManagement: _currentOption)
                  .animate()
                  .fadeIn(delay: 1.2.seconds, duration: .7.seconds),
            );
          }
      ),
    );
  }


  // ---------------------------------------------------------------------------
  // _Helpers
  // ---------------------------------------------------------------------------

  Widget _getAppUsing({required StateManagementOptions stateManagement}) {
    switch (stateManagement) {
      case (StateManagementOptions.bloc):
        return Container();
      case (StateManagementOptions.cubit):
        return Container();
      case (StateManagementOptions.mobX):
        return Container();
      case (StateManagementOptions.getIt):
        return Container();
      case (StateManagementOptions.provider):
        return Container();
      case (StateManagementOptions.riverpod):
        return const AppUsingRiverpod();
      default:
        return Container();
    }
  }

  PopupMenuItem<StateManagementOptions> _menuEntry(
      StateManagementOptions option,
      String text,) {
    final isSelected = _currentOption == option;
    final textTheme = Theme
        .of(context)
        .textTheme
        .apply(displayColor: Theme
        .of(context)
        .colorScheme
        .onSurface);

    return PopupMenuItem<StateManagementOptions>(
      value: option,
      child: Text(
        isSelected ? 'using $text' : 'use $text',
        style: textTheme.bodyMedium!.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.red : Colors.black,
        ),
      ),
    );
  }

  String getTitleToOption(StateManagementOptions option) {
    switch (option) {
      case (StateManagementOptions.bloc):
        return 'BLOC';
      case (StateManagementOptions.cubit):
        return 'Cubit';
      case (StateManagementOptions.mobX):
        return 'MobX';
      case (StateManagementOptions.getIt):
        return 'GetIT';
      case (StateManagementOptions.provider):
        return 'Provider';
      case (StateManagementOptions.riverpod):
        return 'RiverPode';
      default:
        return '';
    }
  }

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View
            .of(context)
            .platformDispatcher
            .platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }
}

