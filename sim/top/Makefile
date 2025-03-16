
all: vlog vsim

vlog:
	vlog tb.sv ../../rtl/*.sv

vsim:
	vsim -c -do "run -all" work.top_tb

clean:
	rm -rf work transcript