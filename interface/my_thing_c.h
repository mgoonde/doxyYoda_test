struct this_t{
  int i; ///< @brief integer i from c struct

  int *i1; ///< @brief integer dim 1, alloc size is 1:5
  ///< @code{.c}
  /// int g=0;
  /// // this is a comment in a code snippet
  /// float r=0.1;
  /// @endcode
};


/// @brief
/// create a thi_t instance
void this_create( struct this_t * );

/// @brief
/// free a this_t instance
void this_free( struct this_t *);

/// @brief
/// launch compute on this_t instance
void this_compute( struct this_t *);

