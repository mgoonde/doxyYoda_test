module my_fortran_module


  !> @brief my favourite fortran structure
  type :: this_t
     integer :: i !< @brief a single integer
     !< continues here
     integer, allocatable :: i1(:)
     !< @brief rank-1 allocatable integer, with doc after definition
   contains
     procedure :: compute => this_t_compute
     final :: this_t_free
  end type this_t


  !> @brief overload the type name with constructor
  interface this_t
     procedure :: this_t_create
  end interface this_t


  ! interface declaring routine in a submodule
  interface
     !> @brief
     !! doc of single routine in interface, implementation in submodule
     module subroutine submod_routine( r )
       real, intent(in) :: r !< @brief real r, expect in
     end subroutine submod_routine
  end interface


  ! ! type-bound overloading
  ! interface type_bound_overload
  !    procedure :: t_i, t_r
  ! end interface

contains


  function this_t_create()result(self)
    !> @brief constructor to `this_t`
    type(this_t), pointer :: self
    allocate( this_t::self )
    self% i = 12
  end function this_t_create

  subroutine this_t_compute( self )
    !> @brief execute computation
    class( this_t ), intent(inout) :: self
    call compute_internal( self%i, self%i1 )
  end subroutine this_t_compute

  subroutine this_t_free( self )
    !> @brief deallocate this_t
    type( this_t ), intent(inout) :: self
    if( allocated( self%i1)) deallocate( self%i1)
  end subroutine this_t_free


  subroutine compute_internal( i, i1 )
    integer, intent(inout) :: i
    integer, allocatable, intent(out) :: i1
    i = i + 2
    allocate( i1(1:5), source=99 )
  end subroutine compute_internal


end module my_fortran_module
