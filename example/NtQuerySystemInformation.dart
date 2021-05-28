import 'dart:ffi';

import 'package:dynamic_load/dynamic_load.dart';
import 'package:ffi/ffi.dart';

import 'ntdll/winternl.dart';

void main() {
  using((Arena arena) {
    final pNtQuerySystemInformation =
        getFuncAddress('ntdll.dll', 'NtQuerySystemInformation');
    print('pNtQuerySystemInformation $pNtQuerySystemInformation');

    final funcNtQuerySystemInformation =
        Pointer<NativeFunction<c_NtQuerySystemInformation>>.fromAddress(
                pNtQuerySystemInformation)
            .asFunction<dart_NtQuerySystemInformation>();

    print('funcNtQuerySystemInformation $funcNtQuerySystemInformation');
  });
}
