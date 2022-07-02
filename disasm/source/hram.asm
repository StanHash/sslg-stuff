
    section "FF8D", hram[$FF8D]

hUnkFF8D:: db ; FF8D
hUnkFF8E:: db ; FF8E

    section "FF9F", hram[$FF9F]

hCgbMark:: db ; FF9F

    section "FFA0", hram[$FFA0]

hOamDmaFunc:: ds $0F
hOamDmaFuncEnd::

    section "FFCB", hram[$FFCB]

hHeldKeys:: db ; FFCB
hNewKeys:: db ; FFCC

    section "FFFE", hram[$FFFE]

hUnkFFFE:: db
