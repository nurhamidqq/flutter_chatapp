abstract interface class UseCaseStream<R, P> {
  Stream<R> call(P params);
}
