
 BEGIN_PROVIDER [double precision, state_av_full_occ_2_rdm_ab_mo, (n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb)]
 implicit none
 state_av_full_occ_2_rdm_ab_mo = 0.d0
 integer :: i,j,k,l,iorb,jorb,korb,lorb
 BEGIN_DOC
! state_av_full_occ_2_rdm_ab_mo(i,j,k,l) =  STATE AVERAGE physicist notation for 2RDM of alpha/beta electrons 
!
! <Psi| a^{\dagger}_{i \alpha} a^{\dagger}_{j \beta} a_{l \beta} a_{k \alpha} |Psi>
!
! !!!!! WARNING !!!!! ALL SLATER DETERMINANTS IN PSI_DET MUST BELONG TO AN ACTIVE SPACE DEFINED BY "list_act" 
!
!                     BUT THE STRUCTURE OF THE TWO-RDM ON THE RANGE OF OCCUPIED MOS (CORE+INACT+ACT) BECAUSE IT CAN BE CONVENIENT FOR SOME APPLICATIONS 
!
! !!!!! WARNING !!!!! For efficiency reasons, electron 1 is ALPHA, electron 2 is BETA 
!
!  state_av_full_occ_2_rdm_ab_mo(i,j,k,l) = i:alpha, j:beta, j:alpha, l:beta
!                      
!                      Therefore you don't necessary have symmetry between electron 1 and 2 
!
!  !!!!! WARNING !!!!! IF "no_core_density" then all elements involving at least one CORE MO is set to zero 
 END_DOC 
 state_av_full_occ_2_rdm_ab_mo = 0.d0
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_act_orb
      korb = list_act(k)
      do l = 1, n_act_orb
       lorb = list_act(l)
       !                                     alph beta alph beta 
       state_av_full_occ_2_rdm_ab_mo(lorb,korb,jorb,iorb) = & 
        state_av_act_2_rdm_ab_mo(l,k,j,i)
       enddo
      enddo
     enddo
    enddo
   !! BETA ACTIVE - ALPHA inactive 
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_ab_mo(korb,jorb,korb,iorb) = one_e_dm_mo_beta_average(jorb,iorb)
     enddo
    enddo
   enddo

   !! ALPHA ACTIVE - BETA inactive 
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_ab_mo(jorb,korb,iorb,korb) = one_e_dm_mo_alpha_average(jorb,iorb)
     enddo
    enddo
   enddo

   !! ALPHA INACTIVE - BETA INACTIVE 
   !! 
    do j = 1, n_inact_orb
     jorb = list_inact(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_ab_mo(korb,jorb,korb,jorb) = 1.D0
     enddo
    enddo

!!!!!!!!!!!!
!!!!!!!!!!!! if "no_core_density" then you don't put the core part 
!!!!!!!!!!!! CAN BE USED 
   if (.not.no_core_density)then
    !! BETA ACTIVE - ALPHA CORE 
    !! 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                     alph beta alph beta
       state_av_full_occ_2_rdm_ab_mo(korb,jorb,korb,iorb) = one_e_dm_mo_beta_average(jorb,iorb)
      enddo
     enddo
    enddo
    
    !! ALPHA ACTIVE - BETA CORE
    !! 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                     alph beta alph beta
       state_av_full_occ_2_rdm_ab_mo(jorb,korb,iorb,korb) = one_e_dm_mo_alpha_average(jorb,iorb)
      enddo
     enddo
    enddo

   !! ALPHA CORE - BETA CORE 
   !! 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_ab_mo(korb,jorb,korb,jorb) = 1.D0
     enddo
    enddo
   endif

 END_PROVIDER 


 BEGIN_PROVIDER [double precision, state_av_full_occ_2_rdm_aa_mo, (n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb)]
 implicit none
 state_av_full_occ_2_rdm_aa_mo = 0.d0
 integer :: i,j,k,l,iorb,jorb,korb,lorb
 BEGIN_DOC
! state_av_full_occ_2_rdm_aa_mo(i,j,k,l) =  STATE AVERAGE physicist notation for 2RDM of alpha/alpha electrons 
!
! <Psi| a^{\dagger}_{i \alpha} a^{\dagger}_{j \alpha} a_{l \alpha} a_{k \alpha} |Psi>
!
! !!!!! WARNING !!!!! ALL SLATER DETERMINANTS IN PSI_DET MUST BELONG TO AN ACTIVE SPACE DEFINED BY "list_act" 
!
!                     BUT THE STRUCTURE OF THE TWO-RDM ON THE FULL RANGE OF MOs IS IMPLEMENTED BECAUSE IT CAN BE CONVENIENT FOR SOME APPLICATIONS 
!
!  !!!!! WARNING !!!!! IF "no_core_density" then all elements involving at least one CORE MO is set to zero 
 END_DOC 

   !! PURE ACTIVE PART ALPHA-ALPHA
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_act_orb
      korb = list_act(k)
      do l = 1, n_act_orb
       lorb = list_act(l)
       state_av_full_occ_2_rdm_aa_mo(lorb,korb,jorb,iorb) =  &
        state_av_act_2_rdm_aa_mo(l,k,j,i)
       enddo
      enddo
     enddo
    enddo
   !! ALPHA ACTIVE - ALPHA inactive 
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                       1     2   1    2    : DIRECT TERM 
      state_av_full_occ_2_rdm_aa_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      state_av_full_occ_2_rdm_aa_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      !                                       1     2   1    2    : EXCHANGE TERM 
      state_av_full_occ_2_rdm_aa_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      state_av_full_occ_2_rdm_aa_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
     enddo
    enddo
   enddo

   !! ALPHA INACTIVE - ALPHA INACTIVE 
   do j = 1, n_inact_orb
    jorb = list_inact(j)
    do k = 1, n_inact_orb
     korb = list_inact(k)
     state_av_full_occ_2_rdm_aa_mo(korb,jorb,korb,jorb) +=  0.5d0 
     state_av_full_occ_2_rdm_aa_mo(korb,jorb,jorb,korb) -=  0.5d0 
    enddo
   enddo

!!!!!!!!!!
!!!!!!!!!! if "no_core_density" then you don't put the core part 
!!!!!!!!!! CAN BE USED 
   if (.not.no_core_density)then
    !! ALPHA ACTIVE - ALPHA CORE 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                       1     2   1    2    : DIRECT TERM 
       state_av_full_occ_2_rdm_aa_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       state_av_full_occ_2_rdm_aa_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       !                                       1     2   1    2    : EXCHANGE TERM 
       state_av_full_occ_2_rdm_aa_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       state_av_full_occ_2_rdm_aa_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      enddo
     enddo
    enddo
    !! ALPHA CORE - ALPHA CORE 
 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      state_av_full_occ_2_rdm_aa_mo(korb,jorb,korb,jorb) +=  0.5d0 
      state_av_full_occ_2_rdm_aa_mo(korb,jorb,jorb,korb) -=  0.5d0 
     enddo
    enddo
   endif

 END_PROVIDER 

 BEGIN_PROVIDER [double precision, state_av_full_occ_2_rdm_bb_mo, (n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb)]
 implicit none
 state_av_full_occ_2_rdm_bb_mo = 0.d0
 integer :: i,j,k,l,iorb,jorb,korb,lorb
 BEGIN_DOC
! state_av_full_occ_2_rdm_bb_mo(i,j,k,l) =  STATE AVERAGE physicist notation for 2RDM of beta/beta electrons 
!
! <Psi| a^{\dagger}_{i \beta} a^{\dagger}_{j \beta} a_{l \beta} a_{k \beta} |Psi>
!
! !!!!! WARNING !!!!! ALL SLATER DETERMINANTS IN PSI_DET MUST BELONG TO AN ACTIVE SPACE DEFINED BY "list_act" 
!
!                     BUT THE STRUCTURE OF THE TWO-RDM ON THE FULL RANGE OF MOs IS IMPLEMENTED BECAUSE IT CAN BE CONVENIENT FOR SOME APPLICATIONS 
!
!  !!!!! WARNING !!!!! IF "no_core_density" then all elements involving at least one CORE MO is set to zero 
 END_DOC 

   !! PURE ACTIVE PART beta-beta
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_act_orb
      korb = list_act(k)
      do l = 1, n_act_orb
       lorb = list_act(l)
       state_av_full_occ_2_rdm_bb_mo(lorb,korb,jorb,iorb) = & 
        state_av_act_2_rdm_bb_mo(l,k,j,i)
       enddo
      enddo
     enddo
    enddo
   !! beta ACTIVE - beta inactive 
   !! 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                       1     2   1    2    : DIRECT TERM 
      state_av_full_occ_2_rdm_bb_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      state_av_full_occ_2_rdm_bb_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      !                                       1     2   1    2    : EXCHANGE TERM 
      state_av_full_occ_2_rdm_bb_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      state_av_full_occ_2_rdm_bb_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
     enddo
    enddo
   enddo

   !! beta INACTIVE - beta INACTIVE 
   do j = 1, n_inact_orb
    jorb = list_inact(j)
    do k = 1, n_inact_orb
     korb = list_inact(k)
     state_av_full_occ_2_rdm_bb_mo(korb,jorb,korb,jorb) +=  0.5d0 
     state_av_full_occ_2_rdm_bb_mo(korb,jorb,jorb,korb) -=  0.5d0 
    enddo
   enddo

!!!!!!!!!!!!
!!!!!!!!!!!! if "no_core_density" then you don't put the core part 
!!!!!!!!!!!! CAN BE USED 
   if (.not.no_core_density)then
    !! beta ACTIVE - beta CORE 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                       1     2   1    2    : DIRECT TERM 
       state_av_full_occ_2_rdm_bb_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       state_av_full_occ_2_rdm_bb_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       !                                       1     2   1    2    : EXCHANGE TERM 
       state_av_full_occ_2_rdm_bb_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       state_av_full_occ_2_rdm_bb_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      enddo
     enddo
    enddo
    !! beta CORE - beta CORE 
 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      state_av_full_occ_2_rdm_bb_mo(korb,jorb,korb,jorb) +=  0.5d0 
      state_av_full_occ_2_rdm_bb_mo(korb,jorb,jorb,korb) -=  0.5d0 
     enddo
    enddo
   endif

 END_PROVIDER 

 BEGIN_PROVIDER [double precision, state_av_full_occ_2_rdm_spin_trace_mo, (n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb,n_core_inact_act_orb)]
 implicit none
 state_av_full_occ_2_rdm_spin_trace_mo = 0.d0
 integer :: i,j,k,l,iorb,jorb,korb,lorb
 BEGIN_DOC
! state_av_full_occ_2_rdm_bb_mo(i,j,k,l) =  STATE AVERAGE physicist notation for 2RDM of beta/beta electrons 
!
! <Psi| a^{\dagger}_{i \beta} a^{\dagger}_{j \beta} a_{l \beta} a_{k \beta} |Psi>
!
! !!!!! WARNING !!!!! ALL SLATER DETERMINANTS IN PSI_DET MUST BELONG TO AN ACTIVE SPACE DEFINED BY "list_act" 
!
!                     BUT THE STRUCTURE OF THE TWO-RDM ON THE FULL RANGE OF MOs IS IMPLEMENTED BECAUSE IT CAN BE CONVENIENT FOR SOME APPLICATIONS 
!
!  !!!!! WARNING !!!!! IF "no_core_density" then all elements involving at least one CORE MO is set to zero 
 END_DOC 

   !!!!!!!!!!!!!!!! 
   !!!!!!!!!!!!!!!! 
   !! PURE ACTIVE PART SPIN-TRACE
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_act_orb
      korb = list_act(k)
      do l = 1, n_act_orb
       lorb = list_act(l)
       state_av_full_occ_2_rdm_spin_trace_mo(lorb,korb,jorb,iorb) += & 
        state_av_act_2_rdm_spin_trace_mo(l,k,j,i)
       enddo
      enddo
     enddo
    enddo

   !!!!!!!!!!!!!!!! 
   !!!!!!!!!!!!!!!! 
   !!!!! BETA-BETA !!!!!
   !! beta ACTIVE - beta inactive 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                       1     2   1    2    : DIRECT TERM 
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      !                                       1     2   1    2    : EXCHANGE TERM 
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
     enddo
    enddo
   enddo
   !! beta INACTIVE - beta INACTIVE 
   do j = 1, n_inact_orb
    jorb = list_inact(j)
    do k = 1, n_inact_orb
     korb = list_inact(k)
     state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) +=  0.5d0 
     state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,jorb,korb) -=  0.5d0 
    enddo
   enddo
   if (.not.no_core_density)then
    !! beta ACTIVE - beta CORE 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                       1     2   1    2    : DIRECT TERM 
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       !                                       1     2   1    2    : EXCHANGE TERM 
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      enddo
     enddo
    enddo
    !! beta CORE - beta CORE 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) +=  0.5d0 
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,jorb,korb) -=  0.5d0 
     enddo
    enddo
   endif

   !!!!!!!!!!!!!!!! 
   !!!!!!!!!!!!!!!! 
   !!!!! ALPHA-ALPHA !!!!!
   !! ALPHA ACTIVE - ALPHA inactive 
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                       1     2   1    2    : DIRECT TERM 
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      !                                       1     2   1    2    : EXCHANGE TERM 
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
     enddo
    enddo
   enddo
   !! ALPHA INACTIVE - ALPHA INACTIVE 
   do j = 1, n_inact_orb
    jorb = list_inact(j)
    do k = 1, n_inact_orb
     korb = list_inact(k)
     state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) +=  0.5d0 
     state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,jorb,korb) -=  0.5d0 
    enddo
   enddo
   if (.not.no_core_density)then
    !! ALPHA ACTIVE - ALPHA CORE 
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !                                       1     2   1    2    : DIRECT TERM 
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) +=  0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       !                                       1     2   1    2    : EXCHANGE TERM 
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,korb,iorb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,iorb,korb) += -0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      enddo
     enddo
    enddo
    !! ALPHA CORE - ALPHA CORE 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) +=  0.5d0 
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,jorb,korb) -=  0.5d0 
     enddo
    enddo
   endif

   !!!!!!!!!!!!!!!! 
   !!!!!!!!!!!!!!!! 
   !!!!! ALPHA-BETA + BETA-ALPHA !!!!!
   do i = 1, n_act_orb
    iorb = list_act(i)
    do j = 1, n_act_orb
     jorb = list_act(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      ! ALPHA INACTIVE - BETA ACTIVE
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) += 0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      !                                     beta alph beta alph
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) += 0.5d0 * one_e_dm_mo_beta_average(jorb,iorb)
      ! BETA INACTIVE - ALPHA ACTIVE
      !                                     beta alph beta alpha 
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) += 0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
      !                                     alph beta alph beta 
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) += 0.5d0 * one_e_dm_mo_alpha_average(jorb,iorb)
     enddo
    enddo
   enddo
   !! ALPHA INACTIVE - BETA INACTIVE 
    do j = 1, n_inact_orb
     jorb = list_inact(j)
     do k = 1, n_inact_orb
      korb = list_inact(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) += 0.5D0
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,jorb,korb) += 0.5D0
     enddo
    enddo

