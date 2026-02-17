module my_api_c
  use, intrinsic :: iso_c_binding
  use, intrinsic :: ieee_arithmetic
  implicit none

  !> @brief a C-interop structure for derived type `this_t`
  type, bind(C) :: this_t
     integer( c_int ) :: i
     type( c_ptr ) :: i1
  end type this_t

  !> @brief interfaces to C routines for malloc and free
  interface
     function c_malloc(size) bind(C, name="malloc")
       use, intrinsic :: iso_c_binding, only: c_size_t, c_ptr
       integer(c_size_t), intent(in), value :: size
       type(c_ptr) :: c_malloc
     end function c_malloc

     subroutine c_free(ptr) bind(c, name='free')
       use, intrinsic :: iso_c_binding, only: c_ptr
       implicit none
       type(c_ptr), value :: ptr
     end subroutine c_free
  end interface

contains

  subroutine this_create( cself )bind(C,name="this_create")
    use my_fortran_module, only: this_f => this_t
    type( this_t ), intent(out) :: cself
    type( this_f ), pointer :: fself
    fself => this_f()
    cself% i = int( fself%i, kind=kind(cself%i) )
    cself% i1 = c_null_ptr
    deallocate(fself)
  end subroutine this_create

  subroutine this_free( cself )bind(C,name="this_free" )
    type( this_t ), intent(inout) :: cself
    if( c_associated(cself%i1)) call c_free( cself%i1 )
    cself%i1 = c_null_ptr
  end subroutine this_free

  subroutine this_compute( cself )bind(C,name="this_compute")
    use my_fortran_module, only: compute_internal
    type( this_t ), intent(inout) :: cself
    integer :: int
    integer, allocatable :: int1(:)
    int = int( cself%i, kind=kind(int) )
    call compute_internal( int, int1 )
    if( allocated(int1)) then
       block
         integer :: fsize
         integer(c_int), pointer :: int1ptr(:) => null()
         fsize = product(shape(int1))
         cself%i1 = c_malloc( c_sizeof(1_c_int)*fsize )
         call c_f_pointer( cself%i1, int1ptr )
         int1ptr = int( int1, kind=kind(int1ptr) )
       end block
    end if
  end subroutine this_compute

end module my_api_c
