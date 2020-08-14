declare name "DiodeLadder";
declare description "FAUST Diode Ladder 24 dB LPF";
declare author "Christopher Arndt";
declare license "MIT-style STK-4.3 license";

import("stdfaust.lib");

//------------------`diodeLadder`-----------------
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
// Modified by Christopher Arndt to change the cutoff frequency param
// to be given in Hertz instead of normalized 0.0 - 1.0.
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
// * `freq`: cutoff frequency (20-20000 Hz)
// * `Q`: filter Q (0.707 - 25.0)
//---------------------------------------------------------------------
declare diodeLadder author "Eric Tarr";
declare diodeLadder license "MIT-style STK-4.3 license";
diodeLadder(freq,Q) = ef.cubicnl(1,0)*1.5 <:(s1,s2,s3,s4,y)  : !,!,!,!,_
letrec{
  's1 = _-(s4*B4*SG4*k) :
    _-((s4*B4*d3+s3)*B3*SG3*k) :
    _-(((s4*B4*d3+s3)*B3*d2 + s2)*B2*SG3*k) :
    _-((((s4*B4*d3+s3)*B3*d2 + s2)*B2*d1 + s1)*B1*SG1*k) :
    _*alpha0: _*gam1 : _+((s4*B4*d3+s3)*B3*d2 + s2)*B2 : //_+S2
    _+((((s4*B4*d3+s3)*B3*d2 + s2)*B2)*d1 + s1)*B1*G2 : // _ + (S2 ...
    _*a1 : _-s1 :_*alpha*2 : _+s1;

  's2 = _-(s4*B4*SG4*k) :
    _-((s4*B4*d3+s3)*B3*SG3*k) :
    _-(((s4*B4*d3+s3)*B3*d2 + s2)*B2*SG3*k):
    _-((((s4*B4*d3+s3)*B3*d2 + s2)*B2*d1 + s1)*B1*SG1*k) :
    _*alpha0: _*gam1 : _+((s4*B4*d3+s3)*B3*d2 + s2)*B2 : //_+S2
    _+((((s4*B4*d3+s3)*B3*d2 + s2)*B2)*d1 + s1)*B1*G2 : // _ + (S2 ...
    _*a1 : _-s1 :_*alpha : _+s1 : _*gam2 :
    _+(s4*B4*d3 + s3)*B3 : //_+S3 :
    _+(((s4*B4*d3 + s3)*B3)*d2 + s2)*B2*G3 : //_+(S3...)
    _*a2 : _-s2 : _*alpha*2 : _+s2;

  's3 = _-(s4*B4*SG4*k) :
    _-((s4*B4*d3+s3)*B3*SG3*k) :
    _-(((s4*B4*d3+s3)*B3*d2 + s2)*B2*SG3*k) :
    _-((((s4*B4*d3+s3)*B3*d2 + s2)*B2*d1 + s1)*B1*SG1*k) :
    _*alpha0 : _*gam1 : _+((s4*B4*d3+s3)*B3*d2 + s2)*B2 : //_+S2
    _+((((s4*B4*d3+s3)*B3*d2 + s2)*B2)*d1+s1)*B1*G2 : // _ + (S2 ...
    _*a1 : _-s1 :_*alpha : _+s1 : _*gam2 :
    _+(s4*B4*d3 + s3)*B3 : //_+S3 :
    _+(((s4*B4*d3 + s3)*B3)*d2 + s2)*B2*G3 : //_+(S3...)
    _*a2 : _-s2 : _*alpha : _+s2 : _*gam3:
    _+s4*B4 : // _ + S4
    _+((s4*B4)*d3 + s3)*B3*G4: // _ + S4 ...
    _*a3 : _-s3 : _*alpha*2 : _+s3;

  's4 = _-(s4*B4*SG4*k) :
    _-((s4*B4*d3+s3)*B3*SG3*k) :
    _-(((s4*B4*d3+s3)*B3*d2 + s2)*B2*SG3*k) :
    _-((((s4*B4*d3+s3)*B3*d2 + s2)*B2*d1 + s1 )*B1*SG1*k) :
    _*alpha0 : _*gam1 : _+((s4*B4*d3+s3)*B3*d2 + s2)*B2 : //_+S2
    _+((((s4*B4*d3+s3)*B3*d2 + s2)*B2)*d1 + s1)*B1*G2 : // _ + (S2 ...
    _*a1 : _-s1 :_*alpha : _+s1 : _*gam2 :
    _+(s4*B4*d3 + s3)*B3 : //_+S3 :
    _+(((s4*B4*d3 + s3)*B3)  *d2+s2)*B2*G3 : //_+(S3...)
    _*a2 : _-s2 : _*alpha : _+s2 : _*gam3 :
    _+s4*B4 : // _ + S4
    _+((s4*B4)*d3 + s3)*B3*G4: // _ + S4 ...
    _*a3 : _-s3 : _*alpha : _+s3 : _*gam4 : _*a4 : _-s4 : _*alpha*2 : _+s4;

  // Output signal
  'y = _-(s4*B4*SG4*k) :
    _-((s4*B4*d3+s3)*B3*SG3*k) :
    _-(((s4*B4*d3+s3)*B3*d2 + s2)*B2*SG3*k) :
    _-((((s4*B4*d3+s3)*B3*d2 + s2)*B2*d1 + s1 )*B1*SG1*k) :
    _*alpha0: _*gam1 : _+((s4*B4*d3+s3)*B3*d2 + s2)*B2 : //_+S2
    _+((((s4*B4*d3+s3)*B3*d2 + s2)*B2)*d1 + s1)*B1*G2 : // _ + (S2 ...
    _*a1 : _-s1 :_*alpha : _+s1 : _*gam2 :
    _+(s4*B4*d3 + s3)*B3 : //_+S3 :
    _+(((s4*B4*d3 + s3)*B3)*d2 + s2)*B2*G3 : //_+(S3...)
    _*a2 : _-s2 : _*alpha : _+s2 : _*gam3 :
    _+s4*B4 : // _ + S4
    _+((s4*B4)*d3 + s3)*B3*G4: // _ + S4 ...
    _*a3 : _-s3 : _*alpha : _+s3 : _*gam4 : _*a4 : _-s4 : _*alpha : _+s4;
}
with{
  // freq = 2*(10^(3*normFreq+1));
  normFreq = (log10(freq) - log10(2)) / 3.0 - (1.0 / 3.0);
  k = (17 - (normFreq^10)*9.7)*(Q - 0.707)/(25.0 - 0.707);
  wd = 2*ma.PI*freq;
  T = 1/ma.SR;
  wa = (2/T)*tan(wd*T/2);
  g = wa*T/2;
  G4 = 0.5*g/(1 + g);
  G3 = 0.5*g/(1 + g - 0.5*g*G4);
  G2 = 0.5*g/(1 + g - 0.5*g*G3);
  G1 = g/(1.0 + g - g*G2);
  Gamma = G1*G2*G3*G4;
  SG1 = G4*G3*G2; // feedback gain pre-calculated
  SG2 = G4*G3;
  SG3 = G4;
  SG4 = 1;
  alpha = g/(1+g);
  alpha0 = 1/(1+k*Gamma);
  gam1 = 1+G1*G2;
  gam2 = 1+G2*G3;
  gam3 = 1+G3*G4;
  gam4 = 1;
  a1 = 1; // a0 for 1st LPF
  a2 = 0.5; // a0 for 2nd LPF
  a3 = 0.5;
  a4 = 0.5;
  B1 = 1/(1+g-g*G2); // Beta for 1st block
  B2 = 1/(1+g-0.5*g*G3);
  B3 = 1/(1+g-0.5*g*G4);
  B4 = 1/(1+g);
  d1 = g; // delta for 1st block
  d2 = 0.5*g;
  d3 = 0.5*g;
  //d4 = 0;
};

q = hslider("[1]Q[symbol: q][abbrev: q][style:knob]", 1.0, 0.7072, 25.0, 0.01);
cutoff = hslider("[0]Cutoff frequency[symbol: cutoff][abbrev: cutoff][unit: hz][scale: log][style: knob]", 20000.0, 20.0, 20000, 0.1):si.smoo;

process = diodeLadder(cutoff, q);
