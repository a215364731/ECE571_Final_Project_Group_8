TARGET = i_type


all: vlog vsim

vlog:
	vlog tb.sv ../../rtl/$(TARGET).sv

vsim:
	vsim -c -do "run -all" -sv_seed random work.$(TARGET)_tb

clean:
	rm -rf work transcript