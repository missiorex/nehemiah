import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

enum ChildSelectedStatus { selected, unselected, unknown }

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class ChildrenLoading extends UsersState {}

class ChildrenLoaded extends UsersState {
  final List<Child> children;

  const ChildrenLoaded([this.children = const []]);

  @override
  List<Object> get props => [children];

  @override
  String toString() => 'ChildrenLoaded { children: $children }';
}

class ActiveChildState extends UsersState {
  const ActiveChildState({
    this.status = ChildSelectedStatus.unknown,
    this.activeChild = Child.empty,
  });

  const ActiveChildState.unknown() : this();

  const ActiveChildState.selected(Child child)
      : this(status: ChildSelectedStatus.selected, activeChild: child);

  const ActiveChildState.unselected()
      : this(status: ChildSelectedStatus.unselected);

  final ChildSelectedStatus status;
  final Child activeChild;

  @override
  List<Object> get props => [status, activeChild];

  @override
  String toString() =>
      'ActiveChildState { active child: $activeChild , status: $status }';
}

//class ActiveChildLoaded extends UsersState {
//  final Child activeChild;
//
//  const ActiveChildLoaded([this.activeChild]);
//
//  @override
//  List<Object> get props => [activeChild];
//
//  @override
//  String toString() => 'Active Child Loaded { Active Child: $activeChild }';
//}

class ChildrenNotLoaded extends UsersState {}
