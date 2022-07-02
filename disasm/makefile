RGBDS ?=

RGBASM ?= $(RGBDS)rgbasm
RGBFIX ?= $(RGBDS)rgbfix
RGBGFX ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

INCLIST := tools/inclist/inclist

TARGET := sslg.gbc

SOURCES := \
  source/home.asm \
  source/bank01.asm \
  source/bank5F.asm \
  data/sprite-objects.asm \
  source/sram.asm \
  source/wram.asm \
  source/hram.asm \
  source/vram.asm

OBJECTS := $(SOURCES:.asm=.obj)

compare: $(TARGET) vanilla.gbc
	python3 tools/script/compare.py $(TARGET:.gbc=.map) vanilla.gbc $(TARGET)

.PHONY: compare

clean:
	rm -f $(OBJECTS) $(TARGET) $(TARGET:.gbc=.map) $(TARGET:.gbc=.sym)

RGBLINKFLAGS := -w
RGBFIXFLAGS := -v

$(TARGET): $(OBJECTS)
	$(RGBLINK) $(RGBLINKFLAGS) -n $(TARGET:.gbc=.sym) -m $(TARGET:.gbc=.map) -o $(TARGET) $(OBJECTS)
	$(RGBFIX) $(RGBFIXFLAGS) $(TARGET)

RGBASMFLAGS := -Weverything -E -L

define AsmRule
$1: $2 $$(shell $$(INCLIST) $2)
	$$(RGBASM) $$(RGBASMFLAGS) -o $$@ $$<
endef

$(foreach source, $(SOURCES), $(eval $(call AsmRule,$(source:.asm=.obj),$(source))))

%.2bpp: %.png
	$(RGBGFX) -o $@ $<
