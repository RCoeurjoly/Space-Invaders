# call with make MODULE=moduleName sim|svg|upload

TOP:=space_invaders_top
PATH:=~/Space-Invaders/
FORMAL_PATH:=$(PATH)formal/
RTL_PATH:=$(PATH)rtl/
SIM_PATH:=$(PATH)sim/
SYNTH_PATH:=$(PATH)syn/

ifndef $(MODULE)
	MODULE=$(TOP)
endif
ifeq ($(MODULE), $(TOP))
  DEPS:=\
    $(RTL_PATH)vga_controller.v \
    $(RTL_PATH)sprite_drawer.v \
    $(RTL_PATH)gameplay.v \
    $(RTL_PATH)ship.v \
	$(RTL_PATH)edge_detector_debouncer.v \
	$(RTL_PATH)timer_1us.v \
	$(RTL_PATH)player.v \
	$(RTL_PATH)invaders.v \
	$(RTL_PATH)clk_36MHz_generator.v \
	$(RTL_PATH)bullet.v

FORMAL:=\
    ship.v \
    bullet.v
#   AUXFILES:=\
# 	const.vh

# YOSYSOPT:=-retime -abc2
endif

ifndef $(MEMORY)
	MEMORY="1k"
endif

all: bin
bin: $(MODULE).bin
sim: $(MODULE)_tb.vcd
json: $(MODULE).json
svg: assets/$(MODULE).svg


$(MODULE)_tb.vcd: $(RTL_PATH)$(MODULE).v $(DEPS) $(SIM_PATH)$(MODULE)_tb.v  $(AUXFILES)

	iverilog $^ -o $(MODULE)_tb.out
	./$(MODULE)_tb.out
	gtkwave $@ $(MODULE)_tb.gtkw &

$(MODULE).bin: $(SYNTH_PATH)$(MODULE).pcf $(RTL_PATH)$(MODULE).v $(DEPS) $(AUXFILES)
	/usr/local/bin/yosys -p "synth_ice40 -blif $(MODULE).blif $(YOSYSOPT)" -l $(MODULE).log -q $(RTL_PATH)$(MODULE).v $(DEPS)
	/usr/local/bin/arachne-pnr -d $(MEMORY) -p $(SYNTH_PATH)$(MODULE).pcf $(MODULE).blif -o $(MODULE).pnr
	/usr/local/bin/icepack $(MODULE).pnr $(MODULE).bin

$(MODULE).json: $(MODULE).v $(DEPS)
	/usr/bin/yosys -p "prep -top $(MODULE); write_json $(MODULE).json" (MODULE).v $(DEPS)

assets/$(MODULE).svg: $(MODULE).json
	netlistsvg $(MODULE).json -o assets/$(MODULE).svg

upload: $(MODULE).bin
	/usr/local/bin/iceprog $(MODULE).bin

clean:
	/bin/rm -f *.bin *.pnr *.blif *.out *.vcd *~

verify_bullet:
	/usr/local/bin/sby -f  formal/bullet.sby
verify_clk_36MHz_generator:
	/usr/local/bin/sby -f  formal/clk_36MHz_generator.sby
verify_edge_detector_debouncer:
	/usr/local/bin/sby -f  formal/edge_detector_debouncer.sby
verify_gameplay:
	/usr/local/bin/sby -f  formal/gameplay.sby
verify_invaders:
	/usr/local/bin/sby -f  formal/invaders.sby
verify_player:
	/usr/local/bin/sby -f  formal/player.sby
verify_ship:
	/usr/local/bin/sby -f  formal/ship.sby
verify_space_invaders_top:
	/usr/local/bin/sby -f  formal/space_invaders_top.sby
verify_sprite_drawer:
	/usr/local/bin/sby -f  formal/sprite_.sby
verify_timer_1us:
	/usr/local/bin/sby -f  formal/timer_1us.sby
verify_tone_generator:
	/usr/local/bin/sby -f  formal/tone_generator.sby
verify_vga_controller:
	/usr/local/bin/sby -f  formal/vga_controller.sby

.PHONY: all clean json svg sim