!!!!!!!!!!!!
!!!!!!!!!!!! if "no_core_density" then you don't put the core part 
!!!!!!!!!!!! CAN BE USED 
   if (.not.no_core_density)then
    do i = 1, n_act_orb
     iorb = list_act(i)
     do j = 1, n_act_orb
      jorb = list_act(j)
      do k = 1, n_core_orb
       korb = list_core(k)
       !! BETA ACTIVE - ALPHA CORE 
       !                                     alph beta alph beta
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) += 0.5D0 * one_e_dm_mo_beta_average(jorb,iorb)
       !                                     beta alph beta alph 
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) += 0.5D0 * one_e_dm_mo_beta_average(jorb,iorb)
       !! ALPHA ACTIVE - BETA CORE 
       !                                     alph beta alph beta
       state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,iorb,korb) += 0.5D0 * one_e_dm_mo_alpha_average(jorb,iorb)
       !                                     beta alph beta alph 
       state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,iorb) += 0.5D0 * one_e_dm_mo_alpha_average(jorb,iorb)
      enddo
     enddo
    enddo
   !! ALPHA CORE - BETA CORE 
    do j = 1, n_core_orb
     jorb = list_core(j)
     do k = 1, n_core_orb
      korb = list_core(k)
      !                                     alph beta alph beta
      state_av_full_occ_2_rdm_spin_trace_mo(korb,jorb,korb,jorb) += 0.5D0
      state_av_full_occ_2_rdm_spin_trace_mo(jorb,korb,jorb,korb) += 0.5D0
     enddo
    enddo

   endif

 END_PROVIDER 
