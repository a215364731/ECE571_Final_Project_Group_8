TARGET = i_type


all: vlog vsim

vlog:
	vlog tb.sv ../../rtl/$(TARGET).sv

vsim:
	vsim -c -do "run -all" work.$(TARGET)_tb

clean:
	rm -rf work transcript