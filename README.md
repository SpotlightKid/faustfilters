# FAUST filters

A collection of virtual-analog filters from the [FAUST] standard library
packaged as multi-format plugins via the [DPF].


## Plugins

All plugins are mono, i.e. they have one audio input and output, unless noted
otherwise. They all have two (automatable) parameters:

* Cutoff / center frequency in Hertz (`20.0 - 20,000.0`)
* Q factor (range varies)


### Diode Ladder

A diode ladder 24 dB lowpass filter


### Korg 35 HPF

A Korg 35 24 dB high pass filter as found in the MS-10 and early MS-20s


### Korg 35 LPF

A Korg 35 24 dB low pass filter as found in the MS-10 and early MS-20s


### Moog Ladder LPF

A Moog ladder-style 24 dB low pass filter


### Moog Half Ladder LPF

A Moog ladder-style 12 dB low pass filter


### Oberheim Multi-mode Filter

A multi-mode, state-variable filter as found in Oberheim synthesizers

This filter has four outputs:

* Bandstop
* Bandpass
* Highpass
* Lowpass


## Formats

All plugins in this collection come in the following plug-in formats:

* LADSPA
* LV2
* VST2


## Compiling

Make sure you have installed the required build tools and libraries (see
section "Prerequisites" below) and then clone this repository (including
sub-modules) and simply run `make` in the project's root directory:

    $ git clone --recursive https://github.com/SpotlightKid/faustfilters.git
    $ cd faustfilters
    $ make


## Installation

To install all plugin formats to their appropriate system-wide location, run
the following command:

    make install

The makfiles support the usual `PREFIX` and `DESTDIR` variables to change the
installation prefix and set an installation root directory (defaulty: empty).
`PREFIX` defaults to `/usr/local`, but on macOS and Windows it is not used,
since the system-wide installation directories for plugins are fixed.

There is also an `install-user` target, to install the binaries in the proper
locations under the current user's home directory.

    make -n install-user

shows you where the files would get installed, without actually doing so.


## Prerequisites

* The GCC C++ compiler, library and the usual associated software build tools
  (`make`, etc.).

  Debian / Ubuntu users should install the `build-essential` package
  to get these.

* [pkgconf]

* The [faustpp] pre-processor (optional)

The [LV2], [LADSPA] and [VST2] (vestige) headers are included in the [DPF]
framework, which is integrated as a Git sub-module. These need not be
installed separately to build the software in the respective plug-in formats.

`faustpp` is only needed to re-generate C++ source and headers files if
the FAUST DSP source files in the `faust` directory are changed.


## Author

This software project was put together by *Christopher Arndt*.


## Acknowledgements

The idea for this project was inspired by the [poly_filters] LV2 plugin
collection.

The DSP code is generated from the FAUST sources via the [faustpp]
pre-processor.

The project is built using the DISTRHO Plugin Framework ([DPF]) and set up
with the [cookiecutter-dpf-effect] project template (with additional
customization).


[cookiecutter-dpf-effect]: https://github.com/SpotlightKid/cookiecutter-dpf-effect
[DPF]: https://github.com/DISTRHO/DPF
[FAUST]: https://faust.grame.fr/
[faustpp]: https://github.com/jpcima/faustpp.git
[LADSPA]: http://www.ladspa.org/
[LV2]: http://lv2plug.in/
[pkgconf]: https://github.com/pkgconf/pkgconf
[poly_filters]: https://github.com/polyeffects/poly_filters.git
[VST2]: https://en.wikipedia.org/wiki/Virtual_Studio_Technology
