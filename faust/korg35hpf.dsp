declare name "Korg35HPF";
declare description "FAUST Korg 35 24 dB HPF";
declare author "Eric Tarr";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//===================================Korg 35 Filters======================================
// The following filters are virtual analog models of the Korg 35 low-pass
// filter and high-pass filter found in the MS-10 and MS-20 synthesizers.
// The virtual analog models for the LPF and HPF are different, making these
// filters more interesting than simply tapping different states of the same
// circuit.
//
// These filters were implemented in Faust by Eric Tarr during the
// [2019 Embedded DSP With Faust Workshop](https://ccrma.stanford.edu/workshops/faust-embedded-19/).
//
// #### Filter history:
//
// <https://secretlifeofsynthesizers.com/the-korg-35-filter/>
//========================================================================================

//------------------`(ve.)korg35HPF`-----------------
// Virtual analog models of the Korg 35 high-pass filter found in the MS-10 and
// MS-20 synthesizers.
//
// #### Usage
//
// ```
// _ : korg35HPF(normFreq,Q) : _
// ```
//
// Where:
//
// * `normFreq`: normalized frequency (0-1)
// * `Q`: q
//---------------------------------------------------------------------

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.5, 10.0, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][style:knob]", 0.0, 0.0, 1.0, 0.001):si.smoo;

process = _ : ve.korg35HPF(cutoff, q) <:_;
