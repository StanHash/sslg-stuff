    include "include/hardware.inc"
    include "include/undef.inc"

    include "include/macro/home.inc"

    include "include/constants/bool.inc"
    include "include/constants/keys.inc"
    include "include/constants/compare.inc"

    include "include/struct/C300.inc"
    include "include/struct/sprite.inc"

    section "0000", rom0[$0000]

Func_0000: ; 000000 (00:0000)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO:BANK(Func_01_7018)
    ld [rROMB0], a
    call Func_01_7018

    pop af
    ld [rROMB0], a

    ret

    section "0011", rom0[$0011]

Func_0011: ; 000011 (00:0011)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO:BANK(Func_01_7061)
    ld [rROMB0], a
    call Func_01_7061

    pop af
    ld [rROMB0], a

    ret

    section "0022", rom0[$0022]

Func_0022: ; 000022 (00:0022)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO:BANK(Func_01_7117)
    ld [rROMB0], a
    call Func_01_7117

    pop af
    ld [rROMB0], a

    ret

    section "0033", rom0[$0033]

Func_0033: ; 000033 (00:0033)
    sub a, b
    jr c, .code_0037
    ret
.code_0037:
    ld a, 0
    ret

    section "0064", rom0[$0064]

Func_0064: ; 000064 (00:0064)
    ld a, [CurrentBank]
    push af

    ld a, $13 ; TODO:BANK(Func_13_43D2)
    ld [rROMB0], a
    call Func_13_43D2

    pop af
    ld [rROMB0], a

    ret

    section "0075", rom0[$0075]

    ; TODO: what is this?
Data_0075:
    db $FE, $63, $0B, $0C, $0D, $0E

    section "007B", rom0[$007B]

Func_007B: ; 00007B (00:007B)
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO:BANK(Func_03_5AC3)
    ld [rROMB0], a
    ld a, b
    call Func_03_5AC3

    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a

    ld a, [hli]
    ld c, a

    pop af
    ld [rROMB0], a

    pop hl

    ret

    section "0099", rom0[$0099]

Func_0099: ; 000099 (00:0099)
    ld a, [CurrentBank]
    push af

    di

    ld a, $11 ; TODO:BANK?
    ld [rROMB0], a

    ld a, [hli]
    ld [wUnkC482+1], a
    ld a, [hli]
    ld [wUnkC482], a
    ld a, [hli]
    ld [rROMB0], a

    ld a, 1
    ld [wUnkC062], a

    call WaitForVBlank

    ld a, 0
    ld [wUnkC062], a

    di

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ldh [rLCDC], a

    ld a, BANK(vTilesB1)
    ldh [rVBK], a

    ld a, [wUnkC482]
    ld h, a
    ld a, [wUnkC482+1]
    ld l, a

    ld de, vTilesB1 + $500
    ld bc, $200

    ld a, h
    ldh [rHDMA1], a
    ld a, l
    ldh [rHDMA2], a
    ld a, d
    ldh [rHDMA3], a
    ld a, e
    ldh [rHDMA4], a
    ld a, $1F
    ldh [rHDMA5], a

    ei

    pop af
    ld [rROMB0], a

    ret

    section "00E9", rom0[$00E9]

Func_00E9: ; 0000E9 (00:00E9)
    ld [wUnkC448], a

    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO:BANK(Func_02_50D9)
    ld [rROMB0], a

    call Func_02_50D9

    pop af
    ld [rROMB0], a

    ret

    section "0150", rom0[$0150]

Func_0150: ; 000150 (00:0150)
    ld a, [hHeldKeys]
    or a, a
    ret z

    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO:BANK(Func_01_4086)
    ld [rROMB0], a

    call Func_01_4086

    pop af
    ld [rROMB0], a

    ret

    db $EA ; useless

    section "0167", rom0[$0167]

Func_0167: ; 000167 (00:0167)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO:BANK(Func_01_6E12)
    ld [rROMB0], a

    call Func_01_6E12

    pop af
    ld [rROMB0], a

    ret

    ; =====================
    ; = INTERRUPT VECTORS =
    ; =====================

    section "int40_vblank", rom0[$0040]
    jp OnVBlank

    section "int48_stat", rom0[$0048]
    jp OnStat

    section "int50_timer", rom0[$0050]
    reti
    jp OnTimer ; unreachable

    section "int58_serial", rom0[$0058]
    reti
    jp OnSerial ; unreachable

    section "int60_joypad", rom0[$0060]
    reti
    jp OnJoypad ; unreachable

    ; ==============
    ; = ROM HEADER =
    ; ==============

    section "head", rom0[$0100]

    nop
    jp Entry

    NINTENDO_LOGO
    db "SUPER SLG  "
    db "    "
    db $80 ; gbc compatible
    db "01"
    db $00 ; no sgb compatibility
    db $1B ; MBC5+RAM+BATTERY
    db $06 ; 2 MByte ROM (128 ROM banks)
    db $03 ; 32 KB SRAM (4 SRAM banks)
    db $00
    db $33
    db $01
    ; db $59 ; head checksum (expected)
    ; dw $05C6 ; rom checksum (expected)

    section "0178", rom0[$0178]

    ; for some reason, this area contains a copy of the ROM header
    ; it also has some extra bytes before it, and no checksum

    db $3E, $01, $EA, $00
    db $20, $CD, $57, $08
    db $00, $00, $00, $00
    NINTENDO_LOGO
    db "SUPER SLG  "
    db "    "
    db $80 ; gbc compatible
    db "01"
    db $00 ; no sgb compatibility
    db $1B ; MBC5+RAM+BATTERY
    db $06 ; 2 MByte ROM (128 ROM banks)
    db $03 ; 32 KB SRAM (4 SRAM banks)
    db $00
    db $33
    db $01
    db 0, 0, 0 ; this is where checksums would usually be

    section "home", rom0

Entry: ; 0001D0 (00:01D0)
    di

    ld [hCgbMark], a

    ld a, 1
    ldh [hUnkFFFE], a

    ld hl, _RAMBANK+$0FFF
    ld sp, hl

    ; TODO: what is this?
    ld a, $1D
    ld [$5010], a
    ld a, $72
    ld [$7020], a

    ld a, 0
    ld [rLCDC], a
    ld [rSTAT], a

    ld a, $17 ; TODO: BANK(Data_17_555D)
    ld [rROMB0], a

    ld de, Data_17_555D
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a

    jp hl

Func_01FC: ; 0001FC (00:01FC)
    di
    call Func_057D
    ei

    ld a, $10
    ld [rROMB0], a

    ld a, [wUnkC49C]

    cp a, 0
    jp z, Func_0527

    cp a, 1
    jp z, Func_0527

    cp a, 2
    jp z, Func_0527

    jr .code_0228

    ld a, $02
    ld [wUnkC2B1], a
    ld a, [wUnkC007]
    ld [wUnkC2B0], a
    call Func_32FC

.code_0228:
    ld a, 1
    ld [wUnkC49C], a

    call Func_2DF4
    jp z, Func_08D6

    ldh a, [hNewKeys]
    and a, KEY_BUTTON_START
    ret z

    ld a, $45
    call Func_2CC3

    ld a, $01
    ld [wUnkC112], a
    ld [wUnkC113], a

    ld a, $70
    ldh [rWY], a
    ld [wWY], a

    ld a, $07
    ldh [rWX], a
    ld [wWX], a

    call Func_3EB0

.lop:
    call WaitFrame
    call ReadKeyInput
    call Func_0150
    call Func_27BB
    call ClampCursorPosition
    call Func_1DFC
    call Func_3BD0

    di
    call Func_0707
    call Func_137E
    call Func_142F
    call Func_264F
    call Func_1B66
    ei

    ldh a, [hNewKeys]
    and $80
    jr z, .lop

    ld a, $45
    call Func_2CC3

    ld a, $00
    ld [wUnkC112], a
    ld [wUnkC113], a

    ld a, $90
    ldh [rWY], a
    ld [wWY], a

    ld a, $07
    ldh [rWX], a
    ld [wWX], a

    ; function does not finish?

    ; TODO: what is this?
Data_029D:
    db $BF, $C0, $C1, $C2
    db $BB, $BB, $BB, $BB
    db $CD

Func_02A6: ; 0002A6 (00:02A6)
    ld hl, _RAM
    ld bc, $1FF0
    call MemClear

    ld hl, wStack+$FF
    ld sp, hl

    ld a, $00
    call Func_2CC3

    call InitOamDmaFunc

    ld a, 0
    ld [rRAMB], a
    ld a, $A ; sram enable
    ld [rRAMG], a

    ld hl, _SRAM
    ld bc, $2000
    call MemClear

    ld a, 0
    ld [rRAMB], a

    ; wait for vblank to occur
.lop:
    ldh a, [rLY]
    cp 144
    jr nc, .lop

    xor a, a
    ldh [rSCY], a
    ldh [rSCX], a

    ; was that meant to be rLCDC?
    ; this write doesn't make much sense
    ld a, $C1
    ldh [rSTAT], a

    xor a, a
    ldh [rLYC], a

    ld a, %00011011 ; 0 1 2 3
    ldh [rBGP], a

    ld a, %00011011 ; 0 1 2 3
    ldh [rOBP0], a

    ld a, 0
    ldh [rIF], a
    ldh [rIE], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ldh [rLCDC], a

    ei
    nop

    call EnableCgbDoubleSpeedMode

    xor a, a
    ldh [rLCDC], a
    ldh [rSTAT], a
    ld [wCameraY], a
    ld [wCameraY+1], a
    ld [wCameraX], a
    ld [wCameraX+1], a
    ld [wUnkC48F], a
    ld [wUnkC022], a

    ld a, $03
    call Func_2CC3

    call ClearSprites
    call ClearOamBuf
    call ClearOam
    call ClearVRAM
    call ClearTileAttrs
    call ClearTileMaps

    xor a, a
    ldh [rSCY], a
    ldh [rSCX], a
    ld [wUnkC178], a
    ld [wUnkC024], a

    ld a, %11100100 ; 3 2 1 0
    ldh [rBGP], a
    ldh [rOBP0], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ldh [rLCDC], a

    ld a, $08
    ld [wUnkC2B7], a
    ld [wUnkC2B8], a

    ld a, IEF_LCDC | IEF_VBLANK
    ldh [rIF], a
    ldh [rIE], a

    ld a, $78 ; TODO: BANK(Func_78_59BE)
    ld [rROMB0], a
    call Func_78_59BE

    ld a, 0
    ld [rWY], a

    ld a, $13 ; TODO: BANK(Func_13_4000)
    ld [rROMB0], a
    call Func_13_4000

    ld a, [wUnkC48F]
    or a, a
    jr nz, Func_037E

    ld a, $13 ; TODO: BANK(Func_13_40D2)
    ld [rROMB0], a
    call Func_13_40D2

    ld a, [wUnkC48F]
    or a, a
    jr nz, Func_037E

    ld a, $12 ; TODO: BANK(Func_12_515E)
    ld [rROMB0], a
    call Func_12_515E

    ; fallthrough into Func_037E

Func_037E:
    ld a, $78 ; TODO: BANK(Func_78_4000)
    ld [rROMB0], a
    jp Func_78_4000

Func_0386: ; 000386 (00:0386)
    call Func_3F15

    ld a, $00
    ld [wUnkC007], a
    ld [wUnkC00C], a
    ld [wUnkC00D], a
    ld [wUnkC00E], a
    ld [wUnkC00F], a
    ld [wUnkC009], a
    ld [wUnkC00A], a
    ld [wUnkC00B], a

Func_03A3: ; 0003A3 (00:03A3)
    ld a, $0A ; sram enable
    ld [rRAMG], a

    xor a, a
    ld [wUnkC350], a
    ld [wSCY], a
    ld [wSCX], a
    ld [wCameraY], a
    ld [wCameraY+1], a
    ld [wCameraX], a
    ld [wCameraX+1], a

    ld a, $12 ; TODO: BANK(Func_12_4000)
    ld [rROMB0], a
    call Func_12_4000

    ld a, $00
    ld [wUnkC0D0], a

    ld a, $10 ; TODO: BANK(Func_10_4000)
    ld [rROMB0], a
    call Func_10_4000

    xor a, a
    ld [wUnkC178], a
    ld [wUnkC022], a
    ld [wUnkC026], a
    ld [wUnkC027], a
    ld [wUnkC02F], a
    ld [wUnkC43E], a
    ld [wUnkC02B], a

    ld a, %11100100 ; 3 2 1 0
    ldh [rBGP], a
    ld a, %11100100 ; 3 2 1 0
    ldh [rOBP0], a
    ld a, %00000000 ; 0 0 0 0
    ldh [rOBP1], a

    ; disable display
    xor a, a
    ldh [rLCDC], a

    call ClearSprites
    call ClearOamBuf
    call ClearOam
    call ClearTileAttrs
    call ClearTileMaps
    call ClearVRAM
    call Func_0C5B

    ld hl, Data_2CAB
    ld a, [wUnkC007]
    ld c, a
    ld b, 0
    add hl, bc

    ld a, [hli]
    call Func_2CC3

    ld a, $E0 | IEF_HILO | IEF_LCDC ; ?
    ldh [rIF], a

    xor a, a
    ld [wUnkC105], a

    ld a, $0B
    ld [wUnkC17C], a
    ld [wUnkC17D], a

    ld a, $01
    ld [wUnkC173], a

    xor a, a
    ld [wUnkC022], a
    ld [wUnkC023], a
    ld [wUnkC437], a
    ld [wUnkC437+1], a

    ld a, $30
    ld [wUnkC13A], a
    ld [wUnkC13B], a

    ld a, $06
    ld [wUnkC13C], a

    ld a, $F1
    ld [wUnkC13E], a

    ld a, $F1
    xor a ; ah yes
    ld [wUnkC13D], a

    ld a, $30
    ldh [rSCX], a

    ld a, $30
    ld [wWY], a
    ld [wWX], a

    ld a, IEF_VBLANK
    ldh [rIF], a
    ldh [rIE], a

    di
    call Func_057D
    ei

    ld a, [wUnkC014]
    or a, a
    jr z, .code_04AC

    ld a, [CurrentBank]
    push af

    ld a, $10 ; TODO: BANK(Data_10_66FC)
    ld [wUnkC006], a
    ld [rROMB0], a

    ; hl = Data_10_66FC + 2*[wUnkC007]
    ld a, [wUnkC007]
    add a
    ld l, a
    ld h, 0
    ld bc, Data_10_66FC
    add hl, bc

    ; hl = [hl]
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push bc
    pop hl

    ld a, [hli]
    ld [wUnkC001], a
    ld a, [hli]
    ld [wUnkC002], a
    ld a, [hli]
    ld [wUnkC003], a

    ld a, l
    ld [wUnkC004], a
    ld a, h
    ld [wUnkC004+1], a

    pop af
    ld [rROMB0], a

    ld a, 0
    ld [wUnkC014], a

.code_04AC:
    ld a, $16
    ld [wUnkC104], a
    ld a, $01
    ld [wUnkC105], a

    xor a, a
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a

    ld a, 0 ; useless, a is already 0
    ld [wUnkC080], a
    ld [wUnkC081], a
    ld [wUnkC112], a
    ld [wUnkC113], a

    ld a, 1
    ld [wUnkC022], a
    ld [wUnkC2B0], a

    call ClearSprites
    call ClearOamBuf
    call ClearOam
    call Func_3BBF

    ld hl, sUnk0A000 + $0060 ; TODO: SRAM variables
    ld a, l
    ld [wUnkC110], a
    ld a, h
    ld [wUnkC110+1], a

    ld hl, wSprites
    ld a, l
    ld [wUnkC3A0], a
    ld a, h
    ld [wUnkC3A0+1], a

    ld a, $E0
    ldh [rWY], a
    ld [wWY], a

    ld a, $E0
    ldh [rWX], a
    ld [wWX], a

    ld a, $01
    ld [wUnkC350], a

    ld a, TRUE
    ld [wRefreshObPal], a
    ld [wRefreshBgPal], a

    call WaitFrame

    ld a, [wUnkC49C]

    cp 0
    jr z, Func_0527

    cp 1
    jr z, Func_0527

    cp 2
    jr z, Func_0527

    jr Func_0543

Func_0527:
    ld a, $02
    ld [wUnkC2B1], a

    ld a, [wUnkC007]
    ld [wUnkC2B0], a

    call Func_32FC

    ld a, $03
    ld [wUnkC2B1], a

    ld a, [wUnkC007]
    ld [wUnkC2B0], a

    call Func_32FC

    ; fallthrough into Func_0543

Func_0543:
    ld a, 1
    ld [wUnkC49C], a

    call Func_2DF4

    ld a, $01
    ld [wRefreshObPal], a
    ld [wRefreshBgPal], a
    ld [wUnkC350], a

    jp Func_08D6

ClearSRAM: ; 000559 (00:0559)
    ld hl, _SRAM
    ld bc, $2000
    jr MemClear

ClearWRAM: ; 000561 (00:0561)
    ld hl, _RAM
    ld bc, $1F00
    jr MemClear

MemClear: ; 000569 (00:0569)
    ; in hl = addr
    ; in bc = size

    dec bc

.lop:
    xor a, a
    ld [hli], a

    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    ret

Func_0572: ; 000572 (00:0572)
    dec bc

.lop:
    ld a, [hl]
    and a, e
    or a, d
    ld [hli], a

    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    ret

Func_057D: ; 00057D (00:057D)
    ld a, [CurrentBank]
    push af

    ld a, $A0
    ld [wWY], a
    ld [wWX], a

    xor a, a
    ldh [rLCDC], a
    ldh [rSCY], a
    ldh [rSCX], a

    ; bc = ([wUnkC007] & $1F)*$40
    ld a, [wUnkC007]
    and $1F
    ld c, a
    xor a, a
    ld b, a
    ; shift left 6 times is multiplying by 2^6 which is $40
    static_assert STRUCT_C300_SIZE == $40
    rept 6
    sla c
    rl b
    endr

    ld hl, Data_5F_4000
    add hl, bc

    ld a, BANK(Data_5F_4000)
    ld [rROMB0], a

    ld de, wUnkC300
    ld b, STRUCT_C300_SIZE

.lop_init:
    ld a, [hli]
    ld [de], a
    inc de

    dec b
    jr nz, .lop_init

    ld a, [wUnkC300+STRUCT_C300_FIELD_00]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_02]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_02+1]
    ld h, a
    call SetBgPal

    ld a, [wUnkC300+STRUCT_C300_FIELD_04]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_06]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_06+1]
    ld h, a
    call SetObPal

    ld a, [wUnkC300+STRUCT_C300_FIELD_08]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_0A]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_0A+1]
    ld h, a
    call Func_06B7

    ld a, [wUnkC300+STRUCT_C300_FIELD_0C]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_0E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_0E+1]
    ld h, a
    call Func_06B7

    ld a, [wUnkC300+STRUCT_C300_FIELD_10]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_12]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_12+1]
    ld h, a
    call Func_06B7

    ld a, [wUnkC300+STRUCT_C300_FIELD_14]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_16]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_16+1]
    ld h, a
    call SetTileAttrs

    ld a, [wUnkC300+STRUCT_C300_FIELD_18]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_1A]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_1A+1]
    ld h, a
    call SetTileMap

    ld a, [wUnkC300+STRUCT_C300_FIELD_1C]
    ld [rROMB0], a
    ld a, [wUnkC300+STRUCT_C300_FIELD_1E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_1E+1]
    ld h, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    ld de, vTileAttrB
    call SetTileAttrs

    ld a, [wUnkC300+STRUCT_C300_FIELD_20]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_22]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_22+1]
    ld h, a

    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a

    ld de, vTileMapB
    call SetTileMap

    ld a, [wUnkC300+STRUCT_C300_FIELD_38+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_38]
    ld c, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_3A]
    ld hl, 0
    ld de, wUnkC580
    ld [wUnkC070], a

.lop_b:
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de

    add hl, bc

    ld a, [wUnkC070]
    dec a
    ld [wUnkC070], a
    jr nz, .lop_b

    call Func_0E39
    call Func_3C03
    call Func_1681
    call Func_09D4

    ld a, [CurrentBank]
    push af

    ; TODO: assert BANK(Func_02_508F) == BANK(Func_02_50B9)
    ld a, $02 ; TODO: BANK(Func_02_508F)
    ld [rROMB0], a
    call Func_02_508F
    call Func_02_50B9

    pop af
    ld [rROMB0], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ldh [rLCDC], a

    pop af
    ld [rROMB0], a

    ret

Func_06B7: ; 0006B7 (00:06B7)
    ld a, h
    or a, l
    ret z

    push bc
    push de
    push hl

    ; load vram addr
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ; load length
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a

    inc b
    inc c

    jr .beg

.lop:
    call WaitForScreenBlank

    ld a, [hli]
    ld [de], a
    inc de

    ld a, d
    cp HIGH(vTilesA2+$800)
    jr nz, .beg

    ld de, vTilesA1

.beg:
    dec c
    jr nz, .lop
    dec b
    jr nz, .lop

    pop hl
    pop de
    pop bc

    ret

ClearVRAM: ; 0006E1 (00:06E1)
    ld hl, _VRAM
    ld bc, $1800

.lop:
    call WaitForScreenBlank

    xor a, a
    ld [hli], a

    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    ret

ClearTileMaps: ; 0006F2 (00:06F2)
    ld a, 0
    ldh [rVBK], a

    ld hl, _SCRN0
    ld bc, $0800

.lop:
    call WaitForScreenBlank

    xor a, a
    ld [hli], a

    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    ret

Func_0707: ; 000707 (00:0707)
    ld a, [CurrentBank]
    push af

    call Func_0713

    pop af
    ld [rROMB0], a

    ret

Func_0713: ; 000713 (00:0713)
    ld a, [wUnkC173]
    cp a, 0
    ret z

    ld a, [wUnkC104]
    ld c, a
    ld a, [wUnkC175]
    cp a, c
    jr nz, .code_072D

    ld hl, wUnkC102
    ld a, [hl]
    ld b, a
    ld a, [wUnkC174]
    cp a, b
    ret z

.code_072D:
    ld a, c
    ld [wUnkC175], a
    ld c, a
    ld b, 0

    ld a, [wUnkC102]
    ld [wUnkC174], a

    ld a, $26 ; TODO: BANK(Data_26_4400)
    ld [rROMB0], a

    ld hl, Data_26_4400
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    push af
    ld a, [hli] ; discard hi byte of bank
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop af
    ld [rROMB0], a

    push hl

    ld hl, wUnkC102
    ld a, [hl]
    ld c, a
    ld b, 0

    pop hl

    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld [wUnkC17B], a
    push af
    ld a, [hli] ; discard hi byte of bank
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c
    pop af
    ld [rROMB0], a

    push hl

    ld de, 6 ; TODO: some offset within some struct?
    add hl, de
    ld a, [hli]
    ld [wUnkC17F], a
    ld a, [hli]
    ld [wUnkC180], a
    ld a, [hli]
    ld [wUnkC181], a

    pop hl

    ld de, 12 ; TODO: some offset within some struct?
    add hl, de
    ld a, [hli]
    ld [wUnkC188], a
    ld a, [hli]
    ld [wUnkC189], a
    ld a, [hli]
    ld [wUnkC18A], a
    ld a, [hli]
    ld [wUnkC18B], a
    ld a, l
    ld [wUnkC179], a
    ld a, h
    ld [wUnkC179+1], a

    ld a, 1 ; TODO: TRUE?
    ld [wUnkC178], a

    ld a, 0
    ld [wUnkC173], a

    ret

Func_07A7: ; 0007A7 (00:07A7)
    ld a, [wUnkC3A6]
    or a, a
    ret z

    cp a, $01
    jp nz, .code_081E

    ld a, [wUnkC8C6]
    ld [wUnkC3AA], a

    ld a, [wUnkC3AA]
    ld [wSprite0+sprite_id], a

    ld a, [wUnkC957]
    ld e, a
    cp a, $64
    jr nc, .code_07E0

    ld a, [wUnkC036]
    cp a, e
    jr c, .code_07E0

    ld a, $03
    ld [wSprite0+sprite_10], a

    ld a, $00
    ld [wSprite0+sprite_28], a
    ld [wSprite0+sprite_28+1], a
    ld [wSprite0+sprite_31], a

    call WaitFrame

    jr .code_07FB

.code_07E0:
    ld a, $02
    ld [wSprite0+sprite_10], a

    ld a, $00
    ld [wSprite0+sprite_28], a
    ld [wSprite0+sprite_28+1], a
    ld [wSprite0+sprite_31], a

    call WaitFrame

    call Func_086E

    ld a, [wUnkC064]
    or a, a
    ret nz

.code_07FB:
    call Func_257A

    ld a, $00
    ld [wSprite0+sprite_28], a
    ld [wSprite0+sprite_28+1], a
    ld [wSprite0+sprite_31], a

    ld a, $00
    ld [wUnkC3A2], a
    ld [wUnkC3A3], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a
    ld a, $02
    ld [wUnkC3A6], a

    jr .end

