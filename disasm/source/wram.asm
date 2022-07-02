    include "include/struct/sprite.inc"

    ; lo wram

    section "C001", wram0[$C001]

wUnkC001:: db
wUnkC002:: db
wUnkC003:: db
wUnkC004:: dw ; addr
wUnkC006:: db ; bank
wUnkC007:: db
wUnkC008:: db
wUnkC009:: db
wUnkC00A:: db
wUnkC00B:: db
wUnkC00C:: db ; dl?
wUnkC00D:: db
wUnkC00E:: db
wUnkC00F:: db
wUnkC010:: db
wUnkC011:: db

    ds 2

wUnkC014:: db ; bool?

    section "C01F", wram0[$C01F]

wUnkC01F:: db

    section "C021", wram0[$C021]

wUnkC021:: db
wUnkC022:: db
wUnkC023:: db
wUnkC024:: db

    ds 1

wUnkC026:: db
wUnkC027:: db

    ds 1

wUnkC029:: db
wUnkC02A:: db
wUnkC02B:: db
wUnkC02C:: db

    ds 1

wRefreshTileMapA:: db
wUnkC02F:: db
wFrameCountLo:: db
wPrevFrameCount:: db
wFrameCountHi:: db

    ds 1

wUnkC034:: db
wUnkC035:: db
wUnkC036:: db
wUnkC037:: db

    section "C041", wram0[$C041]

wUnkC041:: db

    section "C055", wram0[$C055]

wUnkC055:: dw ; addr

    ds 1

wUnkC058:: db
wUnkC059:: db
wUnkC05A:: db

    ds 2

wUnkC05D:: db
wRefreshObPal:: db
wRefreshBgPal:: db
wUnkC060:: db ; stat interrupt kind?
wUnkC061:: db
wUnkC062:: db

    ds 1

wUnkC064:: db

    section "C06B", wram0[$C06B]

wUnkC06B:: db
wUnkC06C:: db
wUnkC06D:: db ; ob pal id

    ds 2

wUnkC070:: db
wUnkC071:: db
wUnkC072:: db
wUnkC073:: db
wUnkC074:: db
wUnkC075:: db
wUnkC076:: db
wUnkC077:: db

    ds 1

wUnkC079:: db
wUnkC07A:: db
wUnkC07B:: db

    section "C080", wram0[$C080]

wUnkC080:: db
wUnkC081:: db
wUnkC082:: dw ; addr to entry list
wUnkC084:: db ; bank
wUnkC085:: dw

    ds 2

wUnkC089:: db ; length
wUnkC08A:: db ; sprite x?
wUnkC08B:: db

    ds 3

wUnkC08F:: db ; cursor kind? (0 = map cursor, 1 = menu cursor)

    section "C0B0", wram0[$C0B0]

wUnkC0B0:: db
wUnkC0B1:: db

    section "C0C2", wram0[$C0C2]

wUnkC0C2:: db
wUnkC0C3:: db
wUnkC0C4:: db
wUnkC0C5:: db

    ds 1

wUnkC0C7:: db
wUnkC0C8:: db
wUnkC0C9:: db
wUnkC0CA:: db
wUnkC0CB:: db
wUnkC0CC:: db

    ds 3

wUnkC0D0:: db

    ds 2

wUnkC0D3:: db
wUnkC0D4:: db
wUnkC0D5:: db

    ds 1

wUnkC0D7:: ds 7 ; TODO: size of wUnkC0D7
wUnkC0DE:: db
wUnkC0DF:: db
wUnkC0E0:: db
wUnkC0E1:: db
wUnkC0E2:: db
wUnkC0E3:: db
wUnkC0E4:: db
wUnkC0E5:: db
wUnkC0E6:: db
wUnkC0E7:: db
wUnkC0E8:: db

    section "C0F0", wram0[$C0F0]

wUnkC0F0:: db
wUnkC0F1:: db
wUnkC0F2:: db
wUnkC0F3:: db
wUnkC0F4:: db
wUnkC0F5:: db
wUnkC0F6:: db
wUnkC0F7:: db
wUnkC0F8:: db
wUnkC0F9:: db

    section "C100", wram0[$C100]

