declare name "MoogHalfLadder";
declare description "FAUST Moog Half Ladder 12 dB LPF";
declare author "Eric Tarr";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//------------------`(ve.)moogHalfLadder`-----------------
// Virtual analog model of the 2nd-order Moog Half Ladder (simplified version of
// `(ve.)moogLadder`). Several 1st-order filters are cascaded in series.
// Feedback is then used, in part, to control the cut-off frequency and the
// resonance.
//
// This filter was implemented in Faust by Eric Tarr during the
// [2019 Embedded DSP With Faust Workshop](https://ccrma.stanford.edu/workshops/faust-embedded-19/).
//
// #### References
//
// * <https://www.willpirkle.com/app-notes/virtual-analog-moog-half-ladder-filter>
// * <http://www.willpirkle.com/Downloads/AN-8MoogHalfLadderFilter.pdf>
//
// #### Usage
//
// ```
// _ : moogHalfLadder(normFreq,Q) : _
// ```
//
// Where:
//
// * `normFreq`: normalized frequency (0-1)
// * `Q`: q
//---------------------------------------------------------------------

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.707, 25, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][style:knob]", 1.0, 0.0, 1.0, 0.001):si.smoo;

process = _ : ve.moogHalfLadder(cutoff, q) <:_;