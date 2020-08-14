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
// Modified by Christopher Arndt to change the cutoff frequency param
// to be given in Hertz instead of normalized 0.0 - 1.0.
//
// #### Filter history:
//
// <https://secretlifeofsynthesizers.com/the-korg-35-filter/>
//========================================================================================

//------------------`korg35HPF`-----------------
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
// * `freq`: cutoff frequency (20-20000 Hz)
// * `Q`: q (0.5 - 10.0)
//---------------------------------------------------------------------
declare korg35HPF author "Eric Tarr";
declare korg35HPF license "MIT-style STK-4.3 license";
korg35HPF(freq,Q) = _ <: (s1,s2,s3,y) : !,!,!,_
letrec{
    's1 = _-s1:_*(alpha*2):_+s1;
    's2 = _<:(_-s1:_*alpha:_+s1)*-1,_:>_+(s3*B3):_+(s2*B2):_*alpha0:_*K:_-s2:_*alpha*2:_+s2;
    's3 = _<:(_-s1:_*alpha:_+s1)*-1,_:>_+(s3*B3):_+(s2*B2):_*alpha0:_*K:_<:(_-s2:_*alpha:_+s2)*-1,_:>_-s3:_*alpha*2:_+s3;
    'y = _<:(_-s1:_*alpha:_+s1)*-1,_:>_+(s3*B3):_+(s2*B2):_*alpha0;
}
with{
    // freq = 2*(10^(3*normFreq+1));
    K = 2.0*(Q - 0.707)/(10.0 - 0.707);
    wd = 2*ma.PI*freq;
    T = 1/ma.SR;
    wa = (2/T)*tan(wd*T/2);
    g = wa*T/2;
    G = g/(1.0 + g);
    alpha = G;
    B3 = 1.0/(1.0 + g);
    B2 = -1.0*G/(1.0 + g);
    alpha0 = 1/(1 - K*G + K*G*G);
};

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.5, 10.0, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][unit: hz][scale: log][style: knob]", 20000.0, 20.0, 20000, 0.1):si.smoo;

process = korg35HPF(cutoff, q);
