import 'package:clean_app/src/domain/usecases/submit_form_hr_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormHRCubit extends Cubit<FormHRState> {
  FormHRCubit(this._submitFormHRUseCase) : super(const FormHREditing());

  final SubmitFormHRUseCase _submitFormHRUseCase;

  void updateCountry(String country) {
    final currentState = state;
    assert(currentState is FormHREditing);
    emit((currentState as FormHREditing).copyWith(country: country));
  }

  void updateStreet(String street) {
    final currentState = state;
    assert(currentState is FormHREditing);
    emit((currentState as FormHREditing).copyWith(street: street));
  }

  void updateName(String name) {
    final currentState = state;
    assert(currentState is FormHREditing);
    emit((currentState as FormHREditing).copyWith(name: name));
  }

  void updateExperience(double experience) {
    final currentState = state;
    assert(currentState is FormHREditing);
    emit((currentState as FormHREditing).copyWith(experience: experience));
  }

  void submit() {
    final currentState = state;
    assert(currentState is FormHREditing);
    if (currentState is! FormHREditing) return;
    _submitFormHRUseCase.call(
      SubmitFormHRUseCaseParams(
        country: currentState.country!,
        street: currentState.street!,
        name: currentState.name!,
        experience: currentState.experience!,
      ),
    );
  }
}

abstract class FormHRState {
  const FormHRState();
}

class FormHREditing extends FormHRState {
  const FormHREditing({
    this.country,
    this.street,
    this.name,
    this.experience,
  });

  final String? country;
  final String? street;
  final String? name;
  final double? experience;

  FormHRState copyWith({
    String? country,
    String? street,
    String? name,
    double? experience,
  }) {
    return FormHREditing(
      country: country ?? this.country,
      street: street ?? this.street,
      name: name ?? this.name,
      experience: experience ?? this.experience,
    );
  }
}

class FormHRSaved extends FormHRState {
  const FormHRSaved({
    this.country,
    this.street,
    this.name,
    this.experience,
  });

  final String? country;
  final String? street;
  final String? name;
  final double? experience;
}

class FormHRValidated extends FormHRState {
  const FormHRValidated({
    required this.country,
    required this.street,
    required this.name,
    required this.experience,
  });

  final String country;
  final String street;
  final String name;
  final double experience;
}