.code_081E:
    cp $02
    jr nz, .end

    ld a, [wUnkC3A5]
    or a, a
    jr z, .end
    ld a, [wUnkC3AB]
    ld [wSprite0+sprite_10], a
    ld a, [wUnkC3AA]
    ld [wSprite0+sprite_id], a
    ld a, [wUnkC3A8]
    ld [wSprite0+sprite_28], a
    ld a, [wUnkC3A9]
    ld [wSprite0+sprite_28+1], a
    ld [wSprite0+sprite_31], a

    ld a, $00
    ld [wUnkC3A2], a
    ld [wUnkC3A3], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a
    ld [wUnkC3A6], a
    ld [wUnkC3A7], a

.end:
    ret

Func_0858: ; 000858 (00:0858)
    ld a, [CurrentBank]
    push af

    ld a, 0
    ld [wUnkC064], a

    ld a, $01 ; TODO: BANK(Func_01_7E4F)
    ld [rROMB0], a
    call Func_01_7E4F

    pop af
    ld [rROMB0], a

    ret

Func_086E: ; 00086E (00:086E)
    ld a, [CurrentBank]
    push af

    ld a, 0
    ld [wUnkC064], a

    ld a, $01 ; TODO: BANK(Func_01_7F15)
    ld [rROMB0], a
    call Func_01_7F15

    pop af
    ld [rROMB0], a

    ret

Func_0884: ; 000884 (00:0884)
    call WaitFrame
    call Func_1DFC

    di
    call Func_1B66
    ei

.lop:
    call WaitFrame
    call ReadKeyInput
    call Func_07A7
    call Func_1DFC
    call Func_3BF2

    di
    call Func_1B66
    ei

    call Func_08A8

    jr .lop

Func_08A8: ; 0008A8 (00:08A8)
    ld a, [wSprite0+sprite_enable]
    cp a, FALSE
    jr z, .code_08B6

    ld a, [wSprite0+sprite_10]
    cp a, $02
    jr nc, .code_08D1

.code_08B6:
    ld a, [wSprite1+sprite_enable]
    cp a, FALSE
    jr z, .code_08C4

    ld a, [wSprite1+sprite_10]
    cp a, $02
    jr nc, .code_08D1

.code_08C4:
    ld a, [wUnkC0CC]
    add a, $01
    ld [wUnkC0CC], a
    cp a, $64
    ret c

    ; return calling function
    pop af
    ret

.code_08D1:
    xor a, a
    ld [wUnkC0CC], a
    ret

Func_08D6: ; 0008D6 (00:08D6)
    ; main func?

    call WaitFrame
    call ReadKeyInput
    call Func_0150
    call Func_27BB
    call ClampCursorPosition
    call Func_1DFC
    call Func_3BD0

    di

    call Func_0707
    call Func_137E
    call Func_142F
    call Func_264F
    call Func_1B66

    ; TODO: assert BANK(Func_01_60F3) == BANK(Func_01_61BC)
    ld a, $01 ; TODO: BANK(Func_01_60F3)
    ld [rROMB0], a
    call Func_01_60F3
    call Func_01_61BC

    ei

    ld a, [wUnkC026]
    or a, a
    jr nz, .code_0917

    ld a, [wUnkC027]
    or a, a
    jp nz, Func_09BB

    jp Func_08D6

.code_0917:
    ld a, [wUnkC007]
    cp a, $13
    jr c, .code_0942
    ld a, $00
    ld [wUnkC350], a
    ld [wCameraY], a
    ld [wCameraY+1], a
    ld [wCameraX], a
    ld [wCameraX+1], a

    ld a, $79 ; TODO: BANK(Func_79_4000)
    ld [rROMB0], a
    call Func_79_4000

    ld a, $79 ; TODO: BANK(Func_79_466F)
    ld [rROMB0], a
    call Func_79_466F

    jp Func_02A6

.code_0942:
    xor a, a
    ld [wUnkC026], a

    ld a, $16
    ld [wUnkC104], a

    ld a, $01
    ld [wUnkC105], a

    xor a, a
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a

    ld a, $09
    call Func_2CC3

    ld a, $1B
    ld [wUnkC080], a
    ld [wUnkC081], a

    call Func_2D14
    call WaitFrame

    ld a, [CurrentBank]
    push af

    ; TODO: assert BANK(Func_02_508F) == BANK(Func_02_50B9)
    ld a, $02 ; TODO: BANK(Func_02_508F)
    ld [rROMB0], a
    call Func_02_508F
    call Func_02_50B9

    pop af
    ld [rROMB0], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ld [rLCDC], a

.lop:
    call WaitFrame
    call ReadKeyInput
    call Func_0150
    call Func_27BB
    call Func_1DFC
    call Func_0707
    call Func_264F
    call Func_1B66

    ld a, [wUnkC026]

    or a, a
    jr nz, .code_09A5
    jr .lop

.code_09A5:
    ld a, [wUnkC007]
    inc a
    ld [wUnkC007], a
    xor a, a
    ld [wUnkC026], a
    ld [wUnkC350], a
    ld a, $01
    ld [wUnkC014], a

    jp Func_03A3

Func_09BB: ; 0009BB (00:09BB)
    xor a, a
    ld [wUnkC350], a
    ld [wCameraY], a
    ld [wCameraY+1], a
    ld [wCameraX], a
    ld [wCameraX+1], a
    ld [wSCY], a
    ld [wSCX], a

    jp Func_037E

Func_09D4: ; 0009D4 (00:09D4)
    ld a, [wUnkC0D4]
    or a, a
    jr z, .code_09DF

    xor a, a
    ld [wUnkC0D4], a
    ret

.code_09DF:
    xor a, a
    ld [wUnkC027], a

    call Func_09F4

    xor a, a
    rept 12 ; TODO: constant?
    ld [hli], a
    endr

    ret

Func_09F4: ; 0009F4 (00:09F4)
    ld hl, wUnkD800
    ld b, 0
    ld a, [wUnkC007]
    ld c, a

    ; hl += bc*12
    rept 2
    sla c
    rl b
    endr
    add hl, bc
    sla c
    rl b
    add hl, bc

    ld a, [wUnkC2B1]
    ld c, a
    ld b, 0
    add hl, bc

    ret

Func_0A13: ; 000A13 (00:0A13)
    push hl
    push de
    push bc
    push af

    ld a, [wCameraY]
    ld c, a
    ld a, [wCameraY+1]
    ld b, a
    ld a, [wCameraX]
    ld e, a
    ld a, [wCameraX+1]
    ld d, a
    ld a, [wSCX]
    ld l, a
    ld a, [wSCY]
    ld h, a

    push bc
    push de
    push hl

    di

    xor a, a
    ld [wCameraY], a
    ld [wCameraY+1], a

    ld a, [wUnkC8C6]
    ld [wSprite0+sprite_id], a

    ld a, [wFrameCountLo]
    and a, $01
    ld e, a

    ld a, [wUnkC90F]
    cp a, 0
    jr z, .code_0A4F
    jr nz, .code_0A51

.code_0A4F:
    ld a, $05

.code_0A51:
    add a, e
    ld [wSprite0+sprite_10], a

    ld a, $60
    ld [wSprite0+sprite_y], a

    ld a, $B8
    ld [wSprite0+sprite_x], a

    ld a, $00
    ld [wSprite0+sprite_y+1], a
    ld [wSprite0+sprite_x+1], a
    ld [wSprite0+sprite_frame], a
    ld [wCameraX], a
    ld [wCameraX+1], a

    ld a, $01
    ld [wSprite0+sprite_flip], a

    ld a, $0E ; TODO: tile number
    ld [wSprite0+sprite_tile], a

    ld a, LOW(vTilesA+$100)
    ld [wSprite0+sprite_2D], a

    ld a, HIGH(vTilesA+$100)
    ld [wSprite0+sprite_2D+1], a

    ld a, 2
    ld [wSprite0+sprite_palette], a
    ld [wUnkC06D], a

    ld a, [wUnkC8C5]
    ld [wUnkC06B], a

    ld a, [wUnkC8C6]
    ld [wUnkC06C], a

    call Func_3F72

    ld a, [wUnkC916]
    ld [wSprite1+sprite_id], a

    ld a, $01
    ld [wSprite1+sprite_10], a

    ld a, $60
    ld [wSprite1+sprite_y], a

    ld a, $28
    ld [wSprite1+sprite_x], a

    ld a, $00
    ld [wSprite1+sprite_y+1], a
    ld [wSprite1+sprite_x+1], a
    ld [wSprite1+sprite_frame], a

    ld a, $00
    ld [wSprite1+sprite_flip], a

    ld a, $0E ; BUG: discarded
    ld a, $3E
    ld [wSprite1+sprite_tile], a

    ld a, $00
    ld [wSprite1+sprite_2D], a

    ld a, $81 ; BUG: discarded
    ld a, $84
    ld [wSprite1+sprite_2D+1], a

    ld a, $0D
    ld [wSprite1+sprite_palette], a
    ld [wUnkC06D], a

    ld a, [wUnkC915]
    ld [wUnkC06B], a

    ld a, [wUnkC916]
    ld [wUnkC06C], a

    call Func_3F72

    ld a, 0
    ld [wSprite0+sprite_0A], a
    ld [wSprite0+sprite_28], a
    ld [wSprite0+sprite_28+1], a
    ld [wSprite0+sprite_31], a
    ld [wSprite1+sprite_0A], a
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a

    ld a, [wUnkC008]
    or a, a
    jr z, .code_0B1E

    ld a, $28
    ld [wSprite0+sprite_x], a

    ld a, $B8
    ld [wSprite1+sprite_x], a

    ld a, $00
    ld [wSprite0+sprite_flip], a

    ld a, $01
    ld [wSprite1+sprite_flip], a

.code_0B1E:
    ld a, TRUE
    ld [wSprite0+sprite_enable], a

    call WaitForVBlank

    ld a, TRUE
    ld [wSprite1+sprite_enable], a

    call WaitForVBlank

    ld a, LCDCF_ON | LCDCF_BG9C00 | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ld [rLCDC], a

    ei

    call Func_257A

    ld a, 1 ; TODO: STAT interrupt constants
    ld [wUnkC060], a

    ld a, $81 | STATF_LYC ; ?
    ldh [rSTAT], a

    ld a, $6F
    ldh [rLYC], a

    ld a, IEF_VBLANK | IEF_LCDC
    ldh [rIF], a
    ldh [rIE], a

    call Func_0884

    call WaitFrame
    call WaitFrame

    ld hl, sUnk0A900
    ld bc, $0900 ; TODO: size of sUnk0A900
    call MemClear

    ld a, IEF_VBLANK
    ldh [rIF], a
    ldh [rIE], a

    ld a, TRUE
    ld [wRefreshTileMapA], a

    ld a, TRUE
    ld [wRefreshBgPal], a
    ld [wRefreshObPal], a

    call WaitFrame

    ld a, 0
    ld [wSprite0+sprite_enable], a
    ld [wSprite1+sprite_enable], a

    pop hl
    pop de
    pop bc

    ld a, l
    ld [wSCX], a
    ld a, h
    ld [wSCY], a
    ld a, c
    ld [wCameraY], a
    ld a, b
    ld [wCameraY+1], a
    ld a, e
    ld [wCameraX], a
    ld a, d
    ld [wCameraX+1], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ld [rLCDC], a

    ld a, 0
    ld [wUnkC081], a
    ld [wUnkC080], a

    pop af
    pop bc
    pop de
    pop hl

    ret

Func_0BA7: ; 000BA7 (00:0BA7)
    ret

Func_0BA8: ; 000BA8 (00:0BA8)
    ret

Func_0BA9: ; 000BA9 (00:0BA9)
    ret

Data_0BAA:
    db $00, $00, $01, $01
    db $01, $01, $01, $01
    db $01, $01, $01, $01
    db $01

Data_0BB7:
    db $00, $04, $02, $00
    db $08, $03, $00, $01
    db $04, $00, $02, $05
    db $FF, $FF

Func_0BC5: ; 000BC5 (00:0BC5)
    ld a, [wUnkC105]
    ld c, a
    xor a, a
    ld b, a
    ld hl, Data_0BAA
    add hl, bc

    ld a, [hli]
    or a, a
    ret nz

    ld hl, Data_0BB7

.lop:
    ld a, [hli]
    cp a, $FF
    jr z, .end

    ld de, hHeldKeys
    add a, e
    ld e, a
    ld a, d
    adc a, 0
    ld d, a

    ld a, [de]
    ld d, a

    ld a, [hli]
    ld b, a

    ld a, [hli]
    ld c, a

    ld a, d
    and a, b
    cp a, b
    jr z, .break
    jr .lop

.break:
    ld a, [wUnkC105]
    cp a, c
    jp z, .end

    ld a, c
    ld [wUnkC105], a

    xor a, a
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a

.end:
    ret

SyncTileMapA: ; 000C06 (00:0C06)
    ld a, [wRefreshTileMapA]
    or a, a
    ret z

    ld a, BANK(vTileAttrs)
    ldh [rVBK], a

    ld a, 0
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a

    ld a, LOW(wTileAttrA)
    ldh [rHDMA2], a
    ld a, HIGH(wTileAttrA)
    ldh [rHDMA1], a
    ld a, LOW(vTileAttrA & $1FF0)
    ldh [rHDMA4], a
    ld a, HIGH(vTileAttrA & $1FF0)
    ldh [rHDMA3], a
    ld a, $40-1 | HDMA5F_MODE_GP
    ldh [rHDMA5], a

    ld a, BANK(vTileMaps)
    ldh [rVBK], a

    ld a, 0
    ld [rRAMB], a

    ld a, LOW(wTileMapA)
    ldh [rHDMA2], a
    ld a, HIGH(wTileMapA)
    ldh [rHDMA1], a
    ld a, LOW(vTileMapA & $1FF0)
    ldh [rHDMA4], a
    ld a, HIGH(vTileMapA & $1FF0)
    ldh [rHDMA3], a
    ld a, $40-1 | HDMA5F_MODE_GP
    ldh [rHDMA5], a

    ld a, 0
    ld [wRefreshTileMapA], a

    ld a, 0
    ld [rRAMB], a

    ; NOTE: this function assumes it is called from within OnVblank
    pop af ; discard return location
    ld hl, OnVBlank.endpop
    push hl
    ret

Func_0C5A: ; 000C5A (00:0C5A)
    ret

Func_0C5B: ; 000C5B (00:0C5B)
    ld b, 8 ; TODO: size of wUnkC2D0
    ld hl, wUnkC2D0
    xor a, a

.lop:
    ld [hli], a
    dec b
    jr nz, .lop

    ld a, 0
    ld [wUnkC116], a

    ret

ClearOam: ; 000C6B (00:0C6B)
    ld hl, _OAMRAM
    ld c, $A0

.lop:
    call WaitForScreenBlank

    xor a, a
    ld [hli], a

    dec c
    jr nz, .lop

    ret

ClearOamBuf: ; 000C79 (00:0C79)
    ld hl, wOam
    ld c, $A0

.lop:
    xor a, a
    ld [hli], a

    dec c
    jr nz, .lop

    ret

Func_0C84: ; 000C84 (00:0C84)
    push de
    pop hl

    ld a, [wOamCount]
    add a, a
    add a, a
    ld b, a

    ld a, 4*(20-1)
    sub a, b

    ret z
    ret c

    ld c, a
    jr Func_0C94.lop

Func_0C94:
    ld a, [wOamCount]
    add a, a
    add a, a
    ld c, a
    ld b, 0

    ld hl, wOam
    add hl, bc

    ld a, (4*40)-1
    sub a, c

    ret z
    ret c

    ld c, a
    jp .lop

.lop:
    xor a, a
    ld [hli], a
    dec c
    jr nz, .lop

    ret

ClearSprites: ; 000CAF (00:0CAF)
    ld hl, wSprites
    ld bc, 8*sprite_sizeof

.lop:
    xor a, a
    ld [hli], a
    dec bc
    ld a, c
    or a, b
    jr nz, .lop

    xor a, a
    ld hl, wUnkC174
    ld [hli], a
    ld [hli], a
    ld [hli], a

    ret

ClearTileAttrs: ; 000CC4 (00:0CC4)
    ld a, [hCgbMark]
    cp a, $11
    ret nz

    di

    ld a, BANK(vTileAttrs)
    ldh [rVBK], a

    ld hl, vTileAttrs
    ld bc, $800

.lop:
    call WaitForScreenBlank

    xor a, a
    ld [hli], a

    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    xor a, a
    ldh [rVBK], a

    ei

    ret

OnVBlank: ; 000CE4 (00:0CE4)
    di ; unnecessary

    push af
    push bc
    push de
    push hl

    ld a, [rLY]
    cp a, 144
    jr nc, .vblank

    nop
    jp .end

.vblank:
    ld a, [wFrameCountLo]
    add a, 1
    ld [wFrameCountLo], a
    ld a, [wFrameCountHi]
    adc a, 0
    ld [wFrameCountHi], a
    ld [wUnkC037], a

    ld a, [wUnkC062]
    or a, a
    jp nz, .end

    ld a, [wRefreshScroll]
    or a, a
    jr z, .no_refresh_scroll

    ld a, [wSCY]
    ldh [rSCY], a
    ld a, [wSCX]
    ldh [rSCX], a
    ld a, [wWY]
    ldh [rWY], a
    ld a, [wWX]
    ldh [rWX], a

.no_refresh_scroll:
    ld a, [CurrentBank]
    push af
    ldh a, [rVBK]
    push af
    ld a, [wCompareResult]
    push af

    call SyncTileMapA
    call Func_0E1F
    call Func_0DF2
    call Func_258B

    ld a, [wRefreshOam]
    or a, a
    jr z, .no_refresh_oam

    ld a, HIGH(wOam)
    ld b, a
    call hOamDmaFunc

    xor a, a
    ld [wRefreshOam], a

.no_refresh_oam:
    call SyncObPal
    call SyncBgPal
    call Func_2B82

    ld a, [wUnkC490]
    or a, a
    jr z, .code_0D66

    ld a, $13 ; TODO: BANK(Func_13_422E)
    ld [rROMB0], a
    call Func_13_422E

.code_0D66:
    call Func_2CE8
    call Func_0E83

.endpop:
    pop af
    ld [wCompareResult], a
    pop af
    ldh [rVBK], a
    pop af
    ld [rROMB0], a

.end:
    pop hl
    pop de
    pop bc
    pop af

    ei ; unnecessary

    reti

OnStat: ; 000D7D (00:0D7D)
    di ; unnecessary

    push af
    push bc
    push de
    push hl

    ld a, [wUnkC060]

    cp a, 1 ; TODO: STAT interrupt constants
    jr z, .code_0D93
    cp a, 2 ; TODO: STAT interrupt constants
    jr z, .code_0DA1

.end:
    pop hl
    pop de
    pop bc
    pop af

    ei ; unnecessary

    reti

.code_0D93:
    ldh a, [rLY]
    cp a, 111 ; TODO: scanline constants
    jr z, .scroll_zero
    jr .end

.scroll_zero:
    ld a, 0
    ldh [rSCX], a
    jr .end

.code_0DA1:
    ldh a, [rLY]
    ld c, a

    cp a, 8 ; TODO: scanline constants
    jr c, .end

    cp a, 82 ; TODO: scanline constants
    jr c, .code_0DC2

    ld a, 8 ; TODO: scanline constants
    ldh [rLYC], a

    ld a, [wUnkC061]
    inc a
    ld [wUnkC061], a

    cp a, 95
    jr c, .end
    ld a, $00
    ld [wUnkC061], a
    jr .end

.code_0DC2:
    inc a
    ldh [rLYC], a

    ld b, 0
    ld a, [wUnkC061]
    ld e, a
    ld a, c
    add a, e
    ld c, a

    ld hl, Data_16_5154
    add hl, bc
    add hl, bc

    ld a, [CurrentBank]
    push af

    ld a, $16 ; TODO: BANK(Data_16_5154)
    ld [rROMB0], a

    ld a, $18 | BCPSF_AUTOINC
    ldh [rBCPS], a

    call WaitForScreenBlank

    ld a, [hli]
    ldh [rBCPD], a
    ld a, [hli]
    ldh [rBCPD], a

    pop af
    ld [rROMB0], a

    jr .end

OnTimer: ; 000DEF (00:0DEF)
    reti

OnSerial: ; 000DF0 (00:0DF0)
    reti

OnJoypad: ; 000DF1 (00:0DF1)
    reti

Func_0DF2: ; 000DF2 (00:0DF2)
    ld a, [wUnkC178]
    and a, a
    ret z

    ; BUG: this function doesn't restore previous ROM bank

    ld a, [wUnkC17B]
    ld [rROMB0], a

    ld a, [wUnkC179+1]
    ld h, a
    ld a, [wUnkC179]
    ld l, a

    ld de, _VRAM8000+$0020 ; TODO: VRAM variables

    ld a, [wUnkC17F]
    ld b, a
    ld a, [wUnkC180]
    ld c, a

    ld a, [wUnkC181]
    ld [wUnkC1A0], a

    call Func_2621

    ld a, 0
    ld [wUnkC178], a

    ret

Func_0E1F: ; 000E1F (00:0E1F)
    ld a, [wUnkC350]
    and a, a
    ret z

    ld a, [wUnkC351]
    add a, 1
    ld [wUnkC351], a

    cp a, 10
    ret c

    ld a, [wUnkC177]
    or a, a
    ret nz

    ld a, 0
    ld [wUnkC351], a

    ; fallthrough into Func_0E39?

Func_0E39:
    ld a, [CurrentBank]
    push af

    ld a, $3A ; TODO: BANK(Data_3A_4000)
    ld [rROMB0], a

    ld a, 0
    ld [rRAMB], a
    ldh [rVBK], a

    ld a, [wUnkC352]
    add a, $08
    and a, $18
    ld [wUnkC352], a

    ld c, a
    ld e, $4F

    ld a, [wUnkC007]
    cp a, $13
    jr nz, .code_0E65

    ld a, [wUnkC352]
    add a, $40
    ld c, a
    ld e, $53

.code_0E65:
    ld b, 0
    ld hl, Data_3A_4000
    add hl, bc
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli]
    ldh [rHDMA2], a
    ld a, [hli]
    ldh [rHDMA1], a
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli]
    ldh [rHDMA4], a
    ld a, [hli]
    ldh [rHDMA3], a
    ld a, e
    ldh [rHDMA5], a

    pop af
    ld [rROMB0], a

    ret

Func_0E83: ; 000E83 (00:0E83)
    ld a, [wUnkC037]
    and a, $3F
    ld b, a

    ld a, [wUnkC035]

    add a, 1
    add a, b

    cp a, 100
    jr c, .code_0E95

    sub a, 100

.code_0E95:
    ld [wUnkC035], a
    ret

Func_0E99: ; 000E99 (00:0E99)
    srl b
    rr c
    or a, a ; ?
    srl b
    rr c

    inc b
    inc c

    jr .beg

.lop:
    call WaitForScreenBlank

    rept 4
    ld a, [hli]
    ld [de], a
    inc de
    endr

.beg:
    dec c
    jr nz, .lop
    dec b
    jr nz, .lop

    ret

Func_0EBC: ; 000EBC (00:0EBC)
    inc b
    inc c

    jr .beg_a

.lop_a:
    call WaitForScreenBlank

    rept 3
    ld a, [hli]
    ld [de], a
    inc de
    endr

.beg_a:
    dec c
    jr nz, .lop_a
    dec b
    jr nz, .lop_a

    ld a, [wUnkC1A0]
    or a, a
    ret z

    call WaitForScreenBlank

    ld a, [wUnkC1A0]
    ld c, a

.code_0EDE:
    ld a, [hli]
    ld [de], a
    inc de

    dec c
    jr nz, .code_0EDE

    ret

Func_0EE5: ; 000EE5 (00:0EE5)
.lop:
    call WaitForScreenBlank

    ld a, [hli]
    ld [de], a
    inc de

    call Func_0EFB

    ld a, c
    sub a, 1
    ld c, a
    jr nz, .lop

    ld a, b
    sub a, 1
    ld b, a
    jr nc, .lop

    ret

Func_0EFB: ; 000EFB (00:0EFB)
    ld a, d
    cp a, HIGH($9800) ; TODO: VRAM variables
    jr nz, .code_0F08

    ld a, e
    cp a, 0
    ret nz

    ld de, $8800 ; TODO: VRAM variables
    ret

.code_0F08:
    ld a, d
    cp a, HIGH($9000)
    ret nz

    ld a, e
    cp a, 0
    ret nz

    ld a, 1
    ldh [rVBK], a

    ret

Func_0F15: ; 000F15 (00:0F15)
    ld a, [hCgbMark]
    cp a, $11
    ret nz

    push bc
    push de
    push hl

    ld a, 1
    ldh [rVBK], a

    jr SetTileMap.code_0F35

SetTileAttrs:
    ld a, [hCgbMark]
    cp a, $11
    ret nz

    ld a, 1
    ldh [rVBK], a

    ; fallthrough into SetTileMap

SetTileMap:
    push bc
    push de
    push hl

    ld a, h
    or a, l
    jr z, .end

.code_0F35:
    ld a, b
    ld [wUnkC070], a

.lop_blocks:
    ld a, [wUnkC070]
    ld b, a

    push de

