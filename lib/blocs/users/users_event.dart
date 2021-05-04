import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadChildUsers extends UsersEvent {
  final String userId;
  const LoadChildUsers({this.userId});
}

class AddChildUser extends UsersEvent {
  final Child child;
  final String userId;

  const AddChildUser(this.child, this.userId);

  @override
  List<Object> get props => [child];

  @override
  String toString() => 'AddChild { child: $child }';
}

class UpdateChild extends UsersEvent {
  final Child updatedChild;

  const UpdateChild(this.updatedChild);

  @override
  List<Object> get props => [updatedChild];

  @override
  String toString() => 'UpdateChild { updatedChild: $updatedChild }';
}

class DeleteChild extends UsersEvent {
  final Child child;

  const DeleteChild(this.child);

  @override
  List<Object> get props => [child];

  @override
  String toString() => 'DeleteChild { child: $child }';
}

class LoadActiveChild extends UsersEvent {
  final Child child;

  const LoadActiveChild(this.child);

  @override
  List<Object> get props => [child];

  @override
  String toString() => 'LoadActiveChild { child: $child }';
}

class ChildUsersUpdated extends UsersEvent {
  final List<Child> children;

  const ChildUsersUpdated(this.children);

  @override
  List<Object> get props => [children];
}
