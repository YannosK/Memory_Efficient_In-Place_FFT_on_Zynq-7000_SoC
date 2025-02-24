# old design

- [x] top level module
    - [ ] r0 & r1 regs
    - [ ] shamt reg
    - [ ] shamt reg-compare
    - [ ] shift counter
    - [x] system memory
    - [x] twiddle rom
    - [ ] processing element
      - [ ] shift unit
      - [ ] butterfly processor
        - [ ] multiplier
        - [ ] shift-reg
      - [x] rounding unit
      - [ ] shamt generate unit
      - [ ] shamt decide unit _maybe same with reg compare_
    - [ ] address generation unit
      - [ ] pair - stage counter
    - [ ] control unit
      - [ ] sync stage

# new design

**Active low reset, even if BRAM has active high reset!!!**

- [ ] interfaces
- [ ] top level ip
  - [x] system memory (**must be active high reset**)
  - [x] twiddle rom
  - [ ] processing element (_the following need the order shown_)
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
    - [ ] shamt decider

## Things that might be wrong
- This multiplier instantiation


# Internal widths

- start with 8bit
- extend to 9bit for 1-shift
- twiddle real/imag is 16bits
- multiplication width is 16+9 = 25bits in 4-21 format 
- **Warning**: after the multiplier - internal width - we do not need the extra bit so we truncate it and end up with 24bits in 3-21 format
- rounding at the 24-3-6 = 15: we keep 15 and from 14 downto 0 we cut. End up with a 9bit in 3-6
- after the limits unit we trunc the one extra bit and end up with a 8bit in 2-6 (initial memory conf)

So the relations are

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

