
    rsreset
sprite_enable     rb 1 ; bool enabled
sprite_y          rw 1 ; y offset
sprite_x          rw 1 ; x offset
sprite_frame      rb 1 ; frame id
sprite_attributes rb 1 ; base attributes (minus palette)
sprite_tile       rb 1 ; base tile number
sprite_08         rb 1 ; ?
sprite_palette    rb 1 ; palette, also contains vram bank bit?
sprite_0A         rb 1 ; ?
sprite_0B         rb 1
    rsset _RS + $0D - $0C
sprite_0D         rb 1
    rsset _RS + $0F - $0E
sprite_id         rb 1 ; sprite id
sprite_10         rb 1
sprite_11         rb 1
sprite_flip       rb 1 ; bool flipped
    rsset _RS + $1C - $13
sprite_1C rb 1 ; ?
sprite_1D rw 1 ; ?
sprite_1F rw 1
sprite_21 rw 1
sprite_23 rw 1
    rsset _RS + $27 - $25
sprite_27 rb 1 ; bank
sprite_28 rw 1 ; addr
sprite_2A rw 1 ; addr to graphics?
sprite_2C rb 1 ; bank to graphics?
sprite_2D rw 1 ; addr to vram?
sprite_2F rw 1 ; addr?
sprite_31 rb 1 ; bank?
sprite_32 rb 1 ; ?
    rsset _RS + $40 - $33
sprite_sizeof     rb 0