wCursorScreenY:: db
wCursorScreenX:: db
wUnkC102:: db ; sprite id sub?
wUnkC103:: db
wUnkC104:: db ; sprite id main?
wUnkC105:: db

    ds 1

wUnkC107:: db

    section "C10F", wram0[$C10F]

wCompareResult:: db
wUnkC110:: dw ; addr
wUnkC112:: db
wUnkC113:: db

    ds 2

wUnkC116:: db

    ds 2

wCursorSpriteY:: db
wCursorSpriteX:: db
wUnkC11B:: db
wOamCount:: db ; object id

    section "C13A", wram0[$C13A]

wUnkC13A:: db
wUnkC13B:: db
wUnkC13C:: db
wUnkC13D:: db
wUnkC13E:: db

    section "C147", wram0[$C147]

wUnkC147:: dw ; addr
wUnkC149:: db ; bank

    section "C16F", wram0[$C16F]

wUnkC16F:: db
wUnkC170:: db

    section "C173", wram0[$C173]

wUnkC173:: db
wUnkC174:: db
wUnkC175:: db

    ds 1

wUnkC177:: db
wUnkC178:: db ; bool?
wUnkC179:: dw ; addr
wUnkC17B:: db ; bank
wUnkC17C:: db
wUnkC17D:: db
wUnkC17E:: db ; bank
wUnkC17F:: db
wUnkC180:: db
wUnkC181:: db

    ds 5

wUnkC187:: db
wUnkC188:: db
wUnkC189:: db
wUnkC18A:: db
wUnkC18B:: db

    section "C1A0", wram0[$C1A0]

wUnkC1A0:: db

    section "C1C0", wram0[$C1C0]

wUnkC1C0:: db
wUnkC1C1:: db
wUnkC1C2:: db

    section "C200", wram0[$C200]

wUnkC200:: dw ; addr
wUnkC202:: db ; bank
wUnkC203:: dw ; vram tilemap addr

    ds 2

wUnkC207:: db
wUnkC208:: dw ; y position?
wUnkC20A:: dw ; x position?
wUnkC20C:: db
wUnkC20D:: dw

    ds 1

wUnkC210:: dw
wUnkC212:: dw
wUnkC214:: db
wUnkC215:: db
wUnkC216:: db
wUnkC217:: db
wUnkC218:: db
wUnkC219:: db
wUnkC21A:: db

    ds 1

wUnkC21C:: dw
wUnkC21E:: dw

    section "C266", wram0[$C266]

wUnkC266:: dw
wUnkC268:: dw

    section "C270", wram0[$C270]

wUnkC270:: db

    section "C2B0", wram0[$C2B0]

wUnkC2B0:: db
wUnkC2B1:: db
wText:: dw ; addr
wTextBank:: db ; bank
wUnkC2B5:: dw ; vram b1 addr
wUnkC2B7:: db
wUnkC2B8:: db ; some frame counter?

    ds 1

wTextCharsetChrBank:: db ; bank
wTextCharsetChr:: dw ; addr
wUnkC2BD:: db
wUnkC2BE:: dw ; vram addr
wUnkC2C0:: db
wUnkC2C1:: db
wUnkC2C2:: db
wUnkC2C3:: db
wUnkC2C4:: db
wUnkC2C5:: db
wUnkC2C6:: db
wUnkC2C7:: db
wUnkC2C8:: db
wUnkC2C9:: db ; some WX
wUnkC2CA:: db ; some WY

    ds 1

wUnkC2CC:: db
wUnkC2CD:: db

    section "C2D0", wram0[$C2D0]

wUnkC2D0:: ds 8

    section "C300", wram0[$C300]

wUnkC300:: ds $40 ; TODO: STRUCT_C300_SIZE

    section "C350", wram0[$C350]

wUnkC350:: db
wUnkC351:: db
wUnkC352:: db

    section "C360", wram0[$C360]

wUnkC360:: db
wUnkC361:: db
wOamIt:: dw ; oam buf addr
wUnkC364:: dw ; addr
wUnkC366:: dw ; sprite scroll y
wUnkC368:: dw ; sprite scroll x
wUnkC36A:: db

    section "C370", wram0[$C370]

wCursorY:: dw
wCursorX:: dw

    section "C380", wram0[$C380]

