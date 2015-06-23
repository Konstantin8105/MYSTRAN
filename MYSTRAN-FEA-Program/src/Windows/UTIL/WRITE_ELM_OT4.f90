! ##################################################################################################################################
 
      SUBROUTINE WRITE_ELM_OT4 ( MAT_NAME, NROWS_MAT, NROWS_TXT, NCOLS, TXT, UNT )
 
! Writes CB OTM text file that describes the rows of element related OTM matrices

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE
      USE IOUNT1, ONLY                :  F04, WRT_LOG
      USE SCONTR, ONLY                :  BLNK_SUB_NAM
      USE TIMDAT, ONLY                :  TSEC
      USE CC_OUTPUT_DESCRIBERS, ONLY  :  STRN_LOC, STRE_LOC
      USE SUBR_BEGEND_LEVELS, ONLY    :  WRITE_ELM_OT4_BEGEND
 
      USE WRITE_ELM_OT4_USE_IFs

      IMPLICIT NONE
 
      logical                         :: opnd
      INTEGER(LONG), INTENT(IN)       :: NROWS_TXT         ! Number of rows in TXT

      CHARACTER(LEN=LEN(BLNK_SUB_NAM)):: SUBR_NAME = 'WRITE_ELM_OT4'
      CHARACTER(LEN=*), INTENT(IN)    :: MAT_NAME          ! Matrix name of the OTM that MAT describes
      CHARACTER(LEN=*), INTENT(IN)    :: TXT(NROWS_TXT)    ! Lines of this array describe the rows of CB OTM of MAT_NAME

      INTEGER(LONG), INTENT(IN)       :: NCOLS             ! Number of cols in MAT
      INTEGER(LONG), INTENT(IN)       :: NROWS_MAT         ! Number of rows in MAT
      INTEGER(LONG), INTENT(IN)       :: UNT               ! Unit number where to write matrix
      INTEGER(LONG)                   :: I                 ! DO loop index
      INTEGER(LONG), PARAMETER        :: SUBR_BEGEND = WRITE_ELM_OT4_BEGEND
 
! **********************************************************************************************************************************
      IF (WRT_LOG >= SUBR_BEGEND) THEN
         CALL OURTIM
         WRITE(F04,9001) SUBR_NAME,TSEC
 9001    FORMAT(1X,A,' BEGN ',F10.3)
      ENDIF

! **********************************************************************************************************************************
      WRITE(UNT,11) NROWS_MAT, NCOLS, MAT_NAME
      IF      (MAT_NAME(1:8) == 'OTM_ELFE') THEN 
         WRITE(UNT,21)
      ELSE IF (MAT_NAME(1:8) == 'OTM_ELFN') THEN 
         WRITE(UNT,22) 
      ELSE IF (MAT_NAME(1:8) == 'OTM_STRE') THEN
         IF ((STRE_LOC == 'CORNER  ') .OR. (STRE_LOC == 'GAUSS   ')) THEN 
            WRITE(UNT,231)
         ELSE 
            WRITE(UNT,232)
         ENDIF 
      ELSE IF (MAT_NAME(1:8) == 'OTM_STRN') THEN 
         IF ((STRN_LOC == 'CORNER  ') .OR. (STRN_LOC == 'GAUSS   ')) THEN 
            WRITE(UNT,241)
         ELSE 
            WRITE(UNT,242)
         ENDIF 
      ENDIF

      DO I=1,NROWS_TXT
         WRITE(UNT,31) TXT(I)
      ENDDO

      WRITE(UNT, *)

! **********************************************************************************************************************************
      IF (WRT_LOG >= SUBR_BEGEND) THEN
         CALL OURTIM
         WRITE(F04,9002) SUBR_NAME,TSEC
 9002    FORMAT(1X,A,' END  ',F10.3)
      ENDIF

      RETURN

! **********************************************************************************************************************************
   11 FORMAT('-------------------------------------------------------------------------------------------------------------------',&
             '----------------',/,                                                                                                 &
             '       Explanation of rows of ',I8,' row by ',I8,' col matrix ',A,/)

   21 FORMAT('   ROW            DESCRIPTION             TYPE     EID              ITEM',/,                                         &
             ' ------- ------------------------------ -------- -------    --------------------')

   22 FORMAT('   ROW            DESCRIPTION             TYPE     EID     GRID     COMP',/,                                         &
             ' ------- ------------------------------ -------- ------- -------    ----')

  231 FORMAT('   ROW            DESCRIPTION             TYPE     EID        LOCATION            ITEM',/,                           &
             ' ------- ------------------------------ -------- -------    ------------   --------------------')

  232 FORMAT('   ROW            DESCRIPTION             TYPE     EID              ITEM',/,                                         &
             ' ------- ------------------------------ -------- -------    --------------------')

  241 FORMAT('   ROW            DESCRIPTION             TYPE     EID        LOCATION            ITEM',/,                           &
             ' ------- ------------------------------ -------- -------    ------------   --------------------')

  242 FORMAT('   ROW            DESCRIPTION             TYPE     EID              ITEM',/,                                         &
             ' ------- ------------------------------ -------- -------    --------------------')

   31 FORMAT(A)

! **********************************************************************************************************************************

      END SUBROUTINE WRITE_ELM_OT4