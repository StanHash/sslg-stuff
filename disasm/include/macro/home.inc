
xcall: macro

    ld a, BANK(\1)
    ld [rROMB0], a
    call \1

    endm
