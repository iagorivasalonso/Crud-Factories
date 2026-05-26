enum LoadResult {
  success,
  invalidFile,
  error,
}


enum CreateResult {
  success,
  alreadyExists,
  invalidData,
}

enum EditResult   {
  success,
  alreadyExists,
  notFound,
  invalidData,
  error
}

enum DeleteResult {
  success,
  notFound,
  hasDependencies,
  error
}

