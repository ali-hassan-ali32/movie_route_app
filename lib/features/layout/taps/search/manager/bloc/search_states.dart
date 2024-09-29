sealed class SearchState {}
class InitalSearchState extends SearchState {}


class GetSearchMoviesLoading extends SearchState {}

class GetSearchMoviesError extends SearchState {}

class GetSearchMoviesSuccses extends SearchState {}

class GetSearchMoviesNotFoundState extends SearchState {}