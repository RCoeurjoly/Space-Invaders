# call with make MODULE=moduleName sim|svg|upload

TOP:=space_invaders_top

ifndef $(MODULE)
	MODULE=$(TOP)
endif
ifeq ($(MODULE), $(TOP))
  DEPS:=\
    rtl/vga_controller.v \
    rtl/sprite_drawer.v \
    rtl/gameplay.v \
    rtl/ship.v \
	rtl/edge_detector_debouncer.v \
	rtl/timer_1us.v \
	rtl/player.v \
	rtl/invaders.v \
	rtl/clk_36MHz_generator.v \
	rtl/bullet.v

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


$(MODULE)_tb.vcd: rtl/$(MODULE).v $(DEPS) sim/$(MODULE)_tb.v  $(AUXFILES)

	iverilog $^ -o $(MODULE)_tb.out
	./$(MODULE)_tb.out
	gtkwave $@ $(MODULE)_tb.gtkw &

$(MODULE).bin: syn/$(MODULE).pcf rtl/$(MODULE).v $(DEPS) $(AUXFILES)
	yosys -p "synth_ice40 -blif $(MODULE).blif $(YOSYSOPT)"\
              -l $(MODULE).log -q rtl/$(MODULE).v $(DEPS)
	arachne-pnr -d $(MEMORY) -p syn/$(MODULE).pcf $(MODULE).blif -o $(MODULE).pnr
	icepack $(MODULE).pnr $(MODULE).bin

$(MODULE).json: rtl/$(MODULE).v $(DEPS)
	yosys -p "prep -top $(MODULE); write_json $(MODULE).json" rtl/$(MODULE).v $(DEPS)

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