.lop_bytes:
    call WaitForScreenBlank

    ld a, [hl]
    ld [de], a
    inc de
    inc hl

    dec b
    jr nz, .lop_bytes

    pop de

    ld a, LOW($20)
    add a, e
    ld e, a
    ld a, HIGH($20)
    adc a, d
    ld d, a

    dec c
    jr nz, .lop_blocks

.end:
    xor a, a
    ldh [rVBK], a

    pop hl
    pop de
    pop bc
    ret

ReadKeyInput: ; 000F5B (00:0F5B)
    push af
    push bc

    ld a, P1F_GET_DPAD
    ld [rP1], a

    ld a, [rP1]
    ld a, [rP1]
    cpl
    and a, $0F
    ld b, a

    ld a, P1F_GET_BTN
    ld [rP1], a
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    swap a
    cpl
    and a, $F0

    ; c = key state
    or a, b
    ld c, a

    ldh a, [hHeldKeys]
    xor a, c
    and a, c
    ldh [hNewKeys], a
    ld a, c
    ldh [hHeldKeys], a

    ld a, P1F_GET_NONE
    ld [rP1], a

    pop bc
    pop af

    ret

Func_0FA1: ; 000FA1 (00:0FA1)
    ld a, [CurrentBank]
    push af

    ld hl, sUnk0A900
    ld bc, $0900 ; TODO: size of sUnk0A900
    call MemClear

    ld a, $03 ; TODO: BANK(Func_03_539A)
    ld [rROMB0], a
    call Func_03_539A

    ld a, $01
    ld [wUnkC0D5], a

    call Func_0FD9.code_0FF7

    ld a, $00
    ld [wUnkC0D5], a

    pop af
    ld [rROMB0], a

    ret

Func_0FC8: ; 000FC8 (00:0FC8)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_4B79)
    ld [rROMB0], a
    call Func_03_4B79

    pop af
    ld [rROMB0], a

    ret

Func_0FD9: ; 000FD9 (00:0FD9)
    ld a, [CurrentBank]
    push af

    ld hl, sUnk0A900
    ld bc, $0900 ; TODO: size of sUnk0A900
    call MemClear

    ld a, $03 ; TODO: BANK(Func_03_543B)
    ld [rROMB0], a
    call Func_03_543B

    pop af
    ld [rROMB0], a

    ld a, [wUnkC008]
    or a, a
    ret nz

.code_0FF7:
    di
    ld a, [CurrentBank]
    push af

    ld a, $02
    ld [wUnkC05D], a

    ld a, [wCameraY]
    ld c, a
    ld a, [wCameraY+1]
    ld b, a
    ld a, [wCameraX]
    ld e, a
    ld a, [wCameraX+1]
    ld d, a

    push bc
    push de

    ld a, 0
    ld d, a

.code_1016:
    push de

    call Func_139C

    ld a, [wCameraY]
    add a, LOW($0010)
    ld [wCameraY], a
    ld a, [wCameraY+1]
    adc a, HIGH($0010)
    ld [wCameraY+1], a

    pop de

    inc d
    ld a, d
    cp a, $0F
    jp c, .code_1016

    pop de
    pop bc

    ld a, c
    ld [wCameraY], a
    ld a, b
    ld [wCameraY+1], a
    ld a, e
    ld [wCameraX], a
    ld a, d
    ld [wCameraX+1], a

    ld a, 0
    ld [wUnkC05D], a

    pop af
    ld [rROMB0], a
    ei

    ret

Func_104F: ; 00104F (00:104F)
    ld a, [CurrentBank]
    push af

    ld a, $00
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a

    ld hl, sUnk0A900
    ld bc, $0900 ; TODO: size of sUnk0A900
    ld e, $0F ; mask
    ld d, $00 ; value
    call Func_0572

    ld hl, wUnkC780
    ld bc, $0080 ; TODO: size of wUnkC780
    call MemClear

    ld a, [wUnkC05A]
    inc a
    ld [wUnkC05A], a

    and a, $01
    jr z, .code_1088

    ld a, $03 ; TODO: BANK(Func_03_5626)
    ld [rROMB0], a
    call Func_03_5626

    jr .code_1090

.code_1088:
    ld a, $03 ; TODO: BANK(Func_03_56A3)
    ld [rROMB0], a
    call Func_03_56A3

.code_1090:
    ld a, $00
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a

    ld hl, sUnk0A900
    ld bc, $0900 ; TODO: size of sUnk0A900
    call MemClear

    call WaitFrame
    call WaitFrame

    ld a, $01
    ld [wRefreshTileMapA], a

    call WaitFrame
    call WaitFrame

    ld hl, wUnkC780
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli]
    ld [wUnkC0C2], a
    ld a, [hli]
    ld [wUnkC0C3], a
    ld a, [hli]
    ld [wUnkC0C4], a
    ld a, [hli]
    ld [wUnkC0C5], a

    ld hl, wUnkC780

.code_10CD:
    ld a, [hli]

    cp a, $FF
    jr z, .code_10DB

    rept 7
    ld a, [hli] ; discard
    endr

    jr .code_10CD

.code_10DB:
    ld a, [hld] ; discard
    ld a, [hld] ; discard

    push hl

    ld a, [hld] ; discard

    ld a, [hld]
    ld [wUnkC0CA], a
    ld a, [hld]
    ld [wUnkC0C9], a
    ld a, [hld]
    ld [wUnkC0C8], a
    ld a, [hld]
    ld [wUnkC0C7], a

    call Func_3C40

    pop hl

    ld a, $FF
    ld [wUnkC780], a

    ld a, [wUnkC105]
    push af

    ld a, $00
    ld [wUnkC105], a
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a

.code_110A:
    ld a, [hld]
    ld [wSprite2+sprite_10], a
    ld a, [hld]
    ld [wSprite2+sprite_x+1], a
    ld a, [hld]
    ld [wSprite2+sprite_x], a
    ld a, [hld]
    ld [wSprite2+sprite_y+1], a
    ld a, [hld]
    ld [wSprite2+sprite_y], a

    ld a, [hld] ; discard
    ld a, [hld] ; discard

    ld a, [hld]
    cp a, $FF
    jp z, .finish

    ld a, [wSprite2+sprite_y]
    add a, LOW($0010)
    ld [wSprite2+sprite_y], a
    ld a, [wSprite2+sprite_y+1]
    adc a, HIGH($0010)
    ld [wSprite2+sprite_y+1], a

    ld a, [wUnkC8C6]
    add a, $77
    ld [wSprite2+sprite_id], a
    ld a, [wUnkC008]
    or a, a
    jr z, .code_114C
    ld a, [wUnkC916]
    add a, $77
    ld [wSprite2+sprite_id], a

.code_114C:
    ld a, $0E
    ld [wSprite2+sprite_tile], a
    ld a, $00
    ld [wSprite2+sprite_flip], a
    ld a, $00
    ld [wSprite2+sprite_2D], a
    ld a, $81
    ld [wSprite2+sprite_2D+1], a

    ld b, $00

    ld a, [wUnkC008]
    or a, a
    jr z, .code_116A

    ld b, $01

.code_116A:
    ld a, b
    ld [wSprite2+sprite_palette], a

    ld a, $00
    ld [wSprite2+sprite_0A], a
    ld [wSprite2+sprite_28], a
    ld [wSprite2+sprite_28+1], a
    ld [wSprite2+sprite_31], a

    ld a, 1
    ld [wSprite2+sprite_enable], a

    ld a, [wUnkC104]
    push af

    xor a, a
    ld [wUnkC104], a

    push hl

.lop:
    call WaitFrame
    call ReadKeyInput
    call Func_27BB
    call ClampCursorPosition
    call Func_1DFC
    call Func_3BD0

    di
    call Func_137E
    call Func_142F
    call Func_264F
    call Func_1B66
    ei

    ld a, [wSprite2+sprite_enable]
    or a, a
    jr nz, .lop

    pop hl

    pop af
    ld [wUnkC104], a

    jp .code_110A

.finish:
    pop af
    ld [wUnkC105], a

    ld a, $00
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a

    call WaitFrame
    call Func_3C2F

    ld a, $00
    ld [rRAMB], a

    pop af
    ld [rROMB0], a

    ret

Func_11D7: ; 0011D7 (00:11D7)
    ldh a, [hHeldKeys]
    and a, KEY_DPAD_ANY
    or a, a
    ret z

    push bc
    push de
    push hl

    ld bc, 0

    ldh a, [hHeldKeys]

    bit KEY_BIT_DPAD_RIGHT, a
    ld bc, +4
    jr nz, .code_11F5

    bit KEY_BIT_DPAD_LEFT, a
    ld bc, -4
    jr nz, .code_11F5

    jr .code_11FB

.code_11F5:
    ld de, wCameraX
    call WordSumPtr

.code_11FB:
    ld bc, 0

    ldh a, [hHeldKeys]

    bit KEY_BIT_DPAD_UP, a
    ld bc, -4
    jr nz, .code_1210

    bit KEY_BIT_DPAD_DOWN, a
    ld bc, +4
    jr nz, .code_1210

    jr .code_1216

.code_1210:
    ld de, wCameraY
    call WordSumPtr

.code_1216:
    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_36]
    ld c, a

    ld a, [wCameraY+1]
    cp a, HIGH($8000)
    jr nc, .code_123C

    cp a, b
    jr c, .code_1245
    jr nz, .code_1232

    ld a, [wCameraY]
    cp a, c
    jr nc, .code_1232

    jr .code_1245

.code_1232:
    ld a, b
    ld [wCameraY+1], a
    ld a, c
    ld [wCameraY], a

    jr .code_1245

.code_123C:
    xor a, a
    ld [wCameraY+1], a
    ld [wCameraY], a

    jr .code_1245

.code_1245:
    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_34]
    ld c, a

    ld a, [wCameraX+1]
    cp a, HIGH($8000)
    jr nc, .code_126B

    cp a, b
    jr c, .end
    jr nz, .code_1261
    ld a, [wCameraX]
    cp a, c
    jr nc, .code_1261

    jr .end

.code_1261:
    ld a, b
    ld [wCameraX+1], a
    ld a, c
    ld [wCameraX], a

    jr .end

.code_126B:
    xor a, a
    ld [wCameraX+1], a
    ld [wCameraX], a

.end:
    pop hl
    pop de
    pop bc

    ret

ClampCursorPosition: ; 001276 (00:1276)
    ld a, [wUnkC300+STRUCT_C300_FIELD_36]
    add a, LOW($80)
    ld c, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    adc a, HIGH($80)
    ld b, a

    ld a, [wCursorY+1]
    cp a, HIGH($8000)
    jr nc, .y_min

    cp a, b
    jr c, .check_x
    jr nz, .y_max

    ld a, [wCursorY]
    cp a, c
    jr nc, .y_max

    jr .check_x

.y_max:
    ld a, b
    ld [wCursorY+1], a
    ld a, c
    ld [wCursorY], a

    jr .check_x

.y_min:
    xor a, a
    ld [wCursorY+1], a
    ld [wCursorY], a

.check_x:
    ld a, [wUnkC300+STRUCT_C300_FIELD_34]
    add a, LOW($90)
    ld c, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    adc a, HIGH($90)
    ld b, a

    ld a, [wCursorX+1]
    cp a, HIGH($8000)
    jr nc, .x_min
    cp a, b
    jr c, .end
    jr nz, .x_max
    ld a, [wCursorX]
    cp a, c
    jr nc, .x_max
    jr .end

.x_max:
    ld a, b
    ld [wCursorX+1], a
    ld a, c
    ld [wCursorX], a

    jr .end

.x_min:
    xor a, a
    ld [wCursorX+1], a
    ld [wCursorX], a

.end:
    ret

Func_12D9: ; 0012D9 (00:12D9)
    ldh a, [hHeldKeys]
    and a, KEY_DPAD_ANY
    or a, a
    ret z

    push bc
    push de
    push hl

    ld bc, 0

    ldh a, [hHeldKeys]

    bit KEY_BIT_DPAD_RIGHT, a
    ld bc, +4
    jr nz, .code_12F7

    bit KEY_BIT_DPAD_LEFT, a
    ld bc, -4
    jr nz, .code_12F7

    jr .code_12FD

.code_12F7:
    ld de, wSprite0+sprite_x
    call WordSumPtr

.code_12FD:
    ld bc, 0

    ldh a, [hHeldKeys]

    bit KEY_BIT_DPAD_UP, a
    ld bc, -4
    jr nz, .code_1312

    bit KEY_BIT_DPAD_DOWN, a
    ld bc, +4
    jr nz, .code_1312

    jr .code_1318

.code_1312:
    ld de, wSprites+sprite_y
    call WordSumPtr

.code_1318:
    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    add a, $01
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_36]
    xor a, a ; ?
    ld c, a

    ld a, [wSprite0+sprite_y+1]
    cp a, $80
    jr nc, .code_1341
    cp a, b
    jr c, .code_134A
    jr nz, .code_1337
    ld a, [wSprite0+sprite_y]
    cp a, c
    jr nc, .code_1337
    jr .code_134A

.code_1337:
    ld a, b
    ld [wSprite0+sprite_y+1], a
    ld a, c
    ld [wSprite0+sprite_y], a
    jr .code_134A

.code_1341:
    xor a, a
    ld [wSprite0+sprite_y+1], a
    ld [wSprite0+sprite_y], a
    jr .code_134A

.code_134A:
    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    add a, $01
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_34]
    xor a, a ; ?
    ld c, a

    ld a, [wSprite0+sprite_x+1]
    cp a, $80
    jr nc, .code_1373
    cp a, b
    jr c, .code_137A
    jr nz, .code_1369
    ld a, [wSprite0+sprite_x]
    cp a, c
    jr nc, .code_1369
    jr .code_137A

.code_1369:
    ld a, b
    ld [wSprite0+sprite_x+1], a
    ld a, c
    ld [wSprite0+sprite_x], a
    jr .code_137A

.code_1373:
    xor a, a
    ld [wSprite0+sprite_x+1], a
    ld [wSprite0+sprite_x], a

.code_137A:
    pop hl
    pop de
    pop bc

    ret

Func_137E: ; 00137E (00:137E)
    ld a, [wUnkC385]
    ld b, a
    ld a, [wCameraY+1]
    cp a, b
    jr z, .code_138C

    jr c, Func_139C
    jr nc, Func_13A1

.code_138C:
    ld a, [wUnkC384]
    ld b, a
    ld a, [wCameraY]
    and a, $F0
    cp a, b
    ret z
    jr c, Func_139C
    jr nc, Func_13A1
    ret

Func_139C:
    ld hl, -16
    jr Func_13A1.code_13A6

Func_13A1:
    ld hl, 160
    jr .code_13A6

.code_13A6:
    ld a, [wCameraY]
    and a, $F0
    ld [wUnkC384], a

    ld a, [wCameraY+1]
    ld [wUnkC385], a

    ld a, [wCameraY]
    ld c, a
    ld a, [wCameraY+1]
    ld b, a
    ld a, [wCameraX]
    ld e, a
    ld a, [wCameraX+1]
    ld d, a
    push bc
    push de

    add hl, bc

    ld a, l
    ld [wCameraY], a
    ld a, h
    ld [wCameraY+1], a

    ld a, [wCameraX]
    sub a, LOW($0010)
    ld [wCameraX], a
    ld a, [wCameraX+1]
    sbc a, HIGH($0010)
    ld [wCameraX+1], a

    call WaitForScreenBlank
    call WaitForScreenBlank

    ld a, 0
    ld d, a

.lop:
    push de

    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    inc a
    ld d, a

    ld a, [wCameraX+1]
    cp a, d
    jr nc, .code_1405

    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    inc a
    ld d, a

    ld a, [wCameraY+1]
    cp a, d
    jr nc, .code_1405

    call Func_1781
    call Func_14E1

.code_1405:
    pop de

    ld a, [wCameraX]
    add a, LOW($0010)
    ld [wCameraX], a
    ld a, [wCameraX+1]
    adc a, HIGH($0010)
    ld [wCameraX+1], a

    inc d

    ld a, d
    cp a, 14
    jr c, .lop

    pop de
    pop bc
    ld a, c
    ld [wCameraY], a
    ld a, b
    ld [wCameraY+1], a
    ld a, e
    ld [wCameraX], a
    ld a, d
    ld [wCameraX+1], a

    ret

Func_142F: ; 00142F (00:142F)
    ld a, [wUnkC387]
    ld b, a

    ld a, [wCameraX+1]

    cp a, b
    jr z, .code_143D
    jr c, .code_144D
    jr nc, .code_1452

.code_143D:
    ld a, [wUnkC386]
    ld b, a

    ld a, [wCameraX]
    and a, $F0

    cp a, b
    ret z
    jr c, .code_144D
    jr nc, .code_1452

    ret

.code_144D:
    ld hl, -16
    jr .code_1457

.code_1452:
    ld hl, +176
    jr .code_1457

.code_1457:
    ld a, [wCameraX]
    and a, $F0
    ld [wUnkC386], a
    ld a, [wCameraX+1]
    ld [wUnkC387], a
    ld a, [wCameraY]
    ld c, a
    ld a, [wCameraY+1]
    ld b, a
    ld a, [wCameraX]
    ld e, a
    ld a, [wCameraX+1]
    ld d, a
    push bc
    push de
    add hl, de
    ld a, l
    ld [wCameraX], a
    ld a, h
    ld [wCameraX+1], a
    ld a, [wCameraY]
    sub a, $10
    ld [wCameraY], a
    ld a, [wCameraY+1]
    sbc a, $00
    ld [wCameraY+1], a
    call WaitForScreenBlank
    call WaitForScreenBlank
    ld a, $00
    ld d, a
.code_1499:
    push de
    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    inc a
    ld d, a
    ld a, [wCameraX+1]
    cp a, d
    jr nc, .code_14B6
    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    inc a
    ld d, a
    ld a, [wCameraY+1]
    cp a, d
    jr nc, .code_14B6
    call Func_1781
    call Func_14E1
.code_14B6:
    pop de
    ld a, [wCameraY]
    add a, $10
    ld [wCameraY], a
    ld a, [wCameraY+1]
    adc a, $00
    ld [wCameraY+1], a
    inc d
    ld a, d
    cp a, $0D
    jr c, .code_1499
    pop de
    pop bc
    ld a, c
    ld [wCameraY], a
    ld a, b
    ld [wCameraY+1], a
    ld a, e
    ld [wCameraX], a
    ld a, d
    ld [wCameraX+1], a
    ret

    db $FF ; ?

Func_14E1: ; 0014E1 (00:14E1)
    ld a, [CurrentBank]
    push af

    ld a, $00
    ld [rRAMB], a
    ld a, $0A
    ld [rRAMG], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_24]
    ld [wUnkC202], a
    ld [rROMB0], a

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    ld h, a

    ld a, [hl]
    ld [wUnkC207], a
    ld c, a
    inc hl
    ld a, [hl]
    and a, $03
    ld b, a

    ; bc = bc*8
    rept 3
    sla c
    rl b
    endr

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    and a, $3F
    ld h, a

    ; hl = hl/2
    srl h
    rr l

    ld a, $00
    ld [wUnkC270], a

    ld de, sUnk0A900
    add hl, de

    ld a, [hl]
    or a, a
    jr z, .code_1536

    ld a, $07
    ld [wUnkC270], a

.code_1536:
    ld de, sUnk0A000 - sUnk0A900
    add hl, de

    ld a, [hl]
    ld [wUnkC3B7], a

    or a, a
    jr z, .code_15BA

    ld [wUnkC3B9], a

    ld a, [wUnkC0D5]
    or a, a
    jr z, .code_1551

    ld a, [wUnkC3B9]
    cp a, $95
    jr nc, .code_1556

.code_1551:
    ld a, $00
    ld [wUnkC270], a

.code_1556:
    call Func_0000

    ld a, [wUnkC3B9]
    ld e, a

    ld a, [wUnkC3BA]
    or a, a
    jr z, .code_1567

    ld a, e
    add a, $20
    ld e, a

.code_1567:
    ld a, e
    and a, $3F
    ld c, a
    xor a, a
    ld b, a

    ; bc = bc*8
    rept 3
    sla c
    rl b
    endr

    ld a, [wUnkC300+STRUCT_C300_FIELD_28]
    ld e, a
    push de

    ld a, [wUnkC300+STRUCT_C300_FIELD_2A]
    ld e, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2A+1]
    ld d, a
    push de

    ld a, [wUnkC3B8]
    or a, a
    jr nz, .code_1592

    ld de, Data_02_42B0
    jr .code_1595

.code_1592:
    ld de, Data_02_44B0

.code_1595:
    ld a, e
    ld [wUnkC300+STRUCT_C300_FIELD_2A], a
    ld a, d
    ld [wUnkC300+STRUCT_C300_FIELD_2A+1], a

    ; TODO: assert BANK(Data_02_42B0) == BANK(Data_02_44B0)
    ld a, $02 ; TODO: BANK(Data_02_42B0)
    ld [wUnkC300+STRUCT_C300_FIELD_28], a

    call .code_15B6

    pop de

    ld a, e
    ld [wUnkC300+STRUCT_C300_FIELD_2A], a
    ld a, d
    ld [wUnkC300+STRUCT_C300_FIELD_2A+1], a

    pop de
    ld a, e
    ld [wUnkC300+STRUCT_C300_FIELD_28], a

    jp .code_1677

.code_15B6:
    ld a, [CurrentBank]
    push af

.code_15BA:
    ld a, [wUnkC300+STRUCT_C300_FIELD_28]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2A]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2A+1]
    ld h, a

    add hl, bc

    ld a, [wUnkC05D]
    and a, $01 ; TODO: bit constants for wUnkC05D
    jr nz, .code_1635

    push hl

    inc hl
    inc hl
    inc hl
    inc hl

    ld a, 1
    ldh [rVBK], a

    ld a, [wUnkC203]
    ld e, a
    ld c, a
    ld a, [wUnkC203+1]
    ld d, a
    add a, HIGH($3800)
    ld b, a

    call WaitForScreenBlank

    ld a, [hl]
    ld [bc], a

    push bc

    ld c, a
    ld a, [wUnkC270]
    ld b, a
    ld a, c
    or a, b
    ld [de], a

    pop bc

    inc bc
    inc de
    inc hl

    call WaitForScreenBlank

    ld a, [hl]
    ld [bc], a

    push bc

    ld c, a
    ld a, [wUnkC270]
    ld b, a
    ld a, c
    or a, b
    ld [de], a

    pop bc

    inc hl

    ld a, e
    add a, LOW($001F)
    ld e, a
    ld c, a
    ld a, d
    adc a, HIGH($001F)
    ld d, a
    add a, HIGH($3800)
    ld b, a

    call WaitForScreenBlank

    ld a, [hl]
    ld [bc], a

    push bc

    ld c, a
    ld a, [wUnkC270]
    ld b, a
    ld a, c
    or a, b
    ld [de], a

    pop bc

    inc bc
    inc de
    inc hl

    call WaitForScreenBlank

    ld a, [hl]
    ld [bc], a

    push bc

    ld c, a
    ld a, [wUnkC270]
    ld b, a
    ld a, c
    or a, b
    ld [de], a

    pop bc

    pop hl

.code_1635:
    ld a, 0
    ldh [rVBK], a

    ld a, [wUnkC05D]
    and a, $02 ; TODO: bit constants for wUnkC05D
    jr nz, .code_1677

    ld a, [wUnkC203]
    ld e, a
    ld c, a
    ld a, [wUnkC203+1]
    ld d, a
    add a, HIGH($3C00)
    ld b, a

    call WaitForScreenBlank

    ld a, [hl]
    ld [de], a
    ld [bc], a

    inc bc
    inc de
    inc hl

    call WaitForScreenBlank

    ld a, [hl]
    ld [de], a
    ld [bc], a

    inc hl

    ld a, e
    add a, LOW($001F)
    ld e, a
    ld c, a
    ld a, d
    adc a, HIGH($001F)
    ld d, a
    add a, HIGH($3C00)
    ld b, a

    call WaitForScreenBlank

    ld a, [hl]
    ld [de], a
    ld [bc], a

    inc bc
    inc de
    inc hl

    call WaitForScreenBlank

    ld a, [hl]
    ld [de], a
    ld [bc], a

.code_1677:
    ld a, $00
    ld [rRAMB], a

    pop af
    ld [rROMB0], a

    ret

Func_1681: ; 001681 (00:1681)
    ld a, [CurrentBank]
    push af

    ld hl, Data_02_46B0

    ld a, [wUnkC007]
    ld c, a
    ld b, 0

    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    push hl

    ld a, $02 ; TODO: BANK(Data_02_46B0)
    ld [rROMB0], a

    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a

    ld hl, -$10
    add hl, de

    ld a, l
    ld [wCameraX], a
    ld a, h
    ld [wCameraX+1], a

    ld hl, -$10
    add hl, bc

    ld a, l
    ld [wCameraY], a
    ld a, h
    ld [wCameraY+1], a

    ld a, [wCameraY]
    ld [wSCY], a
    ld a, [wCameraX]
    ld [wSCX], a

    ld a, TRUE
    ld [wRefreshScroll], a

    xor a, a
    ld [wUnkC384], a
    ld [wUnkC385], a
    ld [wUnkC386], a
    ld [wUnkC387], a

    ld a, 0
    ld d, a

