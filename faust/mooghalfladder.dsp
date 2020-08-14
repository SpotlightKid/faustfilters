declare name "MoogHalfLadder";
declare description "FAUST Moog Half Ladder 12 dB LPF";
declare author "Eric Tarr";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//------------------`moogHalfLadder`-----------------
// Virtual analog model of the 2nd-order Moog Half Ladder (simplified version of
// `(ve.)moogLadder`). Several 1st-order filters are cascaded in series.
// Feedback is then used, in part, to control the cut-off frequency and the
// resonance.
//
// This filter was implemented in Faust by Eric Tarr during the
// [2019 Embedded DSP With Faust Workshop](https://ccrma.stanford.edu/workshops/faust-embedded-19/).
//
// Modified by Christopher Arndt to change the cutoff frequency param
// to be given in Hertz instead of normalized 0.0 - 1.0.
//
// #### References
//
// * <https://www.willpirkle.com/app-notes/virtual-analog-moog-half-ladder-filter>
// * <http://www.willpirkle.com/Downloads/AN-8MoogHalfLadderFilter.pdf>
//
// #### Usage
//
// ```
// _ : moogHalfLadder(freq,Q) : _
// ```
//
// Where:
//
// * `freq`: cutoff frequency (20-20000 Hz)
// * `Q`: filter Q (0.707 - 25.0)
//---------------------------------------------------------------------
declare moogHalfLadder author "Eric Tarr";
declare moogHalfLadder license "MIT-style STK-4.3 license";
moogHalfLadder(freq,Q) = _ <: (s1,s2,s3,y) : !,!,!,_
letrec{
  's1 = -(s3*B3*k):-(s2*B2*k):-(s1*B1*k):*(alpha0):-(s1):*(alpha*2):+(s1);
  's2 = -(s3*B3*k):-(s2*B2*k):-(s1*B1*k):*(alpha0):-(s1):*(alpha):+(s1):-(s2):*(alpha*2):+(s2);
  's3 = -(s3*B3*k):-(s2*B2*k):-(s1*B1*k):*(alpha0):-(s1):*(alpha):+(s1):-(s2):*(alpha):+(s2):-(s3):*(alpha*2):+(s3);
  'y = -(s3*B3*k):-(s2*B2*k):-(s1*B1*k):*(alpha0):-(s1):*(alpha):+(s1):-(s2):*(alpha):+(s2) <:_*-1,((-(s3):*(alpha):+(s3))*2):>_;
}
with{
  // freq = 2*(10^(3*normFreq+1));
  normFreq = (log10(freq) - log10(2)) / 3.0 - (1.0 / 3.0);
  k = 2.0*(Q - 0.707)/(25.0 - 0.707);
  wd = 2*ma.PI*freq;
  T = 1/ma.SR;
  wa = (2/T)*tan(wd*T/2);
  g = wa*T/2;
  G = g/(1.0 + g);
  alpha = G;
  GA = 2*G-1; // All-pass gain
  B1 = GA*G/(1+g);
  B2 = GA/(1+g);
  B3 = 2/(1+g);
  alpha0 = 1/(1 + k*GA*G*G);
};

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.707, 25, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][unit: hz][scale: log][style: knob]", 20000.0, 20.0, 20000, 0.1):si.smoo;

process = moogHalfLadder(cutoff, q);
