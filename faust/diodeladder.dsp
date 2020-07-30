declare name "DiodeLadder";
declare description "FAUST Diode Ladder 24 dB LPF";
declare author "Eric Tarr";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//------------------`(ve.)diodeLadder`-----------------
// 4th order virtual analog diode ladder filter. In addition to the individual
// states used within each independent 1st-order filter, there are also additional
// feedback paths found in the block diagram. These feedback paths are labeled
// as connecting states. Rather than separately storing these connecting states
// in the Faust implementation, they are simply implicitly calculated by
// tracing back to the other states (s1,s2,s3,s4) each recursive step.
//
// This filter was implemented in Faust by Eric Tarr during the
// [2019 Embedded DSP With Faust Workshop](https://ccrma.stanford.edu/workshops/faust-embedded-19/).
//
// #### References
//
// * <https://www.willpirkle.com/virtual-analog-diode-ladder-filter/>
// * <http://www.willpirkle.com/Downloads/AN-6DiodeLadderFilter.pdf>
//
// #### Usage
//
// ```
// _ : diodeLadder(normFreq,Q) : _
// ```
//
// Where:
//
// * `normFreq`: normalized frequency (0-1)
// * `Q`: q
//---------------------------------------------------------------------

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.707, 25, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][style:knob]", 1.0, 0.0, 1.0, 0.001):si.smoo;

process = _ : ve.diodeLadder(cutoff, q) <:_;