.code_16DF:
    push de

    call Func_139C

    ld a, [wCameraY]
    add a, LOW($0010)
    ld [wCameraY], a
    ld a, [wCameraY+1]
    adc a, HIGH($0010)
    ld [wCameraY+1], a

    pop de

    inc d
    ld a, d
    cp a, $10
    jp c, .code_16DF

    pop hl

    ld a, $02 ; TODO: BANK(Data_02_46B0)
    ld [rROMB0], a

    ld a, [hli]
    ld [wCameraX], a
    ld a, [hli]
    ld [wCameraX+1], a
    ld a, [hli]
    ld [wCameraY], a
    ld a, [hli]
    ld [wCameraY+1], a
    ld a, [hli]
    ld [wCursorX], a
    ld a, [hli]
    ld [wCursorX+1], a
    ld a, [hli]
    ld [wCursorY], a
    ld a, [hli]
    ld [wCursorY+1], a
    ld a, [hli]
    ld [wUnkC16F], a

    xor a, a
    ld [wUnkC384], a
    ld [wUnkC385], a
    ld [wUnkC386], a
    ld [wUnkC387], a

    pop af
    ld [rROMB0], a

    ret

Func_1737: ; 001737 (00:1737)
    di

    ld a, [CurrentBank]
    push af

    ld a, [wCameraX]
    push af

    ld a, [wCameraX+1]
    push af

    ld a, [wCameraY]
    push af

    ld a, [wCameraY+1]
    push af

    ld a, $00
    ld d, a

.lop:
    push de

    call Func_139C

    ld a, [wCameraY]
    add a, LOW($0010)
    ld [wCameraY], a
    ld a, [wCameraY+1]
    adc a, HIGH($0010)
    ld [wCameraY+1], a

    pop de

    inc d
    ld a, d
    cp a, $10
    jp c, .lop

    pop af
    ld [wCameraY+1], a

    pop af
    ld [wCameraY], a

    pop af
    ld [wCameraX+1], a

    pop af
    ld [wCameraX], a

    pop af
    ld [rROMB0], a

    ei
    ret

Func_1781: ; 001781 (00:1781)
    ld a, [wCameraY]
    ld [wUnkC21C], a

    ld a, [wCameraY+1]
    ld [wUnkC21C+1], a

    ld a, [wCameraX]
    ld [wUnkC21E], a

    ld a, [wCameraX+1]
    ld [wUnkC21E+1], a

    ; fallthrough into Func_1799

Func_1799:
    ld a, [wUnkC300+STRUCT_C300_FIELD_36+1]
    inc a
    ld b, a

    ld a, [wUnkC21C+1]

    cp a, b
    jp nc, .code_17B4

    ld a, [wUnkC300+STRUCT_C300_FIELD_34+1]
    inc a
    ld b, a

    ld a, [wUnkC21E+1]

    cp a, b
    jp nc, .code_17B4

    jp .code_17C8

.code_17B4:
    xor a, a
    ld [wUnkC200], a
    ld [wUnkC200+1], a
    ld [wUnkC214], a
    ld [wUnkC215], a
    ld [wUnkC216], a
    ld [wUnkC217], a

    ret

.code_17C8:
    ld a, [wUnkC21C]
    ld c, a
    ld a, [wUnkC21C+1]
    ld b, a

    ; bc = bc*8
    rept 3
    srl b
    rr c
    endr

    ld a, c
    and a, LOW($01FE)
    ld c, a
    ld a, b
    and a, HIGH($01FE)
    ld b, a

    ld hl, wUnkC580
    add hl, bc

    ld a, [hl]
    ld d, a
    inc hl
    ld a, [hl]
    ld h, a
    ld l, d

    ld a, [wUnkC21E]
    ld c, a
    ld a, [wUnkC21E+1]
    ld b, a

    ; bc = bc/8
    rept 4
    srl b
    rr c
    endr 

    ; bc = bc*2
    sla c
    rl b

    add hl, bc

    ld a, [wUnkC300+STRUCT_C300_FIELD_26+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_26]
    ld c, a

    add hl, bc

    ld a, l
    ld [wUnkC200], a
    ld a, h
    ld [wUnkC200+1], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_24]
    ld [wUnkC202], a

    ld a, [wUnkC21C]
    ld c, a
    ld a, [wUnkC21C+1]
    ld b, a

    ; bc = bc*4
    rept 2
    sla c
    rl b
    endr

    ; hl = bc & $FFC0
    ld a, c
    and a, $C0
    ld l, a
    ld a, b
    ld h, a

    ld a, [wUnkC21E]
    ld c, a
    ld a, [wUnkC21E+1]
    ld b, a

    ; bc = bc/8
    rept 3
    srl b
    rr c
    endr

    ; bc &= $001E
    ld a, c
    and a, $1E
    ld c, a
    xor a, a
    ld b, a

    add hl, bc

    ld a, h
    and a, HIGH($03FF)
    add a, HIGH(_SCRN0)
    ld h, a

    ld a, l
    ld [wUnkC203], a
    ld a, h
    ld [wUnkC203+1], a

    ld a, [CurrentBank]
    push af

    ld a, [wUnkC202]
    ld [rROMB0], a

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    ld h, a

    ld a, [hl]
    ld [wUnkC214], a
    ld c, a

    inc hl

    ld a, [hl]
    and a, $03
    ld b, a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2C]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2E+1]
    ld h, a

    ; hl = hl + bc*4
    rept 4
    add hl, bc
    endr

    ld a, [hli] ; discard

    ld a, [hli]
    ld [wUnkC216], a
    ld a, [hli]
    ld [wUnkC217], a

    pop af
    ld [rROMB0], a

    ret

Func_189D: ; 00189D (00:189D)
    ld a, [wUnkC21C]
    ld c, a
    ld a, [wUnkC21C+1]
    ld b, a

    ; bc = bc*8
    rept 3
    srl b
    rr c
    endr

    ; bc = bc & $01FE
    ld a, c
    and a, LOW($01FE)
    ld c, a
    ld a, b
    and a, HIGH($01FE)
    ld b, a

    ld hl, wUnkC580
    add hl, bc

    ld a, [hl]
    ld d, a
    inc hl
    ld a, [hl]
    ld h, a
    ld l, d

    ld a, [wUnkC21E]
    ld c, a
    ld a, [$C21F]
    ld b, a

    ; bc = bc/16
    rept 4
    srl b
    rr c
    endr

    ; bc = bc*2
    sla c
    rl b

    add hl, bc

    ld a, [wUnkC300+STRUCT_C300_FIELD_26+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_26]
    ld c, a

    add hl, bc

    ld a, l
    ld [wUnkC200], a
    ld a, h
    ld [wUnkC200+1], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_24]
    ld [wUnkC202], a

    ld a, [wUnkC21C]
    ld c, a
    ld a, [wUnkC21C+1]
    ld b, a

    ; bc = bc*4
    rept 2
    sla c
    rl b
    endr

    ; hl = bc & $FFC0
    ld a, c
    and a, $C0
    ld l, a
    ld a, b
    ld h, a

    ld a, [wUnkC21E]
    ld c, a
    ld a, [wUnkC21E+1]
    ld b, a

    ; bc = bc*8
    rept 3
    srl b
    rr c
    endr

    ; bc &= $001E
    ld a, c
    and a, $1E
    ld c, a
    xor a, a
    ld b, a

    add hl, bc

    ld a, h
    and a, HIGH($0300)
    add a, HIGH(_SCRN0)
    ld h, a

    ld a, l
    ld [wUnkC203], a
    ld a, h
    ld [wUnkC203+1], a

    ret

Func_1937: ; 001937 (00:1937)
    ld a, [wUnkC210+1]
    ld b, a
    ld a, [wUnkC212+1]
    or a, b
    and a, $80
    jr nz, .code_19B5

    ld a, [wUnkC210]
    ld c, a
    ld a, [wUnkC210+1]
    ld b, a

    ; bc = bc/16
    rept 4
    srl b
    rr c
    endr

    ; bc = bc*2
    sla c
    rl b

    ; bc &= $01FF
    ld a, b
    and a, $01
    ld b, a

    ld hl, wUnkC580
    add hl, bc

    ld a, [hl]
    ld d, a
    inc hl
    ld a, [hl]
    ld h, a
    ld l, d

    ld a, [wUnkC212]
    ld c, a
    ld a, [wUnkC212+1]
    ld b, a

    ; bc = bc/16
    rept 4
    srl b
    rr c
    endr

    ; bc = bc*2
    sla c
    rl b

    add hl, bc

    ld a, [wUnkC300+STRUCT_C300_FIELD_26+1]
    ld b, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_26]
    ld c, a

    add hl, bc

    ld a, l
    ld [wUnkC200], a
    ld a, h
    ld [wUnkC200+1], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_24]
    ld [wUnkC202], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_3C]
    ld c, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_3C+1]
    add a, $40
    ld b, a

    call WordCompare

    ld a, [wCompareResult]
    cp a, COMPARE_LESSER
    jr nz, .code_19C7

.code_19B5:
    xor a, a
    ld [wUnkC214], a
    ld [wUnkC215], a
    ld [wUnkC216], a
    ld [wUnkC217], a
    ld [wUnkC218], a

    jr .end

.code_19C7:
    ld a, [CurrentBank]
    push af

    ld a, [wUnkC202]
    ld [rROMB0], a

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    ld h, a

    ld a, [hl]
    ld [wUnkC214], a
    ld c, a
    inc hl
    ld a, [hl]
    and a, $03
    ld b, a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2C]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2E+1]
    ld h, a

    ; hl = hl + bc*4
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld [wUnkC215], a
    ld a, [hli]
    ld [wUnkC216], a
    ld a, [hli]
    ld [wUnkC217], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_30]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_32]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_32+1]
    ld h, a

    ld a, [wUnkC215]
    ld c, a
    ld b, 0

    ; bc = bc*16
    rept 4
    sla c
    rl b
    endr

    add hl, bc

    ld a, [wUnkC212]
    and a, $0F
    ld c, a
    ld b, 0

    add hl, bc

    ld a, [hl]
    ld [wUnkC218], a

    pop af
    ld [rROMB0], a

.end:
    ret

Func_1A38: ; 001A38 (00:1A38)
    ld a, [CurrentBank]
    push af

    ld a, [wCursorY]
    ld [wUnkC21C], a
    ld a, [wCursorY+1]
    ld [wUnkC21C+1], a

    ld a, [wCursorX]
    ld [wUnkC21E], a
    ld a, [wCursorX+1]
    ld [wUnkC21E+1], a

    call Func_1799

    ld a, [wUnkC200]
    ld l, a
    ld a, [wUnkC200+1]
    ld h, a

    ; hl &= $3FFF
    ld a, h
    and a, $3F
    ld h, a

    ; hl = hl/2
    srl h
    rr l

    push hl

    ld de, sUnk0A000
    add hl, de

    ld a, [hl]
    ld [wUnkC21A], a

    pop hl

    ld de, sUnk0A900
    add hl, de

    ld a, [hl]
    ld [wUnkC219], a

    pop af
    ld [rROMB0], a

    ret

Func_1A7E: ; 001A7E (00:1A7E)
    ld a, [CurrentBank]
    push af

    ld a, [wUnkC202]
    ld [rROMB0], a

    ld a, [wUnkC055]
    ld l, a
    ld a, [wUnkC055+1]
    ld h, a

    ld a, [hl]
    ld [wUnkC214], a
    ld c, a
    inc hl
    ld a, [hl]
    and a, $03
    ld b, a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2C]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2E+1]
    ld h, a

    ; hl += bc*4
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli]
    ld e, a
    ld d, 0

    ld a, [wUnkC008]
    or a, a
    jr nz, .code_1ABD

    ld a, [wUnkC8C6]
    jr .code_1AC0

.code_1ABD:
    ld a, [wUnkC916]

.code_1AC0:
    and a, $1F
    ld c, a
    ld b, 0

    push bc

    ; bc = bc*32
    rept 5
    sla c
    rl b
    endr

    ld hl, Data_03_4000
    add hl, bc

    pop bc

    add hl, bc
    add hl, de

    ld a, $03 ; TODO: BANK(Data_03_4000)
    ld [rROMB0], a

    ld a, [hl]
    ld b, a
    ld a, [wUnkC058]
    sub a, b
    ld [wUnkC059], a

    pop af
    ld [rROMB0], a

    ret

Func_1AF4: ; 001AF4 (00:1AF4)
    ld a, [CurrentBank]
    push af

    ld a, [wUnkC202]
    ld [rROMB0], a

    ld a, [wUnkC055]
    ld l, a
    ld a, [wUnkC055+1]
    ld h, a

    ld a, [hl]
    ld [wUnkC214], a
    ld c, a
    inc hl
    ld a, [hl]
    and a, $03
    ld b, a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2C]
    ld [rROMB0], a

    ld a, [wUnkC300+STRUCT_C300_FIELD_2E]
    ld l, a
    ld a, [wUnkC300+STRUCT_C300_FIELD_2E+1]
    ld h, a

    ; hl += bc*4
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli]
    or a, a
    jr nz, .code_1B35

    ld a, [wUnkC058]
    sub a, $7F
    ld [wUnkC059], a

    pop af
    ld [rROMB0], a

    ret

.code_1B35:
    ld a, [wUnkC058]
    sub a, 1
    ld [wUnkC059], a

    pop af
    ld [rROMB0], a

    ret

Data_1B42: ; TODO
    dw $DB00
    dw $DB40
    dw $DB80
    dw $DBC0
    dw $DC00
    dw $DC40
    dw $DC80
    dw $DCC0
    dw 0

Data_1B54: ; TODO
    dw $DCC0
    dw $DC80
    dw $DC40
    dw $DC00
    dw $DBC0
    dw $DB80
    dw $DB40
    dw $DB00
    dw 0

Func_1B66: ; 001B66 (00:1B66)
    ld a, [CurrentBank]
    push af

    ld a, $08
    ld [wUnkC400], a

    xor a, a
    ld [wUnkC360], a

    ld a, [wUnkC36A]
    or a, a
    jr nz, .code_1B93

    ld a, [wCameraY]
    ld [wUnkC366], a
    ld a, [wCameraY+1]
    ld [wUnkC366+1], a
    ld a, [wCameraX]
    ld [wUnkC368], a
    ld a, [wCameraX+1]
    ld [wUnkC368+1], a

    jr .code_1BA1

.code_1B93:
    ld a, 0
    ld [wUnkC366], a
    ld [wUnkC366+1], a
    ld [wUnkC368], a
    ld [wUnkC368+1], a

.code_1BA1:
    ld hl, wOam

    ld a, [wOamCount]
    ld c, a
    ld a, 0
    ld b, a

    ; hl += bc*4
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, l
    ld [wOamIt], a
    ld a, h
    ld [wOamIt+1], a

    ld a, [wUnkC361]
    inc a
    and a, 1
    ld [wUnkC361], a

    or a, a
    jr z, .code_1BC8

    ld hl, Data_1B42
    jr .code_1BCB

.code_1BC8:
    ld hl, Data_1B54

.code_1BCB:
    ld a, l
    ld [wUnkC364], a
    ld a, h
    ld [wUnkC364+1], a

.lop:
    ld a, [wUnkC364]
    ld l, a
    ld a, [wUnkC364+1]
    ld h, a

    ld a, [wUnkC360]
    ld c, a
    ld b, 0

    ; hl += bc*2
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ; hl is face?

    ld a, [hl]
    or a, a
    jr z, .code_1C30

    ld bc, 5 ; TODO: offset contant?
    push hl
    add hl, bc
    ld a, [hli]
    pop hl

    or a, a
    jr z, .code_1C30

    ld c, sprite_sizeof

    push hl

    ld de, wUnkC700

.lop_load_face:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop_load_face

    push hl
    call Func_1C52
    pop hl

    pop de

    push hl

    ld hl, wUnkC700
    ld c, sprite_sizeof

.lop_save_face:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop_save_face

    pop hl
    ld c, $40 ; ?

    ld a, [wOamCount]
    cp a, 40
    jr nc, .end

    ld a, [wUnkC360]
    inc a
    ld [wUnkC360], a

    ld a, [wUnkC400]
    dec a
    ld [wUnkC400], a
    jr nz, .lop

    jr .end

.code_1C30:
    ld a, [wUnkC360]
    inc a
    ld [wUnkC360], a

    ld a, [wUnkC400]
    dec a
    ld [wUnkC400], a
    jr nz, .lop

.end:
    call Func_0C94

    ld a, 0
    ld [wOamCount], a

    pop af
    ld [rROMB0], a

    ld a, TRUE
    ld [wRefreshOam], a

    ret

Func_1C52: ; 001C52 (00:1C52)
    ld a, [CurrentBank]
    push af

    ld a, [wOamIt]
    ld e, a
    ld a, [wOamIt+1]
    ld d, a

    ld a, [wUnkC700+sprite_enable]
    or a, a
    jp z, .end

    push de

    ld hl, wUnkC700+sprite_y
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ld a, [wUnkC366+1]
    ld b, a
    ld a, [wUnkC366]
    ld c, a

    ; [wUnkC407] = hl - bc
    ld de, wUnkC407
    call WordDiff

    ld a, [wUnkC407]
    ld l, a
    ld a, [wUnkC407+1]
    ld h, a

    ld bc, -$20
    call WordCompareSigned

    ld a, [wCompareResult]

    cp a, COMPARE_GREATER
    jp z, .code_1C9A

    cp a, COMPARE_LESSER
    jp z, .code_1C9D

    jp .code_1CAE

.code_1C9A:
    jp .code_1DC5

.code_1C9D:
    ld bc, +$B0
    call WordCompareSigned

    ld a, [wCompareResult]

    cp a, COMPARE_GREATER
    jp z, .code_1CAE

    jp .code_1DC5

.code_1CAE:
    ld a, l
    ld [wUnkC401], a

    ld hl, wUnkC700+sprite_x
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ld a, [wUnkC368+1]
    ld b, a
    ld a, [wUnkC368]
    ld c, a

    ; [wUnkC407] = hl - bc
    ld de, wUnkC407
    call WordDiff

    ld a, [wUnkC407]
    ld l, a
    ld a, [wUnkC407+1]
    ld h, a

    ld bc, -$20
    call WordCompareSigned

    ld a, [wCompareResult]

    cp a, COMPARE_GREATER
    jr z, .code_1CE3

    cp a, COMPARE_LESSER
    jr z, .code_1CE6

    jr .code_1CF6

.code_1CE3:
    jp .code_1DC5

.code_1CE6:
    ld bc, +$C0
    call WordCompareSigned

    ld a, [wCompareResult]

    cp a, COMPARE_GREATER
    jr z, .code_1CF6

    jp .code_1DC5

.code_1CF6:
    ld a, l
    ld [wUnkC402], a

    ld hl, wUnkC700+sprite_1C

    ld a, [hl]
    or a, a
    jr z, .code_1D08

    dec a
    ld [hli], a

    bit 2, a
    jp z, .code_1DC5

.code_1D08:
    ld a, $06 ; TODO: BANK(?)
    ld [rROMB0], a

    pop de

    ld hl, wUnkC700+sprite_id
    ld a, [hli]
    ld c, a
    ld a, BANK(Data_26_4000)
    ld [rROMB0], a
    ld hl, Data_26_4000
    ld b, 0

    ; hl += bc*4
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    push de

    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ld a, [hli]
    ld [wUnkC08A], a

    ld a, [hli]
    ld [rROMB0], a

    ld h, d
    ld l, e

    pop de

    push hl

    ld hl, wUnkC700+sprite_frame
    ld a, [hli]
    ld c, a
    ld b, 0

    ld a, [hli] ; sprite_attributes ; discarded
    ld a, [hli] ; sprite_tile
    ld [wUnkC40B], a

    ld a, [hli] ; sprite_08 ; discarded
    ld a, [hli] ; sprite_palette
    ld [wUnkC40C], a

    pop hl

    ; hl += bc*2
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ld a, [hli]
    ld c, a
    ld a, [hli] ; discard

.lop_objects:
    push bc

    ; oam y
    ld a, [wUnkC401]
    ld b, a
    ld a, [hli]
    add a, b
    ld [de], a
    inc de

    ld a, [wUnkC402]
    ld b, a

    push hl
    push bc

    ld a, [wUnkC700+sprite_flip]
    or a, a
    jr z, .code_1D71

    pop bc
    pop hl

    ld a, [hli] ; discard

    ; oam x
    ld a, [wUnkC08A]
    add a, b
    ld b, a
    ld a, [hli]
    add a, b
    ld [de], a
    inc de

    jr .code_1D7D

.code_1D71:
    pop bc
    pop hl

    ; oam x
    ld a, [wUnkC08A]
    add a, b
    ld b, a
    ld a, [hli]
    add a, b
    ld [de], a
    inc de

    ld a, [hli] ; discard

.code_1D7D:
    ; oam tile
    ld a, [hli]
    ld b, a
    ld a, [wUnkC40B]
    add a, b
    ld [de], a
    inc de

    ld a, [hli]
    ld b, a

    push hl

    push bc ; useless
    ld hl, wUnkC700+sprite_attributes
    ld a, [hli]
    pop bc ; useless

    or a, b
    ld b, a
    ld a, [wUnkC40C]
    add a, b
    ld b, a

    push bc ; useless
    push de ; useless
    push hl ; useless

    ld a, [wUnkC700+sprite_flip]
    or a, a

    pop hl ; useless
    pop de ; useless
    pop bc ; useless

    jr nz, .flip

    ld a, b
    jr .end_flip

.flip:
    ld a, b

    bit 5, a
    jr z, .code_1DAD

    res 5, a
    jr .end_flip

.code_1DAD:
    set 5, a

.end_flip:
    ld [de], a
    inc de

    pop hl

    pop bc

    ld a, [wOamCount]
    inc a
    ld [wOamCount], a

    cp a, 40
    jp nc, .end

    dec c
    jp nz, .lop_objects
    jr .end

.code_1DC5:
    pop de
    jr .end

    ; unreachable?
    ld a, [wUnkC700+sprite_32]
    bit 7, a
    jr nz, .code_1DEE

    ld hl, wUnkC700
    xor a, a
    ld [hli], a ; 
    ld hl, wUnkC700+sprite_28
    ld [hli], a
    ld [hli], a

    ld a, [wUnkC700+sprite_10]
    cp a, $07
    jr z, .code_1DEE

    ld a, [wUnkC700+sprite_11]
    ld [wUnkC077], a
    ld hl, wUnkC700+sprite_0B
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

.code_1DEE:
    pop de

.end:
    ld a, e
    ld [wOamIt], a
    ld a, d
    ld [wOamIt+1], a

    pop af
    ld [rROMB0], a

    ret

Func_1DFC: ; 001DFC (00:1DFC)
    ld a, [CurrentBank]
    push af

    xor a, a
    ld [wUnkC177], a
    ld [wUnkC400], a
    ld [wUnkC409], a
    ld [wUnkC409+1], a

.lop:
    ld a, $04 ; TODO: BANK(Data_04_4000)
    ld [rROMB0], a

    ld hl, wSprites
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    or a, a
    jp z, .code_202B

    ld hl, wSprites+sprite_0A
    add hl, bc

    ld a, [hl]
    or a, a
    jp nz, .code_2011

    ld hl, wSprites+sprite_28
    add hl, bc

    ld a, [hli]
    ld b, a
    ld a, [hli]
    or a, b
    jr nz, .code_1E94

    ld hl, wSprites+sprite_id
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld hl, Data_04_4000
    ld c, a
    ld b, 0

    ; hl += 4*bc
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hli]

    push hl
    push bc
    push af

    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    ld hl, wSprites+sprite_27
    add hl, bc

    pop af
    ld [hli], a
    ld [rROMB0], a

    pop bc
    pop hl

    ld h, b
    ld l, c

    push hl

    ld hl, wSprites+sprite_10
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld c, a
    ld b, 0

    pop hl

    ; hl += bc*2
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld d, a
    ld e, c

    ld hl, wSprites+sprite_28
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, e
    ld [hl], a
    inc hl
    ld a, d
    ld [hl], a

.code_1E94:
    ld hl, wSprites+sprite_27
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld [rROMB0], a

    ld hl, wSprites+sprite_28
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    push hl

    ld hl, wSprites+sprite_0D
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    push hl
    pop de

    pop hl

    ld a, [hli]
    ld b, a
    ld a, [hl]
    and a, b
    cp a, $FF
    jp z, .code_2016

    ld a, b
    ld [de], a
    inc de

    ld a, [hli]

    push hl
    push af

    ld hl, wSprites+sprite_flip
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    or a, a
    jr z, .code_1EE0

    pop af
    cpl
    inc a
    push af

.code_1EE0:
    pop af
    ld [de], a

    ld hl, wSprites+sprite_y
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    dec de
    ld a, [de]
    call Expand

    push de

    push hl
    pop de

    call WordSumPtr

    pop de
    inc de

    ld hl, wSprites+sprite_x
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [de]
    call Expand

    push hl
    pop de

    call WordSumPtr

    ld hl, wSprites+sprite_frame
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc
    push hl
    pop de

    pop hl

    ld a, [hli]
    ld [de], a

    rept 5
    inc de
    endr

    ld a, [hli]
    push af

    ldh a, [hCgbMark]
    cp a, $11
    jr z, .code_1F38

    ld a, [wUnkC022]
    or a, a
    jr z, .code_1F38

    pop af
    or a, a
    rra
    push af

