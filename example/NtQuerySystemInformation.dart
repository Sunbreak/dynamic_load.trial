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
    if (status != STATUS_INFO_LENGTH_MISMATCH) throw Exception('Unknown');

    final pBuffer = arena<Uint8>(pNeedSize.value);
    status = funcNtQuerySystemInformation(
        SYSTEM_INFORMATION_CLASS.SystemProcessInformation,
        pBuffer.cast(),
        pNeedSize.value,
        nullptr);
    if (status < 0) throw Exception('Query SystemProcessInformation error: $status');

    var address = pBuffer.address;
    var nextEntryOffset = 0;
    do {
      address += nextEntryOffset;
      final procRef =
          Pointer.fromAddress(address).cast<SYSTEM_PROCESS_INFORMATION>().ref;
      print('UniqueProcessId ${procRef.UniqueProcessId}');
      print('NumberOfThreads ${procRef.NumberOfThreads}');
      nextEntryOffset = procRef.NextEntryOffset;
    } while (nextEntryOffset != 0);
  });
}
