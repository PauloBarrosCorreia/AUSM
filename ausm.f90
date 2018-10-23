subroutine ausm()

  use m_init

  implicit none

  integer :: j
  real( kind=dp ) :: al, ar, hl, hr, mr, mpm, ml, mm, mp
  real( kind=dp ) :: pl, pr, pm, pp
  real( kind=dp ) :: retl, retr, rhol, rhor, rul, rur
  real( kind=dp ) :: ul, ur

!  real( 8 ) :: al, ar, hl, hr, mr, mpm, ml, mm, mp
!  real( 8 ) :: pl, pr, pm, pp
!  real( 8 ) :: retl, retr, rhol, rhor, rul, rur
!  real( 8 ) :: ul, ur  

  do j = 0, ncells+1

     rhol = u1 (j)
     rhor = u1 (j+1)

     retl = u3 (j)
     retr = u3 (j+1)

     rul = u2 (j)
     rur = u2 (j+1)

     ul = u2 (j) / rhol
     ur = u2 (j+1) / rhor

     pl = (gamma-1.) * (retl - 0.5 * rul * rul / rhol)
     pr = (gamma-1.) * (retr - 0.5 * rur * rur / rhol)

     hl = (retl+pl)/rhol
     hr = (retr+pr)/rhor

     al = sqrt(gamma*pl/rhol)
     ar = sqrt(gamma*pr/rhor)

     Ml = ul/al
     Mr = ur/ar

     if (Ml <= -1.) then
        Mp = 0.
        pp = 0.
     elseif (Ml<1.) then
        Mp = 0.25*(Ml+1.)*(Ml+1.)
        pp = 0.5*(1.+Ml)*pl
     else
        Mp = Ml
        pp = pl
     end if

     if (Mr <= -1.) then
        Mm = Mr
        pm = pr
     elseif (Mr < 1.) then
        Mm = -0.25*(Mr-1.)*(Mr-1.)
        pm = 0.5*(1.-Mr)*pr
     else
        Mm = 0.
        pm = 0.
     end if

     Mpm = Mp + Mm
     
     f1 (j) = max(0.,Mpm) * rhol * al + min(0.,Mpm)*rhor*ar
     f2 (j) = max(0.,Mpm) * rul * al + min(0.,Mpm)*rur*ar + pp + pm
     f3 (j) = max(0.,Mpm) * rhol*hl*al+min(0.,Mpm)*rhor*hr*ar
  end do

end subroutine ausm
