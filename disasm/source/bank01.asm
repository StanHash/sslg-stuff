    include "include/hardware.inc"

    section "bank01", romx, bank[$01]

Func_01_4000: ; 004000 (01:4000)
    ld a, [wUnkC0C2]
    ld [wUnkC21C], a
    ld a, [wUnkC0C3]
    ld [wUnkC21C+1], a

    ld a, [wUnkC0C4]
    ld [wUnkC21E], a
    ld a, [wUnkC0C5]
    ld [wUnkC21E+1], a

    call Func_189D

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    and a, $3F
    ld h, a

    srl h
    rr l

    ld a, $00
    ld [rRAMB], a

    ld a, $0A
    ld [rRAMG], a

    ld de, sUnk0A000
    add hl, de
    ld a, [wUnkC0CB]
    ld [hl], a

    ld a, $00
    ld [rRAMB], a

    call Func_14E1

    ret

; end at 004044
