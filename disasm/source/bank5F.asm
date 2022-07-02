    include "include/macro/data.inc"

    section "bank5F", romx, bank[$5F]

Data_5F_4000:
    dw $60, $5BA8 ; bg pal
    dw $5F, $4554 ; ob pal
    dw $60, $51B4
    dw $5F, $4594
    dw $5F, $45C8
    dw $60, 0
    dw $60, 0
    dw $5F, $452A ; tile attr
    dw $5F, $4500 ; tile map
    dw $60, $4000
    dw $60, $4400
    dw $60, $4D18
    dw $60, $51A4
    dw $0160, $0070
    dw $0040, $0010
    dw $0400, $0000
    dw $61, $576C
    dw $5F, $4554
    dw $61, $4EA8
    dw $5F, $4594