.code_1F38:
    pop af
    ld [de], a

    push hl

    ld hl, wSprites+sprite_28
    add hl, bc
    push hl
    pop de

    pop hl

    push bc
    push de

    ld a, [hl]
    cp a, $80
    call nc, Func_204D

    pop de
    pop bc

    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a

    ld hl, wSprites+sprite_2D
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld d, a
    ld a, [hli]
    or a, d
    jp z, .code_1FF6

    ld a, $26 ; TODO: BANK(Data_26_4400)
    ld [rROMB0], a

    ld hl, wSprites+sprite_id
    add hl, bc
    ld a, [hli]
    ld e, a
    ld d, 0

    ; hl = Data_26_4400 + 4*de
    ld hl, Data_26_4400
    add hl, de
    add hl, de
    add hl, de
    add hl, de

    ld a, [hli]
    push af

    ld a, [hli] ; discard
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    pop af
    ld [rROMB0], a

    push de

    ld hl, wSprites+sprite_frame
    add hl, bc
    ld a, [hli]
    ld e, a
    ld d, 0

    pop hl

    ; hl = addr+4*de
    add hl, de
    add hl, de
    add hl, de
    add hl, de

    ld a, $01
    ld [wUnkC062], a

    push hl

    ld hl, wSprites+sprite_2A
    add hl, bc
    push hl
    pop de

    pop hl

    ld a, [hli]
    push af
    ld a, [hli] ; discard
    ld a, [hli]
    ld [de], a
    ld [wUnkC147], a
    inc de
    ld a, [hli]
    ld [de], a
    ld [wUnkC147+1], a

    inc de ; sprite_2C
    pop af
    ld [de], a
    ld [wUnkC149], a

    ld a, [wUnkC147]
    ld e, a
    ld a, [wUnkC147+1]
    or a, e
    jp z, .code_1FF6

    ld hl, wSprites+sprite_2F
    add hl, bc
    ld a, [hli]
    cp a, e
    jp nz, .code_1FDB

    ld a, [wUnkC147+1]
    ld e, a
    ld a, [hli] ; sprite_2F+1
    cp a, e
    jp nz, .code_1FDB

    ld a, [wUnkC149]
    ld e, a
    ld a, [hli] ; sprite_31
    cp a, e
    jp nz, .code_1FDB

    jp .code_1FF6

.code_1FDB:
    ld hl, wSprites+sprite_2F
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [wUnkC147]
    ld [hli], a
    ld a, [wUnkC147+1]
    ld [hli], a
    ld a, [wUnkC149]
    ld [hli], a

    jp .code_2004

.code_1FF6:
    ld hl, wSprites+sprite_2C
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    xor a, a
    ld [hli], a

.code_2004:
    ld a, $00
    ld [wUnkC062], a
    ld a, $01
    ld [wUnkC177], a

    jp .code_202B

.code_2011:
    dec a
    ld [hl], a

    jp .code_202B

.code_2016:
    ld hl, wSprites+sprite_enable
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    xor a, a
    ld [hli], a

    ld hl, wSprites+sprite_28
    add hl, bc

    xor a, a
    ld [hli], a
    ld [hli], a

.code_202B:
    ld a, [wUnkC409]
    ld l, a
    ld a, [wUnkC409+1]
    ld h, a

    ld bc, sprite_sizeof
    ld de, wUnkC409
    call WordSum

    ld a, [wUnkC400]
    inc a
    ld [wUnkC400], a
    cp a, 8 ; TODO: count wSprites
    jp c, .lop

    pop af
    ld [rROMB0], a

    ret

Func_204D:
    ld a, [hl]
    cp a, $91
    ret nc

    sub a, $80
    ld c, a
    ld b, 0

    ld a, [wUnkC01F]
    add a, c
    ld c, a

    push hl

    ld hl, .data_2067
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    jp hl

.data_2067:
    dw Func_2242
    dw Func_209D
    dw Func_20B3 ; flip!
    dw Func_20CB ; flip something sprite 0 and 1
    dw Func_2105
    dw Func_2132
    dw Func_2162
    dw Func_2239
    dw Func_2239
    dw Func_2242
    dw Func_2259
    dw Func_225E
    dw Func_232F
    dw Func_247F
    dw Func_250E
    dw Func_2519
    dw Func_2536
    dw Func_2557
    dw Func_2097
    dw Func_2097
    dw Func_2097
    dw Func_2097
    dw Func_2097
    dw Func_2097

Func_2097: ; 002097 (00:2097)
    pop hl

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ret

Func_209D: ; 00209D (00:209D)
    pop hl

    ld a, [hli]
    ld a, [hli]
    push af

    ld hl, wSprites+sprite_10
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    pop af
    ld [hli], a

    ld hl, 0

    ret

Func_20B3: ; 0020B3 (00:20B3)
    pop hl

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    push hl

    ld hl, wSprites+sprite_flip
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hl]
    xor a, 1 ; flip!
    ld [hl], a

    pop hl

    ret

Func_20CB: ; 0020CB (00:20CB)
    pop hl

    ld a, [hli]
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    push hl
    push bc

    ld a, [wSprite0+sprite_x]
    ld l, a
    ld a, [wSprite0+sprite_x+1]
    ld h, a

    ld a, [wSprite1+sprite_x]
    ld c, a
    ld a, [wSprite1+sprite_x+1]
    ld b, a

    call WordCompareSigned

    ld a, [wCompareResult]
    cp a, COMPARE_GREATER
    jr z, .code_20F8

    ld a, 1
    ld [wSprite0+sprite_flip], a
    ld a, 0
    ld [wSprite1+sprite_flip], a

    jr .code_2102

.code_20F8:
    ld a, 0
    ld [wSprite0+sprite_flip], a
    ld a, 1
    ld [wSprite1+sprite_flip], a

.code_2102:
    pop bc
    pop hl

    ret

Func_2105: ; 002105 (00:2105)
    pop hl

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    push hl
    push bc

    ld hl, wSprites
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, l
    ld [wUnkC3A0], a
    ld a, h
    ld [wUnkC3A0+1], a

    pop bc
    pop hl

    ret

Func_2123: ; 002123 (00:2123)
    ld hl, wObPalBuf
    ld de, wObPalBufB
    ld c, $40 ; TODO: size of wObPalBuf|wObPalBufB

.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop

    ret

Func_2132: ; 002132 (00:2132)
    call Func_2123

    ld hl, wObPalBufB+$10 ; TODO: offset within wObPalBuf|wObPalBufB

    ld a, [wUnkC409]
    or a, a
    jr z, .code_2141

    ld hl, wObPalBufB+$28 ; TODO: offset within wObPalBuf|wObPalBufB

.code_2141:
    ld a, $1F
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $1F
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $1F
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld a, $1F
    ld [hli], a
    ld a, $00
    ld [hli], a

    pop hl

    ld a, [hli]
    ld a, [hli]
    ld [wRefreshObPal], a
    ld a, [hli]
    ld a, [hli]

    ret

Func_2162: ; 002162 (00:2162)
    pop hl

    push de

    ld de, wUnkC0D7
    ld a, [hli] ; discard
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a

    push hl

    ld a, [wUnkC0D7+$0] ; TODO: offset within wUnkC0D7
    ld [wUnkC20C], a

    ld a, [wUnkC0D7+$1] ; TODO: offset within wUnkC0D7
    call Expand

    push bc

    ld hl, wSprites+sprite_y
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ; hl = y offset
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    pop bc

    ; [wUnkC208] = hl + bc
    ld de, wUnkC208
    call WordSum

    ld hl, wSprites+sprite_flip
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    cp a, TRUE
    jr z, .code_21B8

    ld a, [wUnkC0D7+$2] ; TODO: offset within wUnkC0D7

    jr .code_21BB

.code_21B8:
    ld a, [wUnkC0D7+$3] ; TODO: offset within wUnkC0D7

.code_21BB:
    call Expand

    push bc

    ld hl, wSprites+sprite_x
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ; hl = x offset
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    pop bc

    ld de, wUnkC20A
    call WordSum

    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a

    push bc

    ld b, HIGH($0040)
    ld c, LOW($0040)
    ld hl, $0040

    ld a, [wUnkC0D7+$4] ; TODO: offset within wUnkC0D7

.code_21EA:
    add hl, bc
    dec a
    jr nz, .code_21EA

    ld a, l
    ld c, a
    ld [wUnkC409], a
    ld a, h
    ld b, a
    ld [wUnkC409+1], a

    ld hl, wSprites+sprite_enable
    add hl, bc
    ld [hl], 0

    call Func_3C69
    ld hl, wSprites+sprite_flip
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    push hl
    pop de

    pop bc

    ld a, c
    ld [wUnkC409], a
    ld a, b
    ld [wUnkC409+1], a

    ld hl, wSprites+sprite_flip
    add hl, bc

    ld a, [hl]
    ld [de], a

    rept 2
    dec de
    endr

    ld a, [wUnkC0D7+$5] ; TODO: offset within wUnkC0D7
    ld [de], a

    rept sprite_flip-sprite_palette
    dec hl
    endr

    rept 7
    dec de
    endr

    ld a, [hl]
    ld [de], a

    pop hl
    pop de

    ret

Func_2239: ; 002239 (00:2239)
    pop hl

    ld a, [hli] ; discard

    ld a, [hli]
    call Func_2CC3

    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ret

Func_2242: ; 002242 (00:2242)
    pop hl

    ld a, [hli] ; discard

    ld a, [hli]
    ld [wSprite1+sprite_10], a

    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, 0
    ld [wSprite1+sprite_0A], a
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a

    ret

Func_2259: ; 002259 (00:2259)
    pop hl

    ; a is non zero here
    ld [wRefreshScroll], a

    ret

Func_225E: ; 00225E (00:225E)
    pop hl

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jp z, .code_2315

    ld a, [hli]
    ld [wUnkC1C0], a
    ld a, [hli]
    ld [wUnkC1C1], a

    push hl
    push de

    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO: BANK(Func_02_5099)
    ld [rROMB0], a
    call Func_02_5099

    pop af
    ld [rROMB0], a

    ld hl, sUnk0BDC0
    ld de, sUnk0BFC0

    ld a, [wUnkC1C1]
    add a, a
    add a, a
    ld c, a

.lop:
    push bc

    ld a, [wUnkC1C0]
    ld b, a

    ld a, [hli]
    push af

    and a, $1F
    sub a, b
    call c, .zero
    ld c, a

    pop af
    and a, $E0

    ; shift right 5 times but dumb
    rept 5
    or a, a ; clear c flag?
    rrca    ; (a = a rshift 1), set c to discarded bit
    endr

    ld b, a

    ld a, [hli]
    push af

    and a, $03

    ; shift left 3 times but dumb again
    rept 3
    or a, a
    rlca
    endr

    or a, b
    push af

    ld a, [wUnkC1C0]
    ld b, a

    pop af

    sub a, b
    call c, .zero

    push af

    and a, $07

    ; shift left 5 times but still dumb
    rept 5
    or a, a
    rlca
    endr

    or a, c

    ld [de], a
    inc de

    pop af

    and a, $18

    ; shift right 3 times (dumb)
    rept 3
    or a, a
    rrca
    endr

    ld c, a

    pop af

    and a, $7C

    ; shift right 2 times (dumb yet again)
    rept 2
    or a, a
    rrca
    endr

    push af
    ld a, [wUnkC1C0]
    ld b, a
    pop af

    sub a, b
    call c, .zero

    ; shift left 2 times (dumb for the last time)
    rept 2
    or a, a
    rlca
    endr

    or a, c

    ld [de], a
    inc de

    pop bc

    dec c
    jr nz, .lop

    ld a, [wUnkC1C1]
    ld b, a
    ld a, $08
    sub a, b
    add a, a
    add a, a
    ld c, a

.code_22FC:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de

    dec c
    jr nz, .code_22FC

    ld a, $01
    ld [wUnkC449], a
    ld a, $00
    ld [wUnkC447], a

    call Func_00E9

    pop de
    pop hl

    ret

.code_2315:
    push hl

    ld a, $01
    ld [wUnkC449], a

    ld hl, sUnk0BDC0
    call Func_2C90

    ld a, $00
    ld [wUnkC447], a

    call Func_00E9

    pop hl

    ld a, [hli]
    ld a, [hli]

    ret

.zero:
    xor a, a
    ret

Func_232F: ; 00232F (00:232F)
    pop hl

    ld a, [wUnkC91E]
    or a, a
    jr nz, .code_235A

    inc hl
    inc hl
    inc hl
    inc hl

    ret

.code_233B:
    ld a, $00
    ld [wUnkC010], a
    ld [wUnkC011], a
    ld [wUnkC3A2], a
    ld [wUnkC3A3], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a
    ld [wUnkC3A6], a
    ld [wUnkC3A7], a

    inc hl
    inc hl
    inc hl
    inc hl

    ret

.code_235A:
    ld a, [wUnkC3A2]
    or a, a
    jp z, .code_240A

    ld a, [wUnkC3A5]
    or a, a
    jp z, .code_247A

    ld a, [wUnkC3A5]
    cp a, $01
    jr nz, .code_23D7

    ld a, $02
    ld [wUnkC3A5], a
    ld a, $00
    ld [wUnkC3A4], a

    call .code_23AB

    ld a, [wUnkC010]
    or a, a
    jr nz, .code_233B

    ld a, 0
    ld [wUnkC010], a
    ld [wUnkC011], a

    ld a, [wFrameCountLo]
    and a, $01
    add a, $32
    ld [wSprite1+sprite_10], a

    ld a, [wUnkC041]

    ld a, [wUnkC916]
    ld [wSprite1+sprite_id], a

    ld a, 0
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a

    jp .code_247A

.code_23AB:
    push af
    push bc
    push de
    push hl

    xor a, a
    ld [wUnkC010], a

    ld a, [wUnkC916]

    cp a, $03
    jr z, .code_23CD

    cp a, $0D
    jr z, .code_23CD

    ld a, [wUnkC011]
    and a, $0F
    ld b, a
    or a, a
    jr z, .code_23D2

    ld a, [wUnkC932]
    cp a, b
    jr z, .code_23D2

.code_23CD:
    ld a, $01
    ld [wUnkC010], a

.code_23D2:
    pop hl
    pop de
    pop bc
    pop af

    ret

.code_23D7:
    ld a, [wUnkC3A4]
    or a, a
    jp z, .code_247A

    ld a, $00
    ld [wUnkC3A2], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a

    ld a, $01
    ld [wUnkC3A6], a

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, l
    ld [wUnkC3A8], a
    ld a, h
    ld [wUnkC3A9], a

    ld a, [wUnkC041]

    ld a, [wUnkC8C6]
    ld [wUnkC3AA], a
    ld a, [wSprite0+sprite_10]
    ld [wUnkC3AB], a

    ret

.code_240A:
    ld a, $01
    ld [wUnkC3A2], a

    ld a, [hli]
    ld a, [hli]
    ld [wUnkC3A5], a
    ld a, [hld]
    ld a, [hld]

    ld a, [wUnkC3A5]
    or a, a
    jp nz, .code_247A

    ld a, [wUnkC916]
    ld [wSprite1+sprite_id], a

    ld a, [wUnkC907]
    ld e, a
    cp a, $64
    jr nc, .code_2448

    ld a, [wUnkC036]
    cp a, e
    jr c, .code_2448

    ld a, $03
    ld [wSprite1+sprite_10], a

    ld a, $00
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a

    call WaitFrame

    jp .code_2463

    nop ; ?

.code_2448:
    ld a, $02
    ld [wSprite1+sprite_10], a

    ld a, $00
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a

    call WaitFrame
    call Func_0858

    ld a, [wUnkC064]
    or a, a
    ret nz

.code_2463:
    ld a, $00
    ld [wUnkC3A5], a
    ld [wUnkC3A7], a
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a
    ld [wSprite1+sprite_0A], a

    call Func_257A

.code_247A:
    dec hl
    dec hl
    dec hl
    dec hl

    ret

Func_247F: ; 00247F (00:247F)
    pop hl
    ld a, [wUnkC91E]
    or a, a
    jr nz, .code_248B
    inc hl
    inc hl
    inc hl
    inc hl
    ret

.code_248B:
    push hl
    ld a, [hli]
    ld a, [hli]
    ld b, a
    pop hl

    ld a, [wUnkC3A3]
    or a, a
    jr z, .code_24B0

    ld a, [wUnkC3A5]
    or a, a
    jp z, .code_2509

    ld a, $00
    ld [wUnkC3A2], a
    ld [wUnkC3A3], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a

    inc hl
    inc hl
    inc hl
    inc hl

    ret

.code_24B0:
    ld a, $01
    ld [wUnkC3A3], a
    ld a, [wUnkC916]
    ld [wSprite1+sprite_id], a
    ld a, [wUnkC907]
    ld e, a
    cp a, $64
    jr nc, .code_24D2
    ld a, [wUnkC036]
    cp a, e
    jr c, .code_24D2
    ld a, $03
    ld [wSprite1+sprite_10], a
    jp .code_24DF

    nop ; ?

.code_24D2:
    ld a, $02
    ld [wSprite1+sprite_10], a
    call Func_0858
    ld a, [wUnkC064]
    or a, a
    ret nz

.code_24DF:
    ld a, $00
    ld [wUnkC3A5], a
    ld [wUnkC3A7], a
    ld [wSprite1+sprite_28], a
    ld [wSprite1+sprite_28+1], a
    ld [wSprite1+sprite_31], a
    ld [wSprite1+sprite_0A], a

    call Func_257A

    ld a, $00
    ld [wUnkC3A2], a
    ld [wUnkC3A3], a
    ld [wUnkC3A4], a
    ld [wUnkC3A5], a

    inc hl
    inc hl
    inc hl
    inc hl

    ret

.code_2509:
    dec hl
    dec hl
    dec hl
    dec hl

    ret

Func_250E: ; 00250E (00:250E)
    pop hl

    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, $01
    ld [wUnkC3A4], a

    ret

Func_2519: ; 002519 (00:2519)
    ld a, [wUnkC409]
    or a, a
    jr nz, .code_2526

    ld a, $01
    ld [wUnkC3A7], a

    jr .code_252B

.code_2526:
    ld a, $01
    ld [wUnkC3A5], a

.code_252B:
    pop hl

    ld a, [hli]
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    ld a, $01
    ld [wUnkC3A5], a

    ret

Func_2536: ; 002536 (00:2536)
    pop hl

    push hl
    ld a, [hli]
    ld a, [hli]
    ld [wUnkC1C2], a
    pop hl

.code_253E:
    dec hl
    dec hl
    dec hl
    dec hl

    ld a, [hl]

    cp a, $80
    jr c, .code_254B

    cp a, $90
    jr c, .code_253E

.code_254B:
    ld a, [wUnkC1C2]
    or a, a
    ret z

    dec a
    ld [wUnkC1C2], a
    jp .code_253E

Func_2557: ; 002557 (00:2557)
    pop hl

    ld a, [hli] ; discard

    ld a, [hli]
    ld [wUnkC0D7+$0], a ; TODO: offset within wUnkC0D7
    ld a, [hli]
    ld [wUnkC0D7+$1], a ; TODO: offset within wUnkC0D7
    ld a, [hli]
    ld [wUnkC0D7+$2], a ; TODO: offset within wUnkC0D7
    ld a, [hli]
    ld [wUnkC0D7+$3], a ; TODO: offset within wUnkC0D7

    ld a, [CurrentBank]
    push af

    ld a, $16 ; TODO: BANK(Func_16_4CC5)
    ld [rROMB0], a
    call Func_16_4CC5

    pop af
    ld [rROMB0], a

    ret

Func_257A: ; 00257A (00:257A)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_604B)
    ld [rROMB0], a
    call Func_03_604B

    pop af
    ld [rROMB0], a

    ret

Func_258B: ; 00258B (00:258B)
    ld a, [CurrentBank]
    push af

    xor a, a
    ld [wUnkC3B3], a

    ld hl, wSprites
    ld a, l
    ld [wUnkC3B4], a
    ld a, h
    ld [wUnkC3B4+1], a

.lop:
    ld a, [wUnkC3B4]
    ld l, a
    ld a, [wUnkC3B4+1]
    ld h, a

    ld a, [hl] ; sprite_enable
    or a, a
    jp z, .continue

    ld a, l
    add a, sprite_frame
    ld l, a
    ld a, [hl]
    or a, a
    jp z, .continue

    assert (wSprites & $3F) == 0
    ld a, l
    and a, $C0 ; reset to start of struct
    add a, sprite_2C
    ld l, a

    ld a, [hli]
    or a, a
    jp z, .continue

    ld [rROMB0], a

    ; de = [+sprite_2D]
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ; hl = +sprite_2C+3

    push de

    rept (sprite_2C+3) - (sprite_2A+1)
    ld a, [hld]
    endr

    ; de = [+sprite_2A]
    ld a, [hld]
    ld d, a
    ld a, [hld]
    ld e, a

    ld hl, $0010 ; TODO: sprite graphics header offset
    add hl, de
    push hl

    ld hl, $0006 ; TODO: sprite graphics header offset
    add hl, de
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a

    ld a, [hli]
    ld [wUnkC1A0], a

    push bc

    ld a, [wUnkC3B4]
    add a, sprite_palette
    ld l, a
    ld a, [wUnkC3B4+1]
    ld h, a

    ; switch to vram bank given loaded oam attributes
    ld a, [hl]
    and a, $08
    rrc a
    rrc a
    rrc a
    ldh [rVBK], a

    pop bc

    pop hl
    pop de

    call Func_2621

.continue:
    ld a, [wUnkC3B4]
    add a, LOW(sprite_sizeof)
    ld [wUnkC3B4], a
    ld a, [wUnkC3B4+1]
    adc a, HIGH(sprite_sizeof)
    ld [wUnkC3B4+1], a

    ld a, [wUnkC3B3]
    inc a
    ld [wUnkC3B3], a

    cp a, $08 ; TODO: count wSprites
    jp c, .lop

    xor a, a
    ld [wUnkC178], a

    pop af
    ld [rROMB0], a

    ret

Func_2621: ; 002621 (00:2621)
    ; in hl = source
    ; in de = target

    ld a, h
    ldh [rHDMA1], a
    ld a, l
    ldh [rHDMA2], a

    ld a, d
    ldh [rHDMA3], a
    ld a, e
    ldh [rHDMA4], a

    ld bc, -$10
    add hl, bc

    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a

    rept 4
    srl b
    rr c
    endr

    ld hl, -1
    add hl, bc

    ld a, l
    and a, $7F ; not HDMA
    ldh [rHDMA5], a

    ret

Func_264F: ; 00264F (00:264F)
    ld a, [CurrentBank]
    push af

    xor a, a
    ld [wOamCount], a
    ld [wUnkC11B], a

    ld a, [wUnkC104]
    or a, a
    jp z, .end

    ld de, wOam

    ld a, [wUnkC102]
    or a, a
    jp z, .refresh_and_end

    ld hl, wUnkC437
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ; goto code_269E if hl is zero
    or a, c
    jr z, .code_269E

    dec hl

    ld a, l
    ld [wUnkC437], a
    ld a, h
    ld [wUnkC437+1], a

    ld bc, $0050
    call WordCompare2

    ld a, [wCompareResult]

    cp a, COMPARE_GREATER
    jr z, .code_2693

    bit 3, l
    jr nz, .code_269E

    jp .refresh_and_end

.code_2693:
    ld bc, Data_276B
    add hl, bc

    ld a, [hli]
    or a, a
    jr nz, .code_269E

    jp .refresh_and_end

.code_269E:
    ld a, [wUnkC08F]
    cp a, $01
    jr z, .code_26C5

    ld a, [wCameraY+1]
    ld b, a
    ld a, [wCameraY]
    ld c, a
    ld a, [wCursorY]
    sub a, c
    ld [wCursorScreenY], a

    ld a, [wCameraX+1]
    ld b, a
    ld a, [wCameraX]
    ld c, a
    ld a, [wCursorX]
    sub a, c
    ld [wCursorScreenX], a

    jr .code_26D1

.code_26C5:
    ld a, [wUnkC0B0]
    ld [wCursorScreenY], a
    ld a, [wUnkC0B1]
    ld [wCursorScreenX], a

.code_26D1:
    ld hl, wCursorScreenY

    ld a, [hli] ; wCursorScreenY
    ld [wCursorSpriteY], a
    ld a, [hli] ; wCursorScreenX
    ld [wCursorSpriteX], a
    ld b, a
    ld a, [wCursorSpriteY]
    and a, b
    cp a, $FF
    jp z, .refresh_and_end

    ld a, [hli] ; wUnkC102
    ld c, a
    ld b, 0

    ld a, [hli] ; discard wUnkC103

    push bc

    ld a, [hl] ; wUnkC104
    ld c, a

    ld a, BANK(Data_26_4000)
    ld [rROMB0], a

    ld hl, Data_26_4000
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a

    ld a, [hli]
    ld [wUnkC187], a

    ld a, [hli]
    ld [rROMB0], a

    ld h, b
    ld l, c

    pop bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld h, a
    ld l, c

    ld a, [hli]
    ld [wUnkC11B], a

    ld a, [hli]
    ld [wUnkC170], a

