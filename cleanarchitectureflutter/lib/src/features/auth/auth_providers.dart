import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import 'data/data_sources/auth_remote_data_source.dart';
import 'data/repository/auth_repo_impl.dart';
import 'domain/usecases/login_usecase.dart';

// Remote DS
final authRemoteProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.read(dioProvider)),
);

// Repo
final authRepoProvider = Provider(
  (ref) => AuthRepositoryImpl(ref.read(authRemoteProvider)),
);

// Usecase
final loginUsecaseProvider = Provider(
  (ref) => LoginUseCase(ref.read(authRepoProvider)),
);
