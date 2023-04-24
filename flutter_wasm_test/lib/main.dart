// -----------------------------------------------------------------------------

// ignore_for_file: avoid_print, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wasm_interop/wasm_interop.dart';

// -----------------------------------------------------------------------------

final wasmLoader = WasmLoader(path: "assets/add_bg.wasm");

// -----------------------------------------------------------------------------

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required before calling wasmLoader.initialize()
  final initialized = await wasmLoader.initialize();
  if (!initialized) {
    print("Failed to initialize wasnLoader");
  }
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------

class MyApp extends StatelessWidget {
  //
  //
  //
  
  const MyApp({Key? key}) : super(key: key);
  
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter, Rust and WASM",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Rust code compiled to WASM loaded into Flutter"),
        ),
        body: Center(
          child: Builder(builder: (context) {
            final result = initialized ? wasmLoader.add(1234, 4321): "Failed to initialize wasnLoader";
            return Text(
              "Result: $result",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

class WasmLoader {
  //
  //
  //

  late Instance? _wasm;
  final String path;

  WasmLoader({required this.path});

  //
  //
  //

  Future<bool> initialize() async {
    try {
      final bytes = await rootBundle.load(path);
      this._wasm = await Instance.fromBufferAsync(bytes.buffer);
      return isInit;
    } catch (e) {
      print("WasmLoader failed to initialize: $e");
    }
    return false;
  }

  //
  //
  //

  bool get isInit => _wasm != null;

  //
  //
  //

  // --- ADD WASM FUNCTION CALLS HERE ---
  // --- ADD WASM FUNCTION CALLS HERE ---
  // --- ADD WASM FUNCTION CALLS HERE ---

  int add(int a, int b) {
    final func = _wasm?.functions["add"];
    return func?.call(a, b);
  }
}
