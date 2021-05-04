import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nehemiah/blocs/users/users.dart';
import 'package:user_repository/user_repository.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;
  StreamSubscription _usersSubscription;

  UsersBloc({@required UsersRepository usersRepository})
      : assert(usersRepository != null),
        _usersRepository = usersRepository,
        super(ChildrenLoading());

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is LoadChildUsers) {
      yield* _mapLoadChildUserToState(event);
    } else if (event is AddChildUser) {
      yield* _mapAddChildToState(event);
    } else if (event is UpdateChild) {
      yield* _mapUpdateUserToState(event);
    } else if (event is DeleteChild) {
      yield* _mapDeleteUserToState(event);
    } else if (event is LoadActiveChild) {
      yield _mapLoadActiveChildToState(event);
//    } else if (event is ClearCompleted) {
//      yield* _mapClearCompletedToState();
    } else if (event is ChildUsersUpdated) {
      yield* _mapUsersUpdateToState(event);
    }
  }

//  @override
//  Stream<UsersState> mapEventToState(
//      UsersEvent event,
//      ) async* {
//    if (event is AuthenticationUserChanged) {
//      yield _mapAuthenticationUserChangedToState(event);
//    } else if (event is AuthenticationLogoutRequested) {
//      unawaited(_authenticationRepository.logOut());
//    }
//  }

  Stream<UsersState> _mapLoadChildUserToState(LoadChildUsers event) async* {
    _usersSubscription?.cancel();
    _usersSubscription = _usersRepository.children(event.userId).listen(
          (childUsers) => add(ChildUsersUpdated(childUsers)),
        );
  }

//  //Active Child is selected and added to the state bag.
//  Stream<UsersState> _mapLoadActiveChildToState(LoadActiveChild event) async* {
////    ActiveChildState(
////        activeChild: event.child, status: ChildSelectedStatus.selected);
//    ActiveChildState.selected(event.child);
//
//
//  }

  UsersState _mapLoadActiveChildToState(
    LoadActiveChild event,
  ) {
    return event.child != Child.empty
        ? ActiveChildState.selected(event.child)
        : const ActiveChildState.unselected();
  }

  Stream<UsersState> _mapAddChildToState(AddChildUser event) async* {
    _usersRepository.addNewChild(event.child, event.userId);
  }

  Stream<UsersState> _mapUpdateUserToState(UpdateChild event) async* {
    _usersRepository.updateChild(event.updatedChild);
  }

  Stream<UsersState> _mapDeleteUserToState(DeleteChild event) async* {
    _usersRepository.deleteChild(event.child);
  }

  Stream<UsersState> _mapUsersUpdateToState(ChildUsersUpdated event) async* {
    yield ChildrenLoaded(event.children);
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