.lop_objects:
    ; object y
    ld a, [wCursorSpriteY]
    ld b, a
    ld a, [hli]
    add a, b
    ld [de], a
    inc de

    ld a, [wUnkC16F]
    and a, a
    jr nz, .code_2738

    ; object x
    ld a, [wCursorSpriteX]
    ld b, a
    ld a, [hli]
    add a, b
    ld c, a
    ld a, [wUnkC187]
    ld b, a
    ld a, c
    add a, b
    ld [de], a
    ld a, [hli] ; discard
    inc de

    jr .code_2748

.code_2738:
    ; object x
    ld a, [wCursorSpriteX]
    ld b, a
    ld a, [hli] ; discard
    ld a, [hli]
    add a, b
    ld c, a
    ld a, [wUnkC187]
    ld b, a
    ld a, c
    add a, b
    ld [de], a
    inc de

.code_2748:
    ; object tile
    ld a, [hli]
    ld [de], a
    inc de

    ; object attributes
    ld a, [hli]
    ld a, [wUnkC103]
    ld [de], a
    inc de

    ld a, [wOamCount]
    inc a
    ld [wOamCount], a

    ld a, [wUnkC11B]
    dec a
    ld [wUnkC11B], a
    jr nz, .lop_objects

.refresh_and_end:
    ld a, TRUE
    ld [wRefreshOam], a

.end:
    pop af
    ld [rROMB0], a

    ret

Data_276B:
    db 0, 0, 1, 1
    db 0, 0, 1, 1
    db 0, 0, 1, 1
    db 0, 0, 1, 1
    db 0, 0, 1, 1
    db 0, 0, 0, 1
    db 1, 0, 0, 0
    db 1, 1, 1, 0
    db 0, 0, 1, 1
    db 1, 0, 0, 0
    db 1, 1, 1, 0
    db 0, 0, 0, 1
    db 1, 1, 1, 0
    db 0, 0, 0, 1
    db 1, 1, 1, 0
    db 0, 0, 0, 0
    db 1, 1, 1, 1
    db 1, 0, 0, 0
    db 0, 0, 1, 1
    db 1, 1, 1, 1

Func_27BB: ; 0027BB (00:27BB)
    ld a, [CurrentBank]
    push af

    ld a, [wCursorY]
    ld [wUnkC266], a
    ld a, [wCursorY+1]
    ld [wUnkC266+1], a

    ld a, [wCursorX]
    ld [wUnkC268], a
    ld a, [wCursorX+1]
    ld [wUnkC268+1], a

    ld a, $04 ; TODO: BANK(Data_04_4000)
    ld [rROMB0], a

    call Func_27E7
    call ClampCursorPosition

    pop af
    ld [rROMB0], a

    ret

Func_27E7: ; 0027E7 (00:27E7)
    ; note: assumes rom bank is BANK(Data_04_4000)

    ld a, [wUnkC43B]
    ld l, a
    ld a, [wUnkC43B+1]
    ld h, a

    inc hl

    ld a, l
    ld [wUnkC43B], a
    ld a, h
    ld [wUnkC43B+1], a

    ld a, [wUnkC107]
    or a, a
    jp nz, .dec_cnt

    ld a, [wUnkC17C]
    ld b, a
    ld a, [wUnkC17D]
    or a, b
    jr nz, .code_2833

    ld hl, Data_04_4000
    ld a, [wUnkC104]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld [wUnkC17E], a
    ld [rROMB0], a

    ld h, b
    ld l, c

    ld a, [wUnkC105]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld [wUnkC17D], a
    ld a, [hli]
    ld [wUnkC17C], a

.code_2833:
    ld a, [wUnkC17E]
    ld [rROMB0], a

    ld a, [wUnkC17C]
    ld h, a
    ld a, [wUnkC17D]
    ld l, a

    ld a, [hli]
    ld c, a
    ld a, [hl]
    and a, c
    cp a, $FF
    jp z, .end

    ld a, c
    call Expand
    ld de, wCursorY
    call WordSumPtr

    ld a, [hli]
    ld b, a
    and a, $F0
    cp a, $80
    ld a, b
    jr nz, .code_2862

    call Func_28F5

    jr .code_2870

.code_2862:
    ld a, [wUnkC16F]
    or a, a
    jr z, .code_286C

    ; b = -b
    ld a, b
    cpl
    inc a
    ld b, a

.code_286C:
    ld a, b
    call Expand

.code_2870:
    ld de, wCursorX
    call WordSumPtr

    ld a, [hli]
    ld [wUnkC102], a

    ld a, [wUnkC16F]
    or a, a
    jr z, .code_2884

    ld a, $30

    jr .code_2886

.code_2884:
    ld a, $10

.code_2886:
    ld [wUnkC103], a
    ld a, [hli]
    ld b, a

    ldh a, [hCgbMark]
    cp a, $11
    call nz, Func_28CC

    ld a, [wUnkC02A]
    or a, a
    call nz, Func_28C3

    ld a, b
    ld [wUnkC107], a

    ld a, [hl]
    bit 7, a
    call nz, Func_291F

    ld a, h
    ld [wUnkC17C], a
    ld a, l
    ld [wUnkC17D], a

    jr .end

.dec_cnt:
    ld a, [wUnkC107]
    dec a
    ld [wUnkC107], a

    jr .end

.end:
    xor a, a
    ld [wUnkC440], a
    ld [wUnkC441], a

    ld a, $01
    ld [wUnkC173], a

    ret

Func_28C3: ; 0028C3 (00:28C3)
    ld a, b
    add a, $05
    ld b, a
    xor a, a
    ld [wUnkC02A], a
    ret

Func_28CC: ; 0028CC (00:28CC)
    ; b = b/2
    ld a, b
    or a, a
    rra
    ld b, a
    ret

Func_28D1: ; 0028D1 (00:28D1)
    ld a, [wUnkC43D]
    xor a, 1
    ld [wUnkC43D], a
    jr z, .code_28DF

    ld a, $02

    jr .code_28E1

.code_28DF:
    ld a, $03

.code_28E1:
    ld [wUnkC105], a

    xor a, a
    ld [wUnkC17D], a
    ld [wUnkC17C], a
    ld [wUnkC107], a
    ld [wUnkC43B], a
    ld [wUnkC43B+1], a

    ret

Func_28F5: ; 0028F5 (00:28F5)
    ld b, 0
    ld c, a

    and a, $F0
    cp a, $80
    jr z, .code_2904
    jr c, .end

    ld b, $FF
    jr .end

.code_2904:
    ld a, c
    and a, $0F
    ld c, a

    ldh a, [hHeldKeys]

    bit KEY_BIT_DPAD_RIGHT, a
    jr nz, .right

    bit KEY_BIT_DPAD_LEFT, a
    jr nz, .left

    ld c, 0
    jr .end

.right:
    jr .end

.left:
    ld a, c
    cpl
    inc a
    ld c, a
    ld b, $FF

.end:
    ret

Func_291F: ; 00291F (00:291F)
    cp a, $90
    ret nc

    ld a, [hli]

    cp a, $80
    jr z, .code_2960

    cp a, $81
    jp z, .code_2968

    cp a, $82
    jp z, .code_2978

    cp a, $83
    jp z, .code_2989

    cp a, $84
    jp z, .code_298B

    cp a, $87
    jp z, .code_2A18

    cp a, $88
    jp z, .code_29A5

    cp a, $89
    jp z, .code_29ED

    cp a, $8A
    jp z, .code_2A17

    cp a, $8B
    jp z, .code_2A1F

    cp a, $8E
    jp z, .code_2A31

    cp a, $8F
    jp z, .code_2A35

    ld a, [hld]

    ret

.code_2960:
    ld a, [hli]
    ld [wUnkC105], a

    ld hl, 0

    ret

.code_2968:
    ld a, [wUnkC029]
    or a, a
    jr nz, .code_2974

    ld a, [hld]
    ld a, [hld]
    ld a, [hld]
    ld a, [hld]
    ld a, [hld]

    ret

.code_2974:
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    ret

.code_2978:
    ld a, [hli]
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a

    ldh a, [hHeldKeys]
    cp a, c
    ret nz

    ld a, b
    ld [wUnkC105], a

    xor a, a
    ld h, a
    ld l, a

    ret

.code_2989:
    ld a, [hli]
    ret

.code_298B:
    ld a, [hli]
    ld c, a
    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, [wUnkC432]
    or a, a
    ret z
    xor a, a
    ld [wUnkC432], a

    ldh a, [hHeldKeys]
    bit KEY_BIT_BUTTON_A, a
    ret z

    ld a, c
    ld [wUnkC105], a

    ld hl, 0

    ret

.code_29A5:
    push de

    ld a, [hli]
    ld [wUnkC20C], a

    ld a, [hli]

    push hl

    call Expand

    push bc
    ld a, [wCursorY]
    ld l, a
    ld a, [wCursorY+1]
    ld h, a
    pop bc

    ld de, wUnkC208
    call WordSum

    pop hl
    ld a, [hli]
    push hl

    call Expand

    push bc
    ld a, [wCursorX]
    ld l, a
    ld a, [wCursorX+1]
    ld h, a
    pop bc

    ld a, [wUnkC16F]
    or a, a
    call nz, .code_29E9

    ld de, wUnkC20A
    call WordSum
    call Func_3C69

    ld de, wSprite0+sprite_flip
    ld a, [wUnkC16F]
    ld [de], a

    pop hl
    pop de

    ret

.code_29E9:
    ld bc, 0
    ret

.code_29ED:
    ld a, [wUnkC433]
    sub a, $01
    ld [wUnkC433], a
    jr c, .code_2A0B

    ld a, $01
    ld [wUnkC026], a

    xor a, a
    ld [wUnkC027], a
    ldh [rLCDC], a
    ld [wUnkC436], a

    ld a, $05
    ld [wUnkC435], a

    ret

.code_2A0B:
    ld a, $01
    ld [wUnkC027], a

    xor a, a
    ld [wUnkC026], a
    ldh [rLCDC], a

    ret

.code_2A17:
    ret

.code_2A18:
    ld a, [hli]
    call Func_2CC3
    ld a, [hli]
    ld a, [hli]
    ret

.code_2A1F:
    ld a, [wUnkC029]
    or a, a
    jr z, .code_2A2D

    ld a, [hli]
    ld [wUnkC105], a

    ld hl, 0

    ret

.code_2A2D:
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    ret

.code_2A31:
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    ret

.code_2A35:
    ld a, [hli]
    ld [wUnkC02C], a
    ld a, [hli]
    ld a, [hli]

    ret

WaitFrame: ; 002A3C (00:2A3C)
    ld a, [wPrevFrameCount]
    ld b, a

.lop:
    ld a, [wFrameCountLo]
    cp a, b
    jr z, .lop

    ld [wPrevFrameCount], a

    ret

WaitFramesOrButtonPress: ; 002A4A (00:2A4A)
    ld a, [wUnkC034]
    ld e, a

    ld a, [wPrevFrameCount]
    ld b, a

.lop:
    ld a, [wFrameCountLo]
    cp a, b
    jr z, .lop

    ld b, a
    ld [wPrevFrameCount], a

    dec e
    ld a, e
    or a, a
    jr z, .end

    call ReadKeyInput

    ldh a, [hNewKeys]
    and a, KEY_BUTTON_ANY
    ld [wUnkC024], a
    jr z, .lop

.end:
    ret

EnableCgbDoubleSpeedMode: ; 002A6E (00:2A6E)
    ld a, [hCgbMark]
    cp a, $11
    ret nz

    ldh a, [rKEY1]
    bit 7, a
    ret nz

    set 0, a
    ldh [rKEY1], a

    stop

    ret

InitOamDmaFunc: ; 002A80 (00:2A80)
    ld hl, OamDmaFunc
    ld de, hOamDmaFunc

    ld c, hOamDmaFuncEnd - hOamDmaFunc

.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop

    ret

Func_2A8F: ; 002A8F (00:2A8F)
.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec bc

    ld a, c
    or a, b
    jr nz, .lop

    ret

OamDmaFunc: ; 002A98 (00:2A98)
    call WaitForScreenBlank
    ld a, b
    ldh [rDMA], a
    ld a, $28
.lop:
    dec a
    jr nz, .lop
    ret

SwapBank: ; 002AA4 (00:2AA4)
    ld [rROMB0], a
    ret

WordCompareSigned: ; [wCompareResult] = hl <=> bc ; 002AA8 (00:2AA8)
    ; [wCompareResult] = COMPARE_EQUAL   if hl == bc
    ; [wCompareResult] = COMPARE_GREATER if hl > bc
    ; [wCompareResult] = COMPARE_LESSER  if hl < bc

    push hl ; useless
    push bc ; useless

    xor a, a
    ld [wCompareResult], a

    ; cp h, b
    ld a, h
    cp a, b
    jr z, .compare_lo
    jr c, .code_2AB8
    jr nc, .code_2AC6

    jr .end

.code_2AB8:
    ld a, b
    cp a, $80
    jr nc, .code_2ABF
    jr .hl_greater_than_bc

.code_2ABF:
    ld a, h
    cp a, $80
    jr nc, .hl_greater_than_bc
    jr .hl_lesser_than_bc

.code_2AC6:
    ld a, h
    cp a, $80
    jr nc, .code_2ACD
    jr .hl_lesser_than_bc

.code_2ACD:
    ld a, b
    cp a, $80
    jr nc, .hl_lesser_than_bc
    jr .hl_greater_than_bc

.compare_lo:
    ; cp l, c
    ld a, l
    cp a, c
    jr z, .equal
    jr c, .hl_greater_than_bc
    jr nc, .hl_lesser_than_bc

    jr .end

.equal:
    ld a, COMPARE_EQUAL
    jr .return

.hl_greater_than_bc:
    ld a, COMPARE_GREATER
    jr .return

.hl_lesser_than_bc:
    ld a, COMPARE_LESSER

.return:
    ld [wCompareResult], a

.end:
    pop bc ; useless
    pop hl ; useless

    ret

WordCompare: ; [wCompareResult] = hl <=> bc ; 002AEE (00:2AEE)
    ; [wCompareResult] = COMPARE_EQUAL   if hl == bc
    ; [wCompareResult] = COMPARE_GREATER if hl > bc
    ; [wCompareResult] = COMPARE_LESSER  if hl < bc

    xor a, a
    ld [wCompareResult], a

    ld a, h
    cp a, b
    jr z, .compare_lo
    jr c, .hl_greater_than_bc
    jr nc, .hl_lesser_than_bc
    jr .end

.compare_lo:
    ld a, l
    cp a, c
    jr z, .equal
    jr c, .hl_greater_than_bc
    jr nc, .hl_lesser_than_bc
    jr .end

.equal:
    ld a, COMPARE_EQUAL
    jr .return

.hl_greater_than_bc:
    ld a, COMPARE_GREATER
    jr .return

.hl_lesser_than_bc:
    ld a, COMPARE_LESSER

.return:
    ld [wCompareResult], a

.end:
    ret

WordCompare2: ; [wCompareResult] = hl <=> bc ; 002B14 (00:2B14)
    ; [wCompareResult] = COMPARE_EQUAL   if hl == bc
    ; [wCompareResult] = COMPARE_GREATER if hl > bc
    ; [wCompareResult] = COMPARE_LESSER  if hl < bc

    push bc ; useless
    push hl ; useless

    xor a, a
    ld [wCompareResult], a

    ld a, h
    cp a, b
    jr z, .code_2B24
    jr c, .code_2B32
    jr nc, .code_2B36

    jr .code_2B3B

.code_2B24:
    ld a, l
    cp a, c
    jr z, .code_2B2E
    jr c, .code_2B32
    jr nc, .code_2B36

    jr .code_2B3B

.code_2B2E:
    ld a, COMPARE_EQUAL
    jr .code_2B38

.code_2B32:
    ld a, COMPARE_GREATER
    jr .code_2B38

.code_2B36:
    ld a, COMPARE_LESSER

.code_2B38:
    ld [wCompareResult], a

.code_2B3B:
    pop hl ; useless
    pop bc ; useless

    ret

WordDiff: ; [de] = hl - bc ; 002B3E (00:2B3E)
    push hl ; useless

    ld a, l
    sub a, c
    ld [de], a
    inc de
    ld a, h
    sbc a, b
    ld [de], a

    pop hl ; useless
    ret

WordSum: ; [de] = hl + bc ; 002B48 (00:2B48)
    push hl

    add hl, bc
    ld a, l
    ld [de], a
    ld a, h
    inc de
    ld [de], a

    pop hl
    ret

WordSumPtr: ; [de] = [de] + bc ; 002B51 (00:2B51)
    push hl

    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a

    add hl, bc

    dec de
    ld a, l
    ld [de], a
    ld a, h
    inc de
    ld [de], a

    pop hl
    ret

Expand: ; bc = a ; 002B60 (00:2B60)
    ld b, 0
    ld c, a

    cp a, $80
    jr c, .end

    ld b, $FF

.end:
    ret

WordStore: ; 002B6A (00:2B6A)
    ; [de] = bc

    ld a, c
    ld [de], a
    ld a, b
    inc de
    ld [de], a

    ret

WaitForScreenBlank: ; 002B70 (00:2B70)
.lop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .lop

    ret

WaitForVBlank: ; 002B77 (00:2B77)
.lop:
    ldh a, [rLY]

    cp a, 144
    jr c, .lop

    cp a, 149
    jr nc, .lop

    ret

Func_2B82: ; 002B82 (00:2B82)
    ld a, [wUnkC481]
    or a, a
    jr z, .code_2B89

    dec a

.code_2B89:
    ld [wUnkC481], a

    ld a, [wUnkC446]
    or a, a
    ret z

    cp a, $09
    jr nc, .end

    ld hl, sUnk0BDC0
    ld bc, $0040

.lop:
    add hl, bc
    dec a
    jr nz, .lop

    ld a, [wUnkC447]
    sub a, 1
    ld [wUnkC447], a
    ret nc

    ld a, [wUnkC448]
    ld [wUnkC447], a

    ld a, [wUnkC446]
    inc a
    ld [wUnkC446], a

    push hl
    call SetBgPal
    pop hl

    ld a, [wUnkC449]
    or a, a
    ret nz

    call SetObPal
    ret

.end:
    xor a, a
    ld [wUnkC449], a
    ld [wUnkC446], a
    ret

SyncObPal: ; 002BCB (00:2BCB)
    ld a, [wRefreshObPal]
    or a, a
    ret z

    ldh a, [rLY]
    cp a, 137 ; TODO: scanline constants
    ret c

    ld a, [wRefreshObPal]
    dec a
    ld [wRefreshObPal], a

    ld de, rOCPS

    ld hl, .data_2BF6
    add a, l
    ld l, a
    ld a, h
    adc a, 0
    ld h, a

    ld a, [hli]
    or a, a
    ret z

    and a, $3F

    cp a, $01
    jr z, .code_2C3E

    cp a, $02
    jr z, .code_2C43

    ret

.data_2BF6:
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00
    db $01, $00, $00, $02
    db $00, $00, $01, $00
    db $00, $02, $00, $00

.code_2C3E:
    ld hl, wObPalBuf
    jr SyncBgPal.beg

.code_2C43:
    ld hl, wObPalBufB
    jr SyncBgPal.beg

SyncBgPal:
    ld a, [wRefreshBgPal]
    or a, a
    ret z

    ldh a, [rLY]
    cp a, 137
    ret c

    xor a, a
    ld [wRefreshBgPal], a

    ld hl, wBgPalBuf
    ld de, rBCPS

.beg:
    ld b, 8
    ld a, BCPSF_AUTOINC

    ld [de], a
    inc de

.lop:
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld [de], a

    dec b
    jr nz, .lop

    ret

SetObPal: ; hl = pal addr
    push de
    ld de, rOCPS

    jr SetBgPal.beg

SetBgPal: ; hl = pal addr
    push de
    ld de, rBCPS

.beg:
    ld b, $40

    ld a, BCPSF_AUTOINC
    ld [de], a
    inc de

.lop:
    call WaitForScreenBlank

    ld a, [hli]
    ld [de], a

    dec b
    jr nz, .lop

    pop de
    ret

Func_2C90: ; 002C90 (00:2C90)
.wait:
    ld a, [wUnkC446]
    or a, a
    jr nz, .wait

    ld de, sUnk0BFC0
    ld c, $40

.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop

    ret

Mul8: ; 002CA2 (00:2CA2)
    ; a = a * b

    push bc

    ld c, a
    xor a, a

.lop:
    add a, c
    dec b
    jr nz, .lop

    pop bc
    ret

Data_2CAB:
    db $06, $0B, $07, $08
    db $06, $0B, $05, $17
    db $0B, $07, $06, $13
    db $05, $14, $07, $13
    db $15, $17, $14, $16
    db $06, $06, $06, $06

Func_2CC3: ; 002CC3 (00:2CC3)
    push bc
    push hl

    ld b, a

    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Data_01_7D61)
    ld [rROMB0], a

    ld a, b

    ld hl, Data_01_7D61
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a

    ld a, [hl]
    ld [wUnkCA27], a

    ld a, $01
    ldh [hUnkFF8E], a

    pop af
    ld [rROMB0], a

    pop hl
    pop bc

    ret

Func_2CE8: ; 002CE8 (00:2CE8)
    push af
    push bc
    push de
    push hl

    ld a, $00
    ldh [rTMA], a
    ldh [rTIMA], a
    ld a, TACF_16KHZ
    ldh [rTAC], a
    ld a, TACF_16KHZ | TACF_START
    ldh [rTAC], a

    ld a, $0C ; TODO: BANK(Func_0C_4009)
    ld [rROMB0], a
    call Func_0C_4009

    ld hl, hUnkFF8D
    xor a, a
    ld [hli], a ; hUnkFF8D
    ld [hli], a ; hUnkFF8E
    ld [rROMB0], a

    ld a, $FF ; everything
    ldh [rAUDTERM], a

    pop hl
    pop de
    pop bc
    pop af

    ret

Func_2D14: ; 002D14 (00:2D14)
    ld a, [CurrentBank]
    push af

    ld a, FALSE
    ld [wRefreshScroll], a

    ld a, $3E ; TODO: BANK(Data_3E_4000)
    ld [rROMB0], a

    call Func_309C

    ld a, TRUE
    ld [wRefreshScroll], a

    ld a, [wUnkC080]

    cp a, $01
    jr z, .code_2D3E

    cp a, $12
    jr z, .code_2D3E

    cp a, $0E
    jr z, .code_2D3E

    ld a, $01
    ld [wUnkC350], a

.code_2D3E:
    ld a, [wUnkC080]
    ld c, a
    sla c
    ld b, 0

    ld hl, Data_3E_4000
    add hl, bc

    ld a, [hli]
    ld [wUnkC082], a
    ld a, [hli]
    ld [wUnkC082+1], a

.code_2D52:
    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    and a, e
    cp a, $FF
    jr z, .code_2D6A

    ld hl, .code_2D52
    push hl

    push de
    pop hl

    jp hl

.code_2D6A:
    ; TODO: assert BANK(Func_01_4924) == BANK(Func_01_53FC)
    ld a, $01 ; TODO: BANK(Func_01_4924)
    ld [rROMB0], a
    call Func_01_4924
    call Func_01_53FC

    ld a, $01
    ld [wUnkC177], a

    ld a, [wUnkC080]
    cp a, $1B
    jr nz, .end

    ld a, $01 ; TODO: BANK(Func_01_6A83)
    ld [rROMB0], a
    call Func_01_6A83

.end:
    pop af
    ld [rROMB0], a

    ret

Func_2D8E: ; 002D8E (00:2D8E)
    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Data_3E_4000)
    ld [rROMB0], a

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

.code_2D9F:
    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    and a, e
    cp a, $FF
    jr z, .code_2DB7

    ld hl, .code_2D9F
    push hl

    push de
    pop hl

    jp hl

.code_2DB7:
    ld a, $01
    ld [wUnkC177], a

    pop af
    ld [rROMB0], a

    ret

Func_2DC1: ; 002DC1 (00:2DC1)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5AD9)
    ld [rROMB0], a
    call Func_03_5AD9

    pop af
    ld [rROMB0], a

    ret

Func_2DD2: ; 002DD2 (00:2DD2)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5B03)
    ld [rROMB0], a
    call Func_03_5B03

    pop af
    ld [rROMB0], a

    ret

Func_2DE3: ; 002DE3 (00:2DE3)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5B26)
    ld [rROMB0], a
    call Func_03_5B26

    pop af
    ld [rROMB0], a

    ret

Func_2DF4: ; 002DF4 (00:2DF4)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Func_01_4151)
    ld [rROMB0], a
    call Func_01_4151

    pop af
    ld [rROMB0], a

    ret

Func_2E05: ; 002E05 (00:2E05)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5B92)
    ld [rROMB0], a
    call Func_03_5B92

    pop af
    ld [rROMB0], a

    ret