wCameraY:: dw
wCameraX:: dw
wUnkC384:: db
wUnkC385:: db
wUnkC386:: db
wUnkC387:: db

    section "C390", wram0[$C390]

wSCX:: db
wSCY:: db
wWX:: db
wWY:: db
wRefreshScroll:: db
wUnkC395:: dw
wUnkC397:: dw
wUnkC399:: db
wUnkC39A:: db

    section "C3A0", wram0[$C3A0]

wUnkC3A0:: dw ; addr
wUnkC3A2:: db
wUnkC3A3:: db
wUnkC3A4:: db
wUnkC3A5:: db
wUnkC3A6:: db
wUnkC3A7:: db
wUnkC3A8:: db
wUnkC3A9:: db
wUnkC3AA:: db
wUnkC3AB:: db

    section "C3B3", wram0[$C3B3]

wUnkC3B3:: db
wUnkC3B4:: dw

    ds 1

wUnkC3B7:: db
wUnkC3B8:: db
wUnkC3B9:: db
wUnkC3BA:: db

    section "C400", wram0[$C400]

wUnkC400:: db
wUnkC401:: db ; sprite y
wUnkC402:: db ; sprite x

    ds 4

wUnkC407:: dw
wUnkC409:: dw ; offset within wSprites
wUnkC40B:: db ; sprite tile number
wUnkC40C:: db ; sprite attributes
wUnkC40D:: db

    section "C432", wram0[$C432]

wUnkC432:: db
wUnkC433:: db

    ds 1

wUnkC435:: db
wUnkC436:: db

    section "C437", wram0[$C437]

wUnkC437:: dw ; some counter that counts down

    section "C43B", wram0[$C43B]

wUnkC43B:: dw
wUnkC43D:: db
wUnkC43E:: db
wRefreshOam:: db
wUnkC440:: db
wUnkC441:: db

    section "C446", wram0[$C446]

wUnkC446:: db
wUnkC447:: db
wUnkC448:: db
wUnkC449:: db

    section "C481", wram0[$C481]

wUnkC481:: db
wUnkC482:: dw

    section "C48F", wram0[$C48F]

wUnkC48F:: db
wUnkC490:: db

    section "C49C", wram0[$C49C]

wUnkC49C:: db

    section "C580", wram0[$C580]

wUnkC580:: ds 2*1 ; array of addrs/offsets

    section "C600", wram0[$C600], align[8]

wOam:: ds $A0 ; OAM buf

    section "C700", wram0[$C700]

wUnkC700:: ds sprite_sizeof

    section "C780", wram0[$C780]

wUnkC780:: ds $80

    section "C800", wram0[$C800]

wBgPalBuf:: ds $40 ; bg palettes
wObPalBuf:: ds $40 ; obj palettes
wObPalBufB:: ds $40 ; obj palettes

    section "C8C5", wram0[$C8C5]

wUnkC8C5:: db
wUnkC8C6:: db

    section "C8EE", wram0[$C8EE]

wUnkC8EE:: ds 1

    section "C907", wram0[$C907]

wUnkC907:: db

    section "C90F", wram0[$C90F]

wUnkC90F:: db

    ds 5

wUnkC915:: db
wUnkC916:: db

    section "C91E", wram0[$C91E]

wUnkC91E:: db

    section "C932", wram0[$C932]

wUnkC932:: db

    section "C957", wram0[$C957]

wUnkC957:: db

    section "CA27", wram0[$CA27]

wUnkCA27:: db

    section "CF00", wram0[$CF00]

wStack:: ds $100

    ; hi wram
    ; this would normally be banked but this game doesn't seem to make use of that feature

    section "D000", wram0[$D000]

wTileAttrA:: ds $400
wTileMapA:: ds $400

    section "D800", wram0[$D800]

wUnkD800:: db

    section "DB00", wram0[$DB00], align[6]

wSprites::
wSprite0:: ds sprite_sizeof
wSprite1:: ds sprite_sizeof
wSprite2:: ds sprite_sizeof
wSprite3:: ds sprite_sizeof
wSprite4:: ds sprite_sizeof
wSprite5:: ds sprite_sizeof
wSprite6:: ds sprite_sizeof
wSprite7:: ds sprite_sizeof

    section "DE00", wram0[$DE00]

wUnkDE00:: ds 1
