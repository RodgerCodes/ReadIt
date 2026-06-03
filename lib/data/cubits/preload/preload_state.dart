part of 'preload_cubit.dart';

@immutable
sealed class PreloadState {}

final class PreloadInitial extends PreloadState {}

final class PreloadingData extends PreloadState {}

final class PreloadingDataFailed extends PreloadState {
  final String message;
  PreloadingDataFailed({required this.message});
}

final class PreloadingDataDone extends PreloadState {
  final String message;
  PreloadingDataDone({required this.message});
}