Func_2E16: ; 002E16 (00:2E16)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_60EC)
    ld [rROMB0], a
    call Func_03_60EC

    pop af
    ld [rROMB0], a

    ret

Func_2E27: ; 002E27 (00:2E27)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Func_01_6F49)
    ld [rROMB0], a
    call Func_01_6F49

    ld a, $00
    ld [wUnkC08F], a

    pop af
    ld [rROMB0], a

    ret

Func_2E3D: ; 002E3D (00:2E3D)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    inc hl
    inc hl

.lop:
    ld a, [hli]
    ld e, a
    cp a, $FF
    jr z, .end

    ld a, [hli]
    ld d, a

    ld a, [hli]
    ld c, a

    ld [de], a
    ld a, [hli]
    ld b, a
    cp a, $80
    jr nc, .code_2E63

    ld a, c
    ld [de], a

    jr .lop

.code_2E63:
    ld a, [bc]
    ld [de], a

    jr .lop

.end:
    inc hl

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_2E78: ; 002E78 (00:2E78)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, TRUE
    ld [wUnkC062], a

    call WaitFrame

    di

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    inc hl
    inc hl

    ld a, [hli]
    ldh [rVBK], a
    inc hl

    ld a, [hli]
    ldh [rHDMA4], a
    ld a, [hli]
    ldh [rHDMA3], a

    ld a, [hli]
    ld [wUnkC084], a
    ld a, [hli]

    ld a, [hli]
    ldh [rHDMA2], a
    ld a, [hli]
    ldh [rHDMA1], a
    ld a, [hli]
    ld [wUnkC089], a

    ld a, [wUnkC084]
    ld [rROMB0], a

    ld a, [wUnkC089]
    ldh [rHDMA5], a

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld bc, 12 ; TODO: length of wUnkC082 thing?
    add hl, bc

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    ei

    ld a, FALSE
    ld [wUnkC062], a

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_2ED8: ; 002ED8 (00:2ED8)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    inc hl
    inc hl

    ld a, [hli]
    ld [wUnkC079], a
    inc hl
    ld a, [hli]
    ld [wUnkC084], a
    inc hl
    ld a, [hli]
    ld [wUnkC085], a
    ld a, [hli]
    ld [wUnkC085+1], a
    ld a, [hli]
    ld [wUnkC08B], a
    inc hl
    ld a, [hli]
    ld [wUnkC089], a
    ld a, [wUnkC084]
    ld [rROMB0], a
    ld de, rBCPS
    ld a, [wUnkC079]
    sla a
    add a, e
    ld e, a
    ld a, d
    adc a, 0
    ld d, a

    ld a, [wUnkC089]
    ld b, a
    ld a, [wUnkC08B]
    ld [de], a
    inc de

    ld a, [wUnkC085]
    ld l, a
    ld a, [wUnkC085+1]
    ld h, a

.lop:
    call WaitForScreenBlank
    ld a, [hli]
    ld [de], a
    dec b
    jr nz, .lop

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a
    ld bc, 12
    add hl, bc
    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_2F4D: ; 002F4D (00:2F4D)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    inc hl
    inc hl

    ld a, [hli]
    ldh [rVBK], a
    ld a, [hli]
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld a, [hli]
    ld [wUnkC084], a
    ld a, [hli]
    ld a, [hli]
    ld [wUnkC085], a
    ld a, [hli]
    ld [wUnkC085+1], a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld a, [wUnkC084]
    ld [rROMB0], a
    ld a, [wUnkC085]
    ld l, a
    ld a, [wUnkC085+1]
    ld h, a
    ld a, b
    ld [wUnkC070], a

.lop_blocks:
    ld a, [wUnkC070]
    ld b, a

    push de

.lop_bytes:
    call WaitForScreenBlank
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .lop_bytes

    pop de

    ld a, LOW($0020)
    add a, e
    ld e, a
    ld a, HIGH($0020)
    adc a, d
    ld d, a

    dec c
    jr nz, .lop_blocks

    xor a, a
    ldh [rVBK], a

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld bc, 12
    add hl, bc

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_2FC2: ; 002FC2 (00:2FC2)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld de, Data_3D_4000
    ld a, e
    ld [wUnkC079], a
    ld a, d
    ld [wUnkC07A], a

    ld a, $0F
    ld [wUnkC089], a

    jr .code_3024

    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld de, Data_3D_4300
    ld a, e
    ld [wUnkC079], a
    ld a, d
    ld [wUnkC07A], a

    ld a, $0F
    ld [wUnkC089], a

    jr .code_3024

    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld de, Data_3D_4200
    ld a, e
    ld [wUnkC079], a
    ld a, d
    ld [wUnkC07A], a

    ld a, $0B
    ld [wUnkC089], a

    jr .code_3024

    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld de, Data_3D_4100
    ld a, e
    ld [wUnkC079], a
    ld a, d
    ld [wUnkC07A], a

    ld a, $0B
    ld [wUnkC089], a

.code_3024:
    ld a, $01
    ld [wUnkC062], a

    di

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    inc hl
    inc hl

    ld a, 1
    ldh [rVBK], a

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a

    ld a, [hli]
    ldh [rHDMA4], a
    ld a, [hli]
    ldh [rHDMA3], a

    ; TODO: assert BANK(Data_3D_4000) == BANK(Data_3D_4100)
    ; TODO: assert BANK(Data_3D_4000) == BANK(Data_3D_4200)
    ; TODO: assert BANK(Data_3D_4000) == BANK(Data_3D_4300)

    ld a, $3D ; TODO: BANK(Data_3D_4000)
    ld [rROMB0], a

    ld a, [bc]
    ld c, a
    ld b, 0

    ; bc = bc*4
    rept 2
    sla c
    rl b
    endr

    ld a, [wUnkC079]
    ld l, a
    ld a, [wUnkC07A]
    ld h, a
    add hl, bc

    ld a, [hli]
    ld c, a
    ld [wUnkC084], a
    ld a, [hli]
    ld a, [hli]
    ldh [rHDMA2], a
    ld a, [hli]
    ldh [rHDMA1], a
    ld a, [wUnkC084]
    ld [rROMB0], a

    call WaitForVBlank

    ld a, [wUnkC089]
    ldh [rHDMA5], a

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld bc, 6
    add hl, bc

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    ld a, $00
    ldh [rVBK], a

    pop af
    ld [rROMB0], a

    ld a, $00
    ld [wUnkC062], a

    ei

    pop hl
    pop de
    pop bc

    ret

Func_309C: ; 00309C (00:309C)
    push bc
    push de
    push hl

    ld a, 0
    ld [wSprite0+sprite_enable], a
    ld [wSprite1+sprite_enable], a
    ld [wSprite2+sprite_enable], a
    ld [wSprite3+sprite_enable], a
    ld [wSprite4+sprite_enable], a
    ld [wSprite5+sprite_enable], a
    ld [wSprite6+sprite_enable], a
    ld [wSprite7+sprite_enable], a

    di
    call Func_1DFC
    call Func_1B66
    ei

    call WaitFrame

    pop hl
    pop de
    pop bc

    ret

Func_30C8: ; 0030C8 (00:30C8)
    push bc
    push de
    push hl

    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a
    ld bc, $0029
    ld de, wSprite1+sprite_y
    call WordSum

    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a
    ld bc, $0007
    ld de, wSprite1+sprite_x
    call WordSum

    ld a, $01
    ld [wSprite1+sprite_10], a
    ld [wSprite1+sprite_flip], a

    ld a, $3E
    ld [wSprite1+sprite_tile], a

    ld a, LOW(vTilesA+$400) ; useless
    ld a, HIGH(vTilesA+$400)
    ld [wSprite1+sprite_2D+1], a

    xor a, a
    ld [wSprite1+sprite_frame], a
    ld [wSprite1+sprite_2D], a
    ld [wSprite1+sprite_31], a

    ld a, $05
    ld [wSprite1+sprite_palette], a
    ld [wUnkC07A], a

    ld a, [wUnkC8C5]
    add a, $16
    ld [wSprite1+sprite_id], a
    ld [wUnkC07B], a

    ld a, $01
    ld [wSprite1], a

    jp Func_318B.code_31ED

Func_3126: ; 003126 (00:3126)
    push bc
    push de
    push hl

    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a
    ld bc, $0030
    ld de, wSprite1+sprite_y
    call WordSum

    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a
    ld bc, $000C
    ld de, wSprite1+sprite_x
    call WordSum

    ld a, $00
    ld [wSprite1+sprite_frame], a

    ld a, $01
    ld [wSprite1+sprite_flip], a

    ld a, $1E
    ld [wSprite1+sprite_tile], a

    ld a, $00
    ld [wSprite1+sprite_2D], a

    ld a, $82
    ld [wSprite1+sprite_2D+1], a

    xor a, a
    ld [wSprite1+sprite_31], a

    ld a, $01
    ld [wSprite1+sprite_10], a

    ld a, $02
    ld [wSprite1+sprite_palette], a
    ld [wUnkC07A], a

    ld a, [wUnkC915]
    add a, $16
    ld [wSprite1+sprite_id], a
    ld [wUnkC07B], a

    ld a, $01
    ld [wSprite1], a

    call WaitForVBlank

    jp Func_318B.code_31ED

Func_318B: ; 00318B (00:318B)
    push bc
    push de
    push hl

    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a
    ld bc, $0030
    ld de, wSprite2+sprite_y
    call WordSum

    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a
    ld bc, $006C
    ld de, wSprite2+sprite_x
    call WordSum

    ld a, $00
    ld [wSprite2+sprite_frame], a

    ld a, $01
    ld [wSprite2+sprite_flip], a

    ld a, $3E
    ld [wSprite2+sprite_tile], a

    ld a, $00
    ld [wSprite2+sprite_2D], a

    ld a, $84
    ld [wSprite2+sprite_2D+1], a

    xor a, a
    ld [wSprite2+sprite_31], a

    ld a, $01
    ld [wSprite2+sprite_10], a

    ld a, $05
    ld [wSprite2+sprite_palette], a
    ld [wUnkC07A], a

    ld a, [wUnkC8C5]
    add a, $16
    ld [wSprite2+sprite_id], a
    ld [wUnkC07B], a

    ld a, $01
    ld [wSprite2+sprite_enable], a

    call WaitForVBlank

.code_31ED:
    ld a, [wUnkC07A]
    and a, $07
    ld c, a
    ld b, 0

    rept 3
    sla c
    rl b
    endr

    ld hl, wObPalBuf
    add hl, bc

    push hl
    pop de

    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(Data_26_4800)
    ld [rROMB0], a

    ld hl, Data_26_4800

    ld a, [wUnkC07B]
    ld c, a
    ld b, 0

    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push bc
    pop hl

    ld c, $18

.code_3225:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .code_3225

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a

    ld bc, 2
    add hl, bc

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    pop af
    ld [rROMB0], a

    ld a, TRUE
    ld [wRefreshObPal], a

    pop hl
    pop de
    pop bc

    ret

Func_324C: ; 00324C (00:324C)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_6860)
    ld [rROMB0], a
    call Func_3E_6860

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_3263: ; 003263 (00:3263)
    push bc
    push de
    push hl
    ld a, [CurrentBank]
    push af
    ld a, $3E ; TODO: BANK(Func_3E_6AD0)
    ld [rROMB0], a
    call Func_3E_6AD0
    pop af
    ld [rROMB0], a
    pop hl
    pop de
    pop bc
    ret

Func_327A: ; 00327A (00:327A)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_6BA6)
    ld [rROMB0], a
    call Func_3E_6BA6

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_3291: ; 003291 (00:3291)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_6A9A)
    ld [rROMB0], a
    call Func_3E_6A9A

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_32A8: ; 0032A8 (00:32A8)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_6D79)
    ld [rROMB0], a
    call Func_3E_6D79

    pop af
    ld [rROMB0], a

    pop hl
    pop de
    pop bc

    ret

Func_32BF: ; 0032BF (00:32BF)
    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_6DCB)
    ld [rROMB0], a
    call Func_3E_6DCB

    pop af
    ld [rROMB0], a

    ret

Func_32D0: ; 0032D0 (00:32D0)
    push bc
    push de
    push hl

    ld a, [CurrentBank]
    push af

    ld a, $3E ; TODO: BANK(Func_3E_7D01)
    ld [rROMB0], a
    call Func_3E_7D01

    pop af
    ld [rROMB0], a

    ld a, [wUnkC082]
    ld l, a
    ld a, [wUnkC082+1]
    ld h, a
    ld c, LOW($000A)
    ld b, HIGH($000A)
    add hl, bc

    ld a, l
    ld [wUnkC082], a
    ld a, h
    ld [wUnkC082+1], a

    pop hl
    pop de
    pop bc

    ret

Func_32FC: ; 0032FC (00:32FC)
    ld a, [CurrentBank]
    push af

    ld hl, $8E00 ; TODO: VRAM variables
    ld a, l
    ld [wUnkC2BE], a
    ld a, h
    ld [wUnkC2BE+1], a

    call ClearTextChr

    ld hl, $8E00 ; TODO: VRAM variables
    ld a, l
    ld [wUnkC2BE], a
    ld [wUnkC2B5], a
    ld a, h
    ld [wUnkC2BE+1], a
    ld [wUnkC2B5+1], a

    ld a, $00
    ld [wUnkC2CA], a
    ld a, $07
    ld [wUnkC2C9], a

    ld a, [wUnkC2B0]
    cp a, $14
    jr z, .code_3342

    ld a, [wUnkC2B0]
    cp a, $15
    jr nc, .code_336C

    ld a, [wUnkC2B1]
    cp a, $00
    jr z, .code_336C

    cp a, $01
    jr z, .code_336C

.code_3342:
    ld a, [wUnkC080]
    push af

    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, $0E
    ld [wUnkC080], a
    ld [wUnkC081], a

    call Func_2D14

    pop af
    ld [wUnkC080], a
    ld [wUnkC081], a

    ld a, $A0
    ld [wWY], a

    ld a, $70
    ld [wUnkC2CA], a

    ld a, $07
    ld [wUnkC2C9], a
    ld [wWX], a

.code_336C:
    ld a, [wUnkC2B7]
    ld [wUnkC2B8], a

    ld a, LCDCF_ON | LCDCF_WIN9C00 | LCDCF_WINON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ldh [rLCDC], a

    ld a, $50 ; TODO: BANK(Data_50_4000)
    ld [rROMB0], a

    ld hl, Data_50_4000
    ld a, [wUnkC2B0]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    ld a, [wUnkC2B1]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld [wText], a
    ld a, [hli]
    ld [wText+1], a
    ld a, [hli]
    ld [wTextBank], a

.lop:
    call WaitFrame
    call ReadKeyInput
    call PutText

    ld a, $00
    ld [wUnkC361], a

    call Func_1DFC
    call Func_1B66

    ld a, [wText]
    ld b, a
    ld a, [wText+1]
    or a, b
    jr nz, .lop

    pop af
    ld [rROMB0], a

    ret

PutText: ; 0033C4 (00:33C4)
    ldh a, [hHeldKeys]
    cp a, KEY_BUTTON_A
    jr nz, .no_a_held

    xor a, a
    ld [wUnkC2B8], a

.no_a_held:
    ld a, [wUnkC2B8]
    or a, a
    jp nz, .wait_more

    ld a, [wText]
    ld b, a
    ld a, [wText+1]
    or a, b
    ret z

    ld a, [wTextBank]
    ld [rROMB0], a

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli]
    cp a, $E0
    jr c, .code_3405

    ld hl, TextControlJt

    sub a, $E0

    ld c, a
    ld b, 0

    xor a, a
    ld [wUnkC2B8], a

    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    jp hl

.code_3405:
    ld a, [wUnkC2B7]
    ld [wUnkC2B8], a

    ld a, [wTextCharsetChr]
    ld l, a
    ld a, [wTextCharsetChr+1]
    ld h, a

    ld bc, $0040

    ld a, [wTextBank]
    ld [rROMB0], a

    ld a, [wText]
    ld e, a
    ld a, [wText+1]
    ld d, a
    ld a, [de]
    ld d, a

.code_3426:
    ld a, d
    sub a, 1
    ld d, a
    jr c, .code_342F

    add hl, bc
    jr .code_3426

.code_342F:
    ld a, [wUnkC2B5]
    ld e, a
    ld a, [wUnkC2B5+1]
    ld d, a

    ld b, $04

    ld a, [wTextCharsetChrBank]
    ld [rROMB0], a

    ldh a, [rVBK]
    push af

    ld a, 1
    ldh [rVBK], a

.lop_tiles:
    ld c, $08

.lop_lines:
    call WaitForScreenBlank

    ld a, [hli]
    ld [de], a
    inc de

    ld a, [hli]
    ld [de], a
    inc de

    dec c
    jr nz, .lop_lines

    dec b
    jr nz, .lop_tiles

    pop af
    ldh [rVBK], a

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    inc hl

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld a, e
    ld [wUnkC2B5], a
    ld a, d
    ld [wUnkC2B5+1], a

    ret

.wait_more:
    dec a
    ld [wUnkC2B8], a
    ret

ClearTextChr: ; 003479 (00:3479)
    ldh a, [rVBK]
    push af

    ld a, 1
    ldh [rVBK], a

    ld a, [wUnkC2BE]
    ld l, a
    ld a, [wUnkC2BE+1]
    ld h, a

    ld bc, $0100

.lop:
    call WaitForScreenBlank

    ld a, $FF
    ld [hli], a

    xor a, a
    ld [hli], a

    dec bc
    ld a, c
    or a, b
    jr nz, .lop

    pop af
    ldh [rVBK], a

    ret

TextControlJt:
    dw Func_34DC ; E0
    dw Func_34E0 ; E1 ; choice?
    dw Func_3591 ; E2
    dw Func_35B4 ; E3
    dw Func_35EE ; E4 ; open/close box?
    dw Func_363C ; E5 ; end?
    dw Func_36DC ; E6
    dw Func_36DC ; E7
    dw Func_36F0 ; E8
    dw Func_3704 ; E9
    dw Func_3751 ; EA ; face left?
    dw Func_381A ; EB ; face right?
    dw Func_38D1 ; EC ; face right again?
    dw TextControl_LineEnd ; ED
    dw Func_39A4 ; EE
    dw TextControl_HastyLineEnd ; EF
    dw TextControl_SetCharset ; F0
    dw TextControl_SetCharset ; F1
    dw TextControl_SetCharset ; F2
    dw TextControl_SetCharset ; F3
    dw TextControl_SetCharset ; F4
    dw TextControl_SetCharset ; F5
    dw TextControl_SetCharset ; F6
    dw TextControl_SetCharset ; F7
    dw TextControl_SetCharset ; F8
    dw TextControl_SetCharset ; F9
    dw TextControl_SetCharset ; FA
    dw TextControl_SetCharset ; FB
    dw TextControl_SetCharset ; FC
    dw TextControl_SetCharset ; FD
    dw TextControl_SetCharset ; FE
    dw TextControl_End ; FF

Func_34DC: ; 0034DC (00:34DC)
    call TextAdvance
    ret

Func_34E0: ; 0034E0 (00:34E0)
    ld a, [wUnkC0B0]
    ld c, a
    ld a, [wUnkC0B1]
    ld b, a
    push bc

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli]
    ld a, [hli]
    ld [wUnkC0B0], a
    ld [wUnkC2C1], a

    ld a, [hli]
    ld [wUnkC0B1], a
    ld [wUnkC2C0], a

    ld a, [hli]
    ld [wUnkC2C3], a
    ld a, [hli]
    ld [wUnkC2C2], a
    ld a, [hli]
    ld [wUnkC2C4], a
    ld a, [hli]
    ld [wUnkC2C5], a
    ld a, [hli]
    ld [wUnkC2C6], a
    ld a, [hli]
    ld [wUnkC2C7], a

    ld a, 0
    ld [wUnkC2C8], a

.lop:
    call WaitFrame
    call ReadKeyInput

    ld a, [hNewKeys]

    bit KEY_BIT_DPAD_RIGHT, a
    jr nz, .right

    bit KEY_BIT_DPAD_LEFT, a
    jr nz, .left

    jr .no_dir_press

.left:
    ld a, [wUnkC2C1]
    ld [wUnkC0B0], a
    ld a, [wUnkC2C0]
    ld [wUnkC0B1], a

    ld a, 0
    ld [wUnkC2C8], a

    jr .no_dir_press

.right:
    ld a, [wUnkC2C3]
    ld [wUnkC0B0], a
    ld a, [wUnkC2C2]
    ld [wUnkC0B1], a

    ld a, 1
    ld [wUnkC2C8], a

.no_dir_press:
    call Func_27BB
    call Func_1DFC
    call Func_264F
    call Func_1B66

    ld a, [hNewKeys]
    bit KEY_BIT_BUTTON_A, a
    jr z, .lop

    ld a, [wUnkC2C8]
    or a, a
    jr z, .code_3577

    ld a, [wUnkC2C4]
    ld l, a
    ld a, [wUnkC2C5]
    ld h, a

    jr .code_357F

.code_3577:
    ld a, [wUnkC2C6]
    ld l, a
    ld a, [wUnkC2C7]
    ld h, a

.code_357F:
    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    pop bc
    ld a, c
    ld [wUnkC0B0], a
    ld a, b
    ld [wUnkC0B1], a

    ret

Func_3591: ; 003591 (00:3591)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ;  discard

    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ld a, [hli]
    ld c, a

    ld a, [hli] ; discard

    ld a, [de]
    cp a, c
    jr z, .code_35A7

    ld a, [hli] ; discard
    ld a, [hli] ; discard

.code_35A7:
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

    ld a, e
    ld [wText], a
    ld a, d
    ld [wText+1], a

    ret

Func_35B4: ; 0035B4 (00:35B4)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]

    cp a, $00
    jr z, .case_0

    cp a, $01
    jr z, .case_1

    ret

.case_0:
    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld hl, $8E00 ; TODO: VRAM variables

    jr ._

.case_1:
    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld hl, $8C00 ; TODO: VRAM variables

._:
    ld a, l
    ld [wUnkC2BE], a
    ld [wUnkC2B5], a
    ld a, h
    ld [wUnkC2BE+1], a
    ld [wUnkC2B5+1], a

    ret

Func_35EE: ; 0035EE (00:35EE)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]

    cp a, $00
    jr z, .case_0

    cp a, $01
    jr z, .case_1

.default:
    call Func_309C

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ret

.case_0:
    ldh a, [rWY]
    cp a, 144
    jr nc, .default

    inc a
    ldh [rWY], a
    ld [wWY], a

    ld a, [wUnkC2C9]
    ldh [rWX], a
    ld [wWX], a

    ret

.case_1:
    ld a, [wUnkC2CA]
    ld b, a
    ldh a, [rWY]
    cp a, b
    jr z, .default
    jr c, .default

    dec a
    ldh [rWY], a
    ld [wWY], a

    ld a, [wUnkC2C9]
    ldh [rWX], a
    ld [wWX], a

    ret

    nop ; ?

Func_363C: ; 00363C (00:363C)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    ld c, a
    ld b, 0

    ; bc = bc*16
    rept 4
    sla c
    rl b
    endr

    ld a, c
    ld [wCursorY], a
    ld [wUnkC395], a
    ld a, b
    ld [wUnkC395+1], a
    ld [wCursorY+1], a

    ld a, [hli]
    ld c, a
    ld b, 0

    ; bc = bc*16
    rept 4
    sla c
    rl b
    endr

    ld a, c
    ld [wCursorX], a
    ld [wUnkC397], a
    ld a, b
    ld [wCursorX+1], a
    ld [wUnkC397+1], a

.lop:
    call WaitFrame
    call Func_27BB
    call Func_1DFC
    call Func_3BD0

    di
    call Func_0707
    call Func_137E
    call Func_142F
    call Func_264F
    call Func_1B66
    ei

    ld a, [wUnkC39A]
    ld b, a
    ld a, [wSCY]
    cp a, b
    jr nz, .code_36BC

    ld a, [wUnkC399]
    ld c, a
    ld a, [wSCX]
    cp a, c
    jr nz, .code_36BC

    jr .code_36CA

.code_36BC:
    ld a, [wSCY]
    ld [wUnkC39A], a
    ld a, [wSCX]
    ld [wUnkC399], a

    jr .lop

.code_36CA:
    call TextAdvance
    call TextAdvance
    call TextAdvance

    ld a, $1E
    ld [wUnkC034], a

    call WaitFramesOrButtonPress

    ret

Func_36DC: ; 0036DC (00:36DC)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    call Func_2CC3

    call TextAdvance
    call TextAdvance

    ret

Func_36F0: ; 0036F0 (00:36F0)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    ld [wUnkC2B7], a

    call TextAdvance
    call TextAdvance

    ret

Func_3704: ; 003704 (00:3704)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jp nz, .code_372B

    ld a, $B0
    ld [wWY], a
    ld [$4A], a ; BUG: should be rWY
    ld [wWX], a
    ld [$4B], a ; BUG: should be rWX

    ld a, TRUE
    ld [wRefreshObPal], a
    ld [wRefreshBgPal], a

    jp .code_3747

