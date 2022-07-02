
dba: macro
    dw BANK(\1)
    dw \1
    endm

dab: macro
    dw \1
    dw BANK(\1)
    endm
