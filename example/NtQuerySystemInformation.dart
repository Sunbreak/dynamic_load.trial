import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'ntdll/winternl.dart';
import 'ntstatus/ntstatus.dart';

void main() {
  using((Arena arena) {
    final pNeedSize = arena<Uint32>();
    var status = funcNtQuerySystemInformation(
        SYSTEM_INFORMATION_CLASS.SystemProcessInformation,
        nullptr,
        0,
        pNeedSize);

    print(
        'status $status, ${status == STATUS_INFO_LENGTH_MISMATCH}, needSize ${pNeedSize.value}');
  });
}
