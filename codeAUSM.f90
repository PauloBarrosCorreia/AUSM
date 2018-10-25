program codeAUSM
  !
  ! Implementation of AUSM for 1D Euler equations
  ! @pcorreia
  !
  use m_init
  
  implicit none

  integer :: i

  call initialization()

  do i = 1,  niter
     call ausm()
     call update()
  end do

  call output()

  print *, '** End **'

end program codeAUSM
