import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'ntdll/winternl.dart';

void main() {
  using((Arena arena) {
    final pNeedSize = arena<Uint32>();
    var status = funcNtQuerySystemInformation(
        SYSTEM_INFORMATION_CLASS.SystemProcessInformation,
        nullptr,
        0,
        pNeedSize);

    print('status $status, needSize ${pNeedSize.value}');
  });
}
