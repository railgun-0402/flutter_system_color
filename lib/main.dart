import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// デフォルトはSystem設定
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // themeModeProviderのオブジェクト取得
    final themeMode = ref.read(themeModeProvider.notifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'light/dart mode change',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // themeModeProviderのstateを用いて、themeModeを設定する
      // 切り替え成功！！
      themeMode: ref.watch(themeModeProvider),
      // 切り替え失敗。。。
      // themeMode: themeMode.state,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.read(themeModeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("light/dart mode change"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton<ThemeMode>(
              icon: const Icon(Icons.settings_brightness),
              onSelected: (ThemeMode selectedThemeMode) => {
                // 成功
                ref.read(themeModeProvider.notifier).update((state) => selectedThemeMode),
                // 成功
                // ref.read(themeModeProvider.notifier).state = selectedThemeMode,
                print(selectedThemeMode),
              },
              // onSelected: (value) => print(value),
              itemBuilder: (context) => <PopupMenuEntry<ThemeMode>>[
                const PopupMenuItem(
                  value: ThemeMode.system,
                    child: Text('システム設定に従う'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.light,
                  child: Text('ライトモード'),
                ),
                const PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Text('ダークモード'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "設定に応じてfontColorが入れ替わる",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
