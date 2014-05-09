 program main
    INTEGER :: sz
    CHARACTER(len=32) :: arg
    Integer, Dimension(:), Allocatable :: vec, nor1, nor2

    ! Get input size
    CALL getarg(1, arg)
    read( arg, '(i10)' ) sz

    allocate(vec(1:sz))
    allocate(nor1(1:sz))
    allocate(nor2(1:sz))
    call generate(vec, sz, 1)
    write (*,*) vec(1)

    call normalise2(vec, nor1, nor2, sz)
    write (*,*) nor1(1)

    write (*,*) nor2(1)


 end program
 
 subroutine normalise2(A, nor1, nor2, sz)
    integer, intent(in) :: sz
    integer, intent(in),  dimension(sz) :: A
    integer, intent(out), dimension(sz) :: nor1, nor2

    integer :: i, N, s1, s2, gts_len
    integer, dimension(:) :: gts(size(A))

    N = size(A)

!   s1 = sum A
    s1 = 0
    do i = 1, N
        s1 = s1 + A(i)
    enddo

!   gts = filter (>0) A
    gts_len = 0
    do i = 1, N
        if (A(i) .gt. 0) then
            gts_len = gts_len + 1
            gts(gts_len) = A(i)
        endif
    enddo

!   s2 = sum gts
    s2 = 0
    do i = 1, gts_len
        s2 = s2 + gts(i)
    enddo

!   nor1 = map (/s1) A
    do i = 1, N
        nor1(i) = A(i) / s1
    enddo

!   nor2 = map (/s2) A
    do i = 1, N
        nor2(i) = A(i) / s2
    enddo

 end subroutine normalise2

 subroutine generate(gen, sz, seed)
    integer, intent(in) :: sz, seed
    integer, intent(out), dimension(sz) :: gen
    integer :: i
    do i = 1, size(gen)
        gen(i) = modulo((i-1) * seed * 512354 + 1234824, 12349)
    enddo
 end subroutine generate
  