.code_372B:
    add a, $33
    ld [wUnkC080], a

    ld hl, vTilesA1 + $400

    ld a, l
    ld [wUnkC2BE], a
    ld a, h
    ld [wUnkC2BE+1], a

    call ClearTextChr
    call Func_2D14

    ld a, [wUnkC081]
    ld [wUnkC080], a

.code_3747:
    call TextAdvance
    call TextAdvance
    ret

    nop ; useless
    nop ; useless
    nop ; useless

Func_3751: ; 003751 (00:3751)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    ld b, a

    add a, $16
    ld [wSprite0+sprite_id], a

    ld a, [hli]
    ld [wSprite0+sprite_10], a

    or a, b
    jr nz, .code_3770

    ld a, FALSE
    ld [wSprite0+sprite_enable], a

    jp .end

.code_3770:
    ld a, $50 ; useless

    ld a, $70
    ld [wSprite0+sprite_y], a

    ld a, $10
    ld [wSprite0+sprite_x], a

    ld a, $00
    ld [wSprite0+sprite_y+1], a
    ld [wSprite0+sprite_x+1], a

    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a

    ld bc, $70

    ld de, wSprite0+sprite_y
    call WordSum

    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a

    ld bc, $10

    ld de, wSprite0+sprite_x
    call WordSum

    ld a, TRUE
    ld [wSprite0+sprite_enable], a

    ld a, 0
    ld [wSprite0+sprite_frame], a
    ld [wSprite0+sprite_flip], a

    ld a, $1E
    ld [wSprite0+sprite_tile], a

    ld a, LOW($8200) ; TODO: vram variables
    ld [wSprite0+sprite_2D], a
    ld a, HIGH($8200) ; TODO: vram variables
    ld [wSprite0+sprite_2D+1], a

    ld a, $00 ; useless

    ld a, $02 ; palette
    ld [wSprite0+sprite_palette], a

    ld a, [wSprite0+sprite_palette]
    and a, %111

    ld c, a
    ld b, 0

    ; bc = bc*8
    rept 3
    sla c
    rl b
    endr

    ld hl, wObPalBuf
    add hl, bc
    push hl
    pop de

    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(Data_26_4800)
    ld [rROMB0], a

    ld hl, Data_26_4800
    ld a, [wSprite0+sprite_id]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push bc
    pop hl

    ld c, $18

.code_3801:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .code_3801

    pop af
    ld [rROMB0], a

    ld a, TRUE
    ld [wRefreshObPal], a

.end:
    call TextAdvance
    call TextAdvance
    call TextAdvance
    ret

Func_381A: ; 00381A (00:381A)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a
    ld a, [hli] ; discard

    ld a, [hli]
    ld b, a
    add a, $16
    ld [wSprite1+sprite_id], a

    ld a, [hli]
    ld [wSprite1+sprite_10], a
    or a, b
    jr nz, .code_3839

    ld a, 0
    ld [wSprite1+sprite_enable], a

    jp .end

.code_3839:
    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a

    ld bc, $70

    ld de, wSprite1+sprite_y
    call WordSum

    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a

    ld bc, $70

    ld de, wSprite1+sprite_x
    call WordSum

    ld a, TRUE
    ld [wSprite1+sprite_enable], a
    ld a, $00
    ld [wSprite1+sprite_frame], a
    ld a, TRUE
    ld [wSprite1+sprite_flip], a
    ld a, $3E
    ld [wSprite1+sprite_tile], a

    ld a, LOW(vTilesA+$400)
    ld [wSprite1+sprite_2D], a
    ld a, HIGH(vTilesA+$400)
    ld [wSprite1+sprite_2D+1], a

    ld a, $03
    ld a, $05
    ld [wSprite1+sprite_palette], a
    ld a, [wSprite1+sprite_palette]
    and a, $07
    ld c, a
    ld b, $00

    rept 3
    sla c
    rl b
    endr

    ld hl, wObPalBuf
    add hl, bc
    push hl
    pop de

    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(Data_26_4800)
    ld [rROMB0], a

    ld hl, Data_26_4800

    ld a, [wSprite1+sprite_id]
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push bc
    pop hl

    ld c, $18

.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop

    pop af
    ld [rROMB0], a

    ld a, TRUE
    ld [wRefreshObPal], a

.end:
    call TextAdvance
    call TextAdvance
    call TextAdvance
    ret

Func_38D1: ; 0038D1 (00:38D1)
    ld a, [wUnkC0CB]
    and a, $7F
    ld b, a
    add a, $16
    ld [wSprite1+sprite_id], a

    ld a, $01
    ld [wSprite1+sprite_10], a
    or a, b
    jr nz, .code_38EC

    ld a, $00
    ld [wSprite1], a

    jp .end

.code_38EC:
    ld a, [wCameraY+1]
    ld h, a
    ld a, [wCameraY]
    ld l, a

    ld bc, $70

    ld de, wSprite1+sprite_y
    call WordSum
    ld a, [wCameraX+1]
    ld h, a
    ld a, [wCameraX]
    ld l, a

    ld bc, $70

    ld de, wSprite1+sprite_x
    call WordSum

    ld a, $01
    ld [wSprite1], a
    ld a, $00
    ld [wSprite1+sprite_frame], a
    ld a, $01
    ld [wSprite1+sprite_flip], a
    ld a, $3E
    ld [wSprite1+sprite_tile], a
    ld a, $00
    ld [wSprite1+sprite_2D], a
    ld a, $84
    ld [wSprite1+sprite_2D+1], a

    ld a, $03 ; useless

    ld a, $05
    ld [wSprite1+sprite_palette], a

    ld a, [wSprite1+sprite_palette]
    and a, %111
    ld c, a
    ld b, 0

    rept 3
    sla c
    rl b
    endr

    ld hl, wObPalBuf
    add hl, bc
    push hl
    pop de

    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(Data_26_4800)
    ld [rROMB0], a

    ld hl, Data_26_4800

    ld a, [wSprite1+sprite_id]
    ld c, a
    ld b, 0

    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push bc
    pop hl

    ld c, $18

.lop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .lop

    pop af
    ld [rROMB0], a

    ld a, TRUE
    ld [wRefreshObPal], a

.end:
    call TextAdvance
    ret

TextControl_LineEnd: ; 00397E (00:397E)
    ldh a, [hNewKeys]
    cp a, KEY_BUTTON_A
    ret nz

    call ClearTextChr

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    inc hl

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld a, [wUnkC2BE]
    ld [wUnkC2B5], a

    ld a, [wUnkC2BE+1]
    ld [wUnkC2B5+1], a

    ret

Func_39A4: ; 0039A4 (00:39A4)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard

    ld a, [hli]
    ld c, a
    ld b, 0

    ld hl, .code_39C0
    push hl

    ld hl, Data_39C7

    add hl, bc
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    jp hl

.code_39C0:
    call TextAdvance
    call TextAdvance
    ret

Data_39C7:
    dw Func_39D5
    dw Func_39D6
    dw Func_3A09
    dw Func_39D5
    dw Func_3A15
    dw Func_3A1C
    dw Func_3A79

Func_39D5:
    ret

Func_39D6:
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a

    ld a, [wUnkC00C]
    add a, c
    ld [wUnkC00C], a
    ld a, [wUnkC00D]
    adc a, b
    ld [wUnkC00D], a
    ld a, [wUnkC00E]
    adc a, 0
    ld [wUnkC00E], a
    ld a, [wUnkC00F]
    adc a, 0
    ld [wUnkC00F], a

    call TextAdvance
    call TextAdvance
    ret

Func_3A09:
    ld a, $01
    ld [wUnkC02F], a

    call TextAdvance
    call TextAdvance
    ret

Func_3A15: ; 003A15 (00:3A15)
    call Func_09F4

    ld a, 0
    ld [hl], a

    ret

Func_3A1C: ; 003A1C (00:3A1C)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli] ; discard
    ld a, [hli] ; discard

    ld a, [hli]
    ld b, a

    ld hl, wUnkC8EE
    ld a, [hli]
    or a, a
    jr z, .code_3A52

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jr z, .code_3A52

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jr z, .code_3A52

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jr z, .code_3A52

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jr z, .code_3A52

    ld a, [hli] ; discard

    ld a, [hli]
    or a, a
    jr z, .code_3A52

    call TextAdvance
    call Func_09F4

    ld a, $00
    ld [hl], a

    ret

.code_3A52:
    dec hl
    ld a, b
    ld [hli], a
    ld b, a

    push hl

    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5AC3)
    ld [rROMB0], a

    ld a, b
    call Func_03_5AC3

    ld a, l
    add a, LOW(3)
    ld l, a
    ld a, h
    adc a, HIGH(3)
    ld h, a

    ld a, [hli]
    ld b, a

    pop af
    ld [rROMB0], a

    pop hl

    ld a, b
    ld [hl], a

    call TextAdvance
    ret

Func_3A79: ; 003A79 (00:3A79)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli]
    ld [wUnkC2CC], a
    ld a, [hli]
    ld [wUnkC2CD], a
    ld a, [hli]
    ld [wUnkC0DE], a
    ld a, [hli]
    ld [wUnkC0DF], a
    ld a, [hli]
    ld [wUnkC0E0], a
    ld a, [hli]
    ld [wUnkC0E1], a
    ld a, [hli]
    ld [wUnkC0E2], a
    ld a, [hli]
    ld [wUnkC0E3], a
    ld a, [hli]
    ld [wUnkC0E4], a
    ld a, [hli]
    ld [wUnkC0E5], a
    ld a, [hli]
    ld [wUnkC0E6], a
    ld a, [hli]
    ld [wUnkC0E7], a
    ld a, [hli]
    ld [wUnkC0E8], a

    ld a, [wText]
    add a, LOW(11)
    ld [wText], a
    ld a, [wText+1]
    adc a, HIGH(11)
    ld [wText+1], a

    ld a, [CurrentBank]
    push af

    ld a, $10 ; TODO: BANK(Func_10_4C93)
    ld [rROMB0], a
    call Func_10_4C93

    pop af
    ld [rROMB0], a

    ret

Func_3AD6: ; 003AD6 (00:3AD6)
    ld a, $02
    ld [wUnkC021], a

    call Func_0167

    ld a, [wUnkC071]
    ld [wUnkC0F0], a
    ld a, [wUnkC072]
    ld [wUnkC0F1], a
    ld a, [wUnkC073]
    ld [wUnkC0F2], a
    ld a, [wUnkC074]
    ld [wUnkC0F3], a
    ld a, [wUnkC075]
    ld [wUnkC0F4], a

    ld a, $03
    ld [wUnkC021], a

    call Func_0167

    ld a, [wUnkC071]
    ld [wUnkC0F5], a
    ld a, [wUnkC072]
    ld [wUnkC0F6], a
    ld a, [wUnkC073]
    ld [wUnkC0F7], a
    ld a, [wUnkC074]
    ld [wUnkC0F8], a
    ld a, [wUnkC075]
    ld [wUnkC0F9], a

    ret

TextControl_HastyLineEnd: ; 003B23 (00:3B23)
    ldh a, [hNewKeys]
    cp a, KEY_BUTTON_A
    jr nz, .wait

.finish:
    call ClearTextChr

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    inc hl

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld a, [wUnkC2BE]
    ld [wUnkC2B5], a
    ld a, [wUnkC2BE+1]
    ld [wUnkC2B5+1], a

    ret

.wait:
    ld a, [wUnkC2BD]
    inc a
    ld [wUnkC2BD], a
    cp a, $20
    ret c

    xor a, a
    ld [wUnkC2BD], a

    jr .finish

TextControl_SetCharset: ; 003B5A (00:3B5A)
    ld a, [wTextBank]
    ld [rROMB0], a

    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    ld a, [hli]

    and a, $0F
    ld c, a
    ld b, 0

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ld hl, TextCharsetTable
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    ld [wTextCharsetChr], a
    ld a, [hli]
    ld [wTextCharsetChr+1], a

    ld a, [hli]
    ld [wTextCharsetChrBank], a

    jp PutText.code_3405

TextControl_End: ; 003B8C (00:3B8C)
    xor a, a
    ld [wText], a
    ld [wText+1], a

    ret

TextAdvance: ; 003B94 (00:3B94)
    ld a, [wText]
    ld l, a
    ld a, [wText+1]
    ld h, a

    inc hl

    ld a, l
    ld [wText], a
    ld a, h
    ld [wText+1], a

    ret

TextCharsetTable:
    dw Data_55_4000, $55 ; TODO: dab Data_55_4000
    dw Data_56_4000, $56 ; TODO: dab Data_56_4000
    dw Data_57_4000, $57 ; TODO: dab Data_57_4000
    dw Data_58_4000, $58 ; TODO: dab Data_58_4000
    dw Data_59_4000, $59 ; TODO: dab Data_59_4000
    dw Data_5A_4000, $5A ; TODO: dab Data_5A_4000

Func_3BBE: ; 003BBE (00:3BBE)
    ret

Func_3BBF: ; 003BBF (00:3BBF)
    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO: BANK(Func_02_4181)
    ld [rROMB0], a
    call Func_02_4181

    pop af
    ld [rROMB0], a

    ret

Func_3BD0: ; 003BD0 (00:3BD0)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5DFA)
    ld [rROMB0], a
    call Func_03_5DFA

    pop af
    ld [rROMB0], a

    ret

Func_3BE1: ; 003BE1 (00:3BE1)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5E12)
    ld [rROMB0], a
    call Func_03_5E12

    pop af
    ld [rROMB0], a

    ret

Func_3BF2: ; 003BF2 (00:3BF2)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5CBA)
    ld [rROMB0], a
    call Func_03_5CBA

    pop af
    ld [rROMB0], a
    ret

Func_3C03: ; 003C03 (00:3C03)
    ld a, [CurrentBank]
    push af

    ld a, $0A
    ld [rRAMG], a

    ld a, $03 ; TODO: BANK(Func_03_5BD3)
    ld [rROMB0], a
    call Func_03_5BD3

    pop af
    ld [rROMB0], a

    ret

Func_3C19: ; 003C19 (00:3C19)
    ld a, [CurrentBank]
    push af

    ld a, $0A
    ld [rRAMG], a

    ld a, $03 ; TODO: BANK(Func_03_5C6C)
    ld [rROMB0], a
    call Func_03_5C6C

    pop af
    ld [rROMB0], a

    ret

Func_3C2F: ; 003C2F (00:3C2F)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Func_01_4000)
    ld [rROMB0], a
    call Func_01_4000

    pop af
    ld [rROMB0], a

    ret

Func_3C40: ; 003C40 (00:3C40)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Func_01_4044)
    ld [rROMB0], a
    call Func_01_4044

    pop af
    ld [rROMB0], a

    ret

Func_3C51: ; 003C51 (00:3C51)
    ld a, [wUnkC022]
    or a, a
    ret z

    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO: BANK(Func_02_47AA)
    ld [rROMB0], a
    call Func_02_47AA

    pop af
    ld [rROMB0], a

    ret

    db 1, 0 ; useless

Func_3C69: ; 003C69 (00:3C69)
    ld a, [CurrentBank]
    push af

    ld a, $16 ; TODO: BANK(Data_16_4000)
    ld [rROMB0], a

    xor a, a
    ld [wUnkC400], a

    ld a, [wUnkC20C]
    ld c, a
    ld b, 0

    ; bc = bc*16
    rept 4
    sla c
    rl b
    endr

    ld hl, Data_16_4000
    add hl, bc

    push hl

.code_3C91:
    ld hl, wSprites+sprite_enable

    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a

    add hl, bc

    ld a, [hl]
    or a, a
    jr nz, .displayed

    call Func_3E15

    ld a, TRUE
    ld [hli], a

    jr .code_3CC9

.displayed:
    ld a, [wUnkC409]
    ld l, a
    ld a, [wUnkC409+1]
    ld h, a

    ld bc, sprite_sizeof

    ld de, wUnkC409
    call WordSum

    ld a, [wUnkC400]
    inc a
    ld [wUnkC400], a

    cp a, $15
    jr c, .code_3C91

    pop hl
    jp .end

.code_3CC9:
    ld hl, wSprites+sprite_id
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld [de], a
    push hl

    ld hl, wSprites+sprite_10
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld [de], a
    push hl

    ld hl, wSprites+sprite_flip
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld [de], a
    ld a, [hli]
    ld a, [hli]
    push hl

    push af

    ld hl, wSprites+sprite_y
    add hl, bc

    push hl
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c
    pop de

    pop af

    call Expand
    call WordSum

    pop hl
    ld a, [hli]
    push hl

    push af

    ld hl, wSprites+sprite_x
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    push hl
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c
    pop de

    pop af

    call Expand
    call WordSum

    pop hl
    ld a, [hli]
    push hl

    push af

    ld hl, wSprites+sprite_11
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc
    push hl
    pop de

    ld a, [wUnkC076]
    cp a, $03
    jr z, .code_3D37

    ld [de], a
    pop af
    jr .code_3D39

.code_3D37:
    pop af
    ld [de], a

.code_3D39:
    pop hl
    ld a, [hli]
    ld a, [hli]
    push hl

    push de
    push bc
    push af

    ld hl, wSprites+sprite_attributes
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    pop af
    ld [hli], a

    pop bc
    pop de

    pop hl
    ld a, [hli]
    push hl

    push af

    ld hl, wSprites+sprite_tile
    add hl, bc
    push hl
    pop de

    pop af

    ld [de], a

    pop hl ; useless
    push hl ; useless

    ld hl, wSprites+sprite_2D
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de

    rept 3
    inc de
    endr

    ld a, [hli]
    ld [de], a ; sprite_32
    push hl

    ld hl, wSprites+sprite_y
    add hl, bc
    push hl
    pop de

    ld hl, wUnkC208
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de

    ld hl, wUnkC20A
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a

    ld hl, wSprites+sprite_1D
    add hl, bc
    push hl
    pop de

    ld hl, wSprites+sprite_x
    add hl, bc
    ld a, [hli]
    add a, 4
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a

    ld hl, wSprites+sprite_23
    add hl, bc
    push hl
    pop de

    ld hl, wSprites+sprite_y
    add hl, bc
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a

    ld hl, wSprites+sprite_21
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld c, a
    ld b, 0
    push hl

    push bc

    ld hl, wSprites+sprite_x
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    pop bc

    call WordSum

    ld hl, wSprites+sprite_1F
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc
    push hl
    pop de

    pop hl
    ld a, [hli]
    ld c, a
    ld b, 0

    push bc

    ld hl, wSprites+sprite_y
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    pop bc

    call WordDiff

    ld hl, wSprites+sprite_0B
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc
    push hl
    pop de

    ld hl, wUnkC20D
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a

    call Func_3E2D

.end:
    xor a, a
    ld [wUnkC40D], a

    pop af
    ld [rROMB0], a

    ret

Func_3E15: ; 003E15 (00:3E15)
    push bc
    push hl

    ld hl, wSprites
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld c, sprite_sizeof

.lop:
    xor a, a
    ld [hli], a
    dec c
    jr nz, .lop

    pop hl
    pop bc

    ret

Func_3E2D: ; 003E2D (00:3E2D)
    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(Data_26_4400)
    ld [rROMB0], a

    ld hl, wSprites+sprite_2A
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc
    push hl
    pop de

    ld hl, wSprites+sprite_id
    add hl, bc
    ld a, [hli]
    ld hl, Data_26_4400
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    push af

    ld a, [hli] ; discard

    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld h, a
    ld l, c

    pop af
    ld [rROMB0], a

    push hl

    ld hl, wSprites+sprite_frame
    ld a, [wUnkC409]
    ld c, a
    ld a, [wUnkC409+1]
    ld b, a
    add hl, bc

    ld a, $01
    ld [hl], a
    ld a, [hli]

    pop hl

    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    add hl, bc
    add hl, bc

    ld a, [hli]
    push af

    ld a, [hli] ; discard

    ld a, [hli]
    ld c, a
    ld [de], a
    inc de
    ld a, [hli]
    ld h, a
    ld [de], a
    inc de

    pop af
    ld [de], a
    ld [rROMB0], a

    inc de

    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    or a, b
    jr z, .end

    ld a, [de]
    ld d, a
    ld e, b

    ld l, c

    push hl
    ld bc, 6
    add hl, bc

    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld [wUnkC1A0], a

    pop hl

    push bc
    ld bc, $10
    add hl, bc
    pop bc

    call Func_0EBC

.end:
    pop af
    ld [rROMB0], a

    ret

Func_3EB0: ; 003EB0 (00:3EB0)
    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO: BANK(Func_02_41C5)
    ld [rROMB0], a
    call Func_02_41C5

    pop af
    ld [rROMB0], a

    ret

Func_3EC1: ; 003EC1 (00:3EC1)
    ld a, [CurrentBank]
    push af

    ld a, $02 ; TODO: BANK(Func_02_50A0)
    ld [rROMB0], a
    call Func_02_50A0

    pop af
    ld [rROMB0], a

    ret

Func_3ED2: ; 003ED2 (00:3ED2)
    ld a, [CurrentBank]
    push af

    ld a, $10 ; TODO: BANK(Func_10_4498)
    ld [rROMB0], a
    call Func_10_4498

    pop af
    ld [rROMB0], a

    ret

Func_3EE3: ; 003EE3 (00:3EE3)
    ld a, [CurrentBank]
    push af

    ld a, $10 ; TODO: BANK(Func_10_4593)
    ld [rROMB0], a
    call Func_3EF7
    call Func_10_4593

    pop af
    ld [rROMB0], a

    ret

Func_3EF7: ; 003EF7 (00:3EF7)
    ld hl, wUnkDE00

    xor a, a
    ld [wUnkC0D3], a

.code_3EFE:
    ld a, [hli]
    cp a, $FF
    ret z

    ld a, [hli]
    ld a, [hli]
    ld a, [hli]
    ld a, [hli]

    ld a, [hli]
    or a, a
    jr z, .no_inc

    ld a, [wUnkC0D3]
    inc a
    ld [wUnkC0D3], a

.no_inc:
    ld a, [hli]
    jr .code_3EFE

    ret ; useless

Func_3F15: ; 003F15 (00:3F15)
    ld a, [CurrentBank]
    push af

    ld a, $00
    ld [rRAMB], a

    ld a, $0A
    ld [rRAMG], a

    ld a, $03 ; TODO: BANK(Func_03_5886)
    ld [rROMB0], a
    call Func_03_5886

    ld a, $00
    ld [rRAMB], a

    pop af
    ld [rROMB0], a

    ret

Func_3F35: ; 003F35 (00:3F35)
    ld a, [CurrentBank]
    push af

    ld a, $00
    ld [rRAMB], a

    ld a, $0A
    ld [rRAMG], a

    ld a, $03 ; TODO: BANK(Func_03_594A)
    ld [rROMB0], a
    call Func_03_594A

    ld a, $00
    ld [rRAMB], a

    pop af
    ld [rROMB0], a

    ret

Func_3F55: ; 003F55 (00:3F55)
    ld a, [CurrentBank]
    push af

    ld a, [wUnkC007]
    push af

    inc a
    ld [wUnkC007], a

    ld a, $10 ; TODO: BANK(Func_10_407F)
    ld [rROMB0], a
    call Func_10_407F

    pop af
    ld [wUnkC007], a

    pop af
    ld [rROMB0], a

    ret

Func_3F72: ; 003F72 (00:3F72)
    ld a, [CurrentBank]
    push af

    ld a, $01 ; TODO: BANK(Func_01_7DC9)
    ld [rROMB0], a
    call Func_01_7DC9

    pop af
    ld [rROMB0], a

    ret

Func_3F83: ; 003F83 (00:3F83)
    ld a, [CurrentBank]
    push af

    ld a, $26 ; TODO: BANK(?)
    ld [rROMB0], a

    ld c, $08

.lop:
    ld a, [hli]
    ld [de], a
    inc de

    dec c
    jr nz, .lop

    pop af
    ld [rROMB0], a

    ret

Func_3F99: ; 003F99 (00:3F99)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5C1D)
    ld [rROMB0], a

    ld a, $0A
    ld [rRAMG], a

    call Func_03_5C1D

    pop af
    ld [rROMB0], a

    ret

Func_3FAF: ; 003FAF (00:3FAF)
    ld a, [CurrentBank]
    push af

    ld a, $10 ; TODO: BANK(Func_10_4D60)
    ld [rROMB0], a
    call Func_10_4D60

    pop af
    ld [rROMB0], a

    ret

Func_3FC0: ; 003FC0 (00:3FC0)
    ld a, [CurrentBank]
    push af

    ld a, $03 ; TODO: BANK(Func_03_5999)
    ld [rROMB0], a
    call Func_03_5999

    pop af
    ld [rROMB0], a

    ret

    ; ?
    db $3E, $50, $E6, $00
    db $20, $CD, $00, $40
    db $3E, $44, $E6, $00
    db $20, $CD, $00, $40
    db $F1, $E6, $00, $20
    db $C5, $3E, $10, $E6

    ; ?
    db $F5, $E5, $6F, $26
    db $00, $2A, $E1, $EA
    db $00, $20, $F1, $E0
    db $8A, $C9, $01, $22
    db $3E, $80, $22, $C5
