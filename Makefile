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
	/usr/bin/yosys -p "synth_ice40 -blif $(MODULE).blif $(YOSYSOPT)" -l $(MODULE).log -q $(RTL_PATH)$(MODULE).v $(DEPS)
	arachne-pnr -d $(MEMORY) -p $(SYNTH_PATH)$(MODULE).pcf $(MODULE).blif -o $(MODULE).pnr
	icepack $(MODULE).pnr $(MODULE).bin

$(MODULE).json: $(MODULE).v $(DEPS)
	yosys -p "prep -top $(MODULE); write_json $(MODULE).json" (MODULE).v $(DEPS)

assets/$(MODULE).svg: $(MODULE).json
	netlistsvg $(MODULE).json -o assets/$(MODULE).svg

upload: $(MODULE).bin
	iceprog $(MODULE).bin

clean:
	rm -f *.bin *.pnr *.blif *.out *.vcd *~

verify_bullet:
	sby -f  formal/bullet.sby
verify_clk_36MHz_generator:
	sby -f  formal/clk_36MHz_generator.sby
verify_edge_detector_debouncer:
	sby -f  formal/edge_detector_debouncer.sby
verify_gameplay:
	sby -f  formal/gameplay.sby
verify_invaders:
	sby -f  formal/invaders.sby
verify_player:
	sby -f  formal/player.sby
verify_ship:
	sby -f  formal/ship.sby
verify_space_invaders_top:
	sby -f  formal/space_invaders_top.sby
verify_sprite_drawer:
	sby -f  formal/sprite_.sby
verify_timer_1us:
	sby -f  formal/timer_1us.sby
verify_tone_generator:
	sby -f  formal/tone_generator.sby
verify_vga_controller:
	sby -f  formal/vga_controller.sby

.PHONY: all clean json svg sim
