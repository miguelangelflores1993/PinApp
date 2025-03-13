import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miguel/core/config/log.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logInfo('change: ${bloc.runtimeType} $change');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    logInfo('BLOC is closed');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);

    if (bloc is Cubit) {
      logInfo('This is a Cubit');
    } else {
      logInfo('This is a Bloc');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logInfo(
      'Error happened in $bloc with error $error and '
      'the stacktrace is $stackTrace',
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    logInfo('an event Happened in $bloc the event is $event');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);

    logInfo(
      'There was a transition from ${transition.currentState}'
      'to ${transition.nextState}',
    );
  }
}
