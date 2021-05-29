import 'dart:ffi' as ffi;

import 'package:dynamic_load/dynamic_load.dart';
import 'package:ffi/ffi.dart';

export '_winternl.dart';

final funcNtQuerySystemInformation = using((Arena arena) {
  final pNtQuerySystemInformation =
      getFuncAddress('ntdll.dll', 'NtQuerySystemInformation');

  return ffi.Pointer<
              ffi.NativeFunction<c_NtQuerySystemInformation>>.fromAddress(
          pNtQuerySystemInformation)
      .asFunction<dart_NtQuerySystemInformation>();
});

// FIXME: https://github.com/dart-lang/ffigen/issues/226
typedef c_NtQuerySystemInformation = ffi.Int32 Function(
  ffi.Int32 SystemInformationClass,
  ffi.Pointer<ffi.Void> SystemInformation,
  ffi.Uint32 SystemInformationLength,
  ffi.Pointer<ffi.Uint32> ReturnLength,
);

typedef dart_NtQuerySystemInformation = int Function(
  int SystemInformationClass,
  ffi.Pointer<ffi.Void> SystemInformation,
  int SystemInformationLength,
  ffi.Pointer<ffi.Uint32> ReturnLength,
);
