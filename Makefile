# call with make MODULE=moduleName sim|svg|upload

TOP:=space_invaders_top

ifndef $(MODULE)
	MODULE=$(TOP)
endif
ifeq ($(MODULE), $(TOP))
  DEPS:=\
    vga_controller.v \
    sprite_drawer.v \
    gameplay.v \
    ship.v \
	edge_detector_debouncer.v \
	timer_1us.v \
	player.v \
	invaders.v \
	clk_36MHz_generator.v \
	bullet.v

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


$(MODULE)_tb.vcd: $(MODULE).v $(DEPS) $(MODULE)_tb.v  $(AUXFILES)

	iverilog $^ -o $(MODULE)_tb.out
	./$(MODULE)_tb.out
	gtkwave $@ $(MODULE)_tb.gtkw &

$(MODULE).bin: $(MODULE).pcf $(MODULE).v $(DEPS) $(AUXFILES)
	yosys -p "synth_ice40 -blif $(MODULE).blif $(YOSYSOPT)"\
              -l $(MODULE).log -q $(MODULE).v $(DEPS)
	arachne-pnr -d $(MEMORY) -p $(MODULE).pcf $(MODULE).blif -o $(MODULE).pnr
	icepack $(MODULE).pnr $(MODULE).bin

$(MODULE).json: $(MODULE).v $(DEPS)
	yosys -p "prep -top $(MODULE); write_json $(MODULE).json" $(MODULE).v $(DEPS)

assets/$(MODULE).svg: $(MODULE).json
	netlistsvg $(MODULE).json -o assets/$(MODULE).svg

upload: $(MODULE).bin
	iceprog $(MODULE).bin

clean:
	rm -f *.bin *.pnr *.blif *.out *.vcd *~

verify_ship:
	sby -f  ship.sby
verify_bullet:
	sby -f  bullet.sby
verify_edge_detector_debouncer:
	sby -f  edge_detector_debouncer.sby
verify_player:
	sby -f  player.sby
verify_invaders:
	sby -f  invaders.sby

.PHONY: all clean json svg sim

