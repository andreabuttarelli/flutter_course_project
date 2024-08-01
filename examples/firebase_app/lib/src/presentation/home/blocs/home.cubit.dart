import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  final db = FirebaseFirestore.instance;

  Future<void> load() async {
    emit(HomeLoaded([]));
    try {
      final res = await db.collection('posts').get();
      emit(HomeLoaded(res.docs));
    } catch (e, s) {
      addError(e, s);
    }
  }

  Future<void> addPost(String text, User user) async {
    try {
      await db.collection('posts').add({
        'text': text,
        'user_id': await user.getIdToken(),
      });
    } catch (e, s) {
      addError(e, s);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(HomeError(error.toString()));
    super.onError(error, stackTrace);
  }
}

class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  List<dynamic> posts;

  HomeLoaded(this.posts);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
