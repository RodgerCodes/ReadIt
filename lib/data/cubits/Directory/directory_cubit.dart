import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'directory_state.dart';

class DirectoryCubit extends Cubit<DirectoryState> {
  DirectoryCubit() : super(DirectoryInitial());
}
