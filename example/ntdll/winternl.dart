import 'dart:ffi' as ffi;

import 'package:dynamic_load/dynamic_load.dart';
import 'package:ffi/ffi.dart';

import '_winternl.dart';

export '_winternl.dart';

final funcNtQuerySystemInformation = using((Arena arena) {
  final pNtQuerySystemInformation =
      getFuncAddress('ntdll.dll', 'NtQuerySystemInformation');

  return ffi.Pointer<
              ffi.NativeFunction<NativeNtQuerySystemInformation>>.fromAddress(
          pNtQuerySystemInformation)
      .asFunction<DartNtQuerySystemInformation>();
});

// FIXME: https://github.com/dart-lang/ffigen/issues/233
abstract class SYSTEM_INFORMATION_CLASS {
  static const int SystemBasicInformation = 0;
  static const int SystemPerformanceInformation = 2;
  static const int SystemTimeOfDayInformation = 3;
  static const int SystemProcessInformation = 5;
  static const int SystemProcessorPerformanceInformation = 8;
  static const int SystemInterruptInformation = 23;
  static const int SystemExceptionInformation = 33;
  static const int SystemRegistryQuotaInformation = 37;
  static const int SystemLookasideInformation = 45;
  static const int SystemCodeIntegrityInformation = 103;
  static const int SystemPolicyInformation = 134;
}

class SYSTEM_PROCESS_INFORMATION extends ffi.Struct {
  @ULONG()
  external int NextEntryOffset;

  @ULONG()
  external int NumberOfThreads;

  @ffi.Array.multi([48])
  external ffi.Array<BYTE> Reserved1;

  external UNICODE_STRING ImageName;

  @KPRIORITY()
  external int BasePriority;

  external HANDLE UniqueProcessId;

  external PVOID Reserved2;

  @ULONG()
  external int HandleCount;

  @ULONG()
  external int SessionId;

  external PVOID Reserved3;

  @SIZE_T()
  external int PeakVirtualSize;

  @SIZE_T()
  external int VirtualSize;

  @ULONG()
  external int Reserved4;

  @SIZE_T()
  external int PeakWorkingSetSize;

  @SIZE_T()
  external int WorkingSetSize;

  external PVOID Reserved5;

  @SIZE_T()
  external int QuotaPagedPoolUsage;

  external PVOID Reserved6;

  @SIZE_T()
  external int QuotaNonPagedPoolUsage;

  @SIZE_T()
  external int PagefileUsage;

  @SIZE_T()
  external int PeakPagefileUsage;

  @SIZE_T()
  external int PrivatePageCount;

  @ffi.Array.multi([6])
  external ffi.Array<LARGE_INTEGER> Reserved7;
}
