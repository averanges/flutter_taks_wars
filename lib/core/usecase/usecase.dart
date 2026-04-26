abstract class UseCase<T, P> {
  const UseCase();

  Future<T> call(P params);
}

abstract class ExecuteUseCase<T> {
  const ExecuteUseCase();

  Future<T> execute();
}
