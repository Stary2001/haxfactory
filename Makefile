.PHONY: all eur usa

################################################################################
all: eur usa
eur: build/eur/stage0_qr.png build/eur/haxfactory.bin
usa: build/usa/stage0_qr.png build/usa/haxfactory.bin
clean:
	rm -rf build/

### STAGE 0 (QR CODE + INITIAL ROP) ############################################
build/eur/stage0.elf: DEFINES := -DEUR
build/usa/stage0.elf: DEFINES := -DUSA

build/%/stage0.elf: src/stage0.s
	mkdir -p $(dir $@)
	arm-none-eabi-gcc -x assembler-with-cpp -nostartfiles -nostdlib -g -o $@ $< $(DEFINES)

build/%/stage0.bin: build/%/stage0.elf
	arm-none-eabi-objcopy -O binary $< $@

build/%/stage0_qr.bin: build/%/stage0.bin
	python3 ./scripts/make_qr.py $< $@

### STAGE 1 (MORE ROP) #########################################################
build/eur/stage1.elf: DEFINES := -DEUR
build/usa/stage1.elf: DEFINES := -DUSA

build/%/stage1.elf: src/stage1.s
	mkdir -p $(dir $@)
	arm-none-eabi-gcc -x assembler-with-cpp -nostartfiles -nostdlib -g -o $@ $< $(DEFINES) -I3ds_ropkit

build/%/stage1.bin: build/%/stage1.elf
	arm-none-eabi-objcopy -O binary $< $@

### EXPLOIT OUTPUTS ############################################################
build/%/stage0_qr.png: build/%/stage0_qr.bin
	mkdir -p $(dir $@)
	qrencode -8 -o $@ < $<

build/%/haxfactory.bin: build/%/stage1.bin
	cat $^ > $@
	#xxd $@
