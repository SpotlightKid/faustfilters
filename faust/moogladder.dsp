declare name "moogladder";
declare description "FAUST Moog Ladder 24 dB LPF";
declare author "Christopher Arndt";

import("stdfaust.lib");

q = hslider("q", 1, 0.75, 25, 0.01);
cutoff_freq = hslider("cutoff", 1, 0, 1, 0.001):si.smoo;

process = _ : ve.moogLadder(cutoff_freq, q) <:_;
