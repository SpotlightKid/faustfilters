declare name "MoogLadder";
declare description "FAUST Moog Ladder 24 dB LPF";
declare author "Christopher Arndt";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//------------------`moogLadder`-----------------
// Virtual analog model of the 4th-order Moog Ladder, which is arguably the
// most well-known ladder filter in analog synthesizers. Several
// 1st-order filters are cascaded in series. Feedback is then used, in part, to
// control the cut-off frequency and the resonance.
//
// This filter was implemented in Faust by Eric Tarr during the
// [2019 Embedded DSP With Faust Workshop](https://ccrma.stanford.edu/workshops/faust-embedded-19/).
//
// Modified by Christopher Arndt to change the cutoff frequency param
// to be given in Hertz instead of normalized 0.0 - 1.0.
//
// #### References
//
// * <https://www.willpirkle.com/706-2/>
// * <http://www.willpirkle.com/Downloads/AN-4VirtualAnalogFilters.pdf>
//
// #### Usage
//
// ```
// _ : moogLadder(normFreq,Q) : _
// ```
//
// Where:
//
// * `freq`: cutoff frequency (20-20000 Hz)
// * `Q`: q (0.707 - 25.0)
//---------------------------------------------------------------------
declare moogLadder author "Eric Tarr";
declare moogLadder license "MIT-style STK-4.3 license";
moogLadder(freq,Q) = _<:(s1,s2,s3,s4,y) : !,!,!,!,_
letrec{
    's1 = -(s4*k):-(s3*g*k):-(s2*g*g*k):-(s1*g*g*g*k):*(A):-(s1):*(B*2):+(s1);
    's2 = -(s4*k):-(s3*g*k):-(s2*g*g*k):-(s1*g*g*g*k):*(A):-(s1):*(B):+(s1):-(s2):*(B*2):+(s2);
    's3 = -(s4*k):-(s3*g*k):-(s2*g*g*k):-(s1*g*g*g*k):*(A):-(s1):*(B):+(s1):-(s2):*(B):+(s2):-(s3):*(B*2):+(s3);
    's4 = -(s4*k):-(s3*g*k):-(s2*g*g*k):-(s1*g*g*g*k):*(A):-(s1):*(B):+(s1):-(s2):*(B):+(s2):-(s3):*(B):+(s3):-(s4):*(B*2):+(s4);
    'y = -(s4*k):-(s3*g*k):-(s2*g*g*k):-(s1*g*g*g*k):*(A):-(s1):*(B):+(s1):-(s2):*(B):+(s2):-(s3):*(B):+(s3):-(s4):*(B):+(s4);
}
with{
    // freq = 2*(10^(3*normFreq+1));
    normFreq = (log10(freq) - log10(2)) / 3.0 - (1.0 / 3.0);
    k = (3.9 - (normFreq^0.2)*0.9)*(Q - 0.707)/(25.0 - 0.707);
    //k = 3.9*(Q - 0.707)/(25.0 - 0.707);
    wd = 2*ma.PI*freq;
    T = 1/ma.SR;
    wa = (2/T)*tan(wd*T/2);
    g = wa*T/2;
    G = g*g*g*g;
    A = 1/(1+(k*G));
    B = g/(1+g);
};

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.7072, 25, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][unit: hz][scale: log][style: knob]", 20000.0, 20.0, 20000, 0.1):si.smoo;

process = moogLadder(cutoff, q);
