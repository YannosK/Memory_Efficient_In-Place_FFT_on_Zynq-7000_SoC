# System Verilog HDL rewrite

Here I keep track of the progress of rewriting the FFT IP core.

***Newly written hdl SystemVerilog modules***

- [ ] top level ip
  - [x] system memory (**must be active high reset**)
  - [x] twiddle rom
  - [x] processing element (_the following need the order shown_)
    - [x] shifter
      - [x] shift_unit 
    - [x] butterfly processor
      - [x] stage 0
      - [x] stage 1
      - [x] stage 2
    - [x] rounder
      - [x] rounding unit
    - [x] limiter
      - [x] limits_unit
    - [x] shamt_producer
        - [x] shamt_unit
          - [x] 8 bit section
          - [x] 16 bit section
    - [x] shamt decider
  - [ ] address generation unit (AGU)
  - [ ] control unit
  - [ ] register file
    - [x] data input dual registers
    - [ ] shift amount register with compare
    - [ ] shifts count register
- [ ] interfaces of top level module
  - [ ] BRAM ports
  - [ ] AXI4-Lite Memory mapped interfaces


***Newly written hdl correspondance with old vhdl design***

- [x] top level module
    - [x] r0 & r1 regs
    - [ ] shamt reg
    - [ ] shamt reg-compare
    - [ ] shift counter
    - [x] system memory
    - [x] twiddle rom
    - [x] processing element
      - [x] shift unit
      - [x] butterfly processor
        - [x] multiplier
        - [x] shift-reg
      - [x] rounding unit
      - [x] shamt generate unit
      - [x] shamt decide unit _maybe same with reg compare_
    - [ ] address generation unit
      - [ ] pair - stage counter
    - [ ] control unit
      - [ ] sync stage


## Things that might be wrong
- This multiplier instantiation
- the pairbits in AGU
- the data multiplexers and demultiplexers
- the rom array might not be initialized correctly
  - careful with twiddle length and path
  - might need a .data file with strict vector form
  - might need reg instead of logic and no fancy custom types
  - might need to be a verilog no a SystemVerilog file as described [here](https://docs.amd.com/r/en-US/ug901-vivado-synthesis/Initializing-Block-RAM-From-an-External-Data-File-Verilog) (Vivado bullshit)

## Internal widths

Here is a small list of the bits needed for data representation

- start with 8bit
- extend to 9bit for 1-shift
- twiddle real/imag is 16bits
- multiplication width is 16+9 = 25bits in 4-21 format 
- **Warning**: after the multiplier - internal width - we do not need the extra bit so we truncate it and end up with 24bits in 3-21 format
- rounding at the 24-3-6 = 15: we keep 15 and from 14 downto 0 we cut. End up with a 9bit in 3-6
- after the limits unit we trunc the one extra bit and end up with a 8bit in 2-6 (initial memory conf)

So the relations are:

```SystemVerilog

// parameters
wordlen = 32
romwordlen = 32

// constants for design
width = wordlen / 4 // number width
twidwidth = romwordlen / 2 //  twiddle number width  
width_fractionals = width - 2 // number of fractionals
twidwidth_fractionals = twidwidth - 2 // number of twiddle factor fractionals


// inside the PE
shiftwidth = width + 1 // one bit added in the shifter
multwidth = shiftwidth + twidwidth // the multiplication width
intrwidth = multwidth - 1 // internal width
roundbit = intrwidth - 3 - 6 // the bit we round
```

