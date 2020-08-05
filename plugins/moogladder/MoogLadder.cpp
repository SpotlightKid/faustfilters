
//------------------------------------------------------------------------------
// This file was generated using the Faust compiler (https://faust.grame.fr),
// and the Faust post-processor (https://github.com/jpcima/faustpp).
//
// Source: moogladder.dsp
// Name: MoogLadder
// Author: Christopher Arndt
// Copyright: 
// License: MIT-style STK-4.3 license
// Version: 
//------------------------------------------------------------------------------







#include "MoogLadder.hpp"



#include <utility>
#include <cmath>

class MoogLadder::BasicDsp {
public:
    virtual ~BasicDsp() {}
};

//------------------------------------------------------------------------------
// Begin the Faust code section

namespace {

template <class T> inline T min(T a, T b) { return (a < b) ? a : b; }
template <class T> inline T max(T a, T b) { return (a > b) ? a : b; }

class Meta {
public:
    // dummy
    void declare(...) {}
};

class UI {
public:
    // dummy
    void openHorizontalBox(...) {}
    void openVerticalBox(...) {}
    void closeBox(...) {}
    void declare(...) {}
    void addButton(...) {}
    void addCheckButton(...) {}
    void addVerticalSlider(...) {}
    void addHorizontalSlider(...) {}
    void addVerticalBargraph(...) {}
    void addHorizontalBargraph(...) {}
};

typedef MoogLadder::BasicDsp dsp;

} // namespace

#define FAUSTPP_VIRTUAL // do not declare any methods virtual
#define FAUSTPP_PRIVATE public // do not hide any members
#define FAUSTPP_PROTECTED public // do not hide any members

// define the DSP in the anonymous namespace
#define FAUSTPP_BEGIN_NAMESPACE namespace {
#define FAUSTPP_END_NAMESPACE }


#if defined(__GNUC__)
#   pragma GCC diagnostic push
#   pragma GCC diagnostic ignored "-Wunused-parameter"
#endif

#ifndef FAUSTPP_PRIVATE
#   define FAUSTPP_PRIVATE private
#endif
#ifndef FAUSTPP_PROTECTED
#   define FAUSTPP_PROTECTED protected
#endif
#ifndef FAUSTPP_VIRTUAL
#   define FAUSTPP_VIRTUAL virtual
#endif

#ifndef FAUSTPP_BEGIN_NAMESPACE
#   define FAUSTPP_BEGIN_NAMESPACE
#endif
#ifndef FAUSTPP_END_NAMESPACE
#   define FAUSTPP_END_NAMESPACE
#endif

FAUSTPP_BEGIN_NAMESPACE

#ifndef FAUSTFLOAT
#define FAUSTFLOAT float
#endif 

FAUSTPP_END_NAMESPACE
#include <algorithm>
#include <cmath>
#include <math.h>
FAUSTPP_BEGIN_NAMESPACE

static float mydsp_faustpower2_f(float value) {
	return (value * value);
}
static float mydsp_faustpower3_f(float value) {
	return ((value * value) * value);
}
static float mydsp_faustpower4_f(float value) {
	return (((value * value) * value) * value);
}

#ifndef FAUSTCLASS 
#define FAUSTCLASS mydsp
#endif

#ifdef __APPLE__ 
#define exp10f __exp10f
#define exp10 __exp10
#endif

class mydsp : public dsp {
	
 FAUSTPP_PRIVATE:
	
	int fSampleRate;
	float fConst0;
	FAUSTFLOAT fHslider0;
	float fRec5[2];
	FAUSTFLOAT fHslider1;
	float fRec1[2];
	float fRec2[2];
	float fRec3[2];
	float fRec4[2];
	
 public:
	
	void metadata(Meta* m) { 
		m->declare("../../faust/moogladder.dsp/moogLadder:author", "Eric Tarr");
		m->declare("../../faust/moogladder.dsp/moogLadder:license", "MIT-style STK-4.3 license");
		m->declare("author", "Christopher Arndt");
		m->declare("description", "FAUST Moog Ladder 24 dB LPF");
		m->declare("filename", "moogladder.dsp");
		m->declare("license", "MIT-style STK-4.3 license");
		m->declare("maths.lib/author", "GRAME");
		m->declare("maths.lib/copyright", "GRAME");
		m->declare("maths.lib/license", "LGPL with exception");
		m->declare("maths.lib/name", "Faust Math Library");
		m->declare("maths.lib/version", "2.3");
		m->declare("name", "MoogLadder");
		m->declare("platform.lib/name", "Generic Platform Library");
		m->declare("platform.lib/version", "0.1");
		m->declare("signals.lib/name", "Faust Signal Routing Library");
		m->declare("signals.lib/version", "0.0");
	}

	FAUSTPP_VIRTUAL int getNumInputs() {
		return 1;
	}
	FAUSTPP_VIRTUAL int getNumOutputs() {
		return 1;
	}
	FAUSTPP_VIRTUAL int getInputRate(int channel) {
		int rate;
		switch ((channel)) {
			case 0: {
				rate = 1;
				break;
			}
			default: {
				rate = -1;
				break;
			}
		}
		return rate;
	}
	FAUSTPP_VIRTUAL int getOutputRate(int channel) {
		int rate;
		switch ((channel)) {
			case 0: {
				rate = 1;
				break;
			}
			default: {
				rate = -1;
				break;
			}
		}
		return rate;
	}
	
	static void classInit(int sample_rate) {
	}
	
	FAUSTPP_VIRTUAL void instanceConstants(int sample_rate) {
		fSampleRate = sample_rate;
		fConst0 = (3.14159274f / std::min<float>(192000.0f, std::max<float>(1.0f, float(fSampleRate))));
	}
	
	FAUSTPP_VIRTUAL void instanceResetUserInterface() {
		fHslider0 = FAUSTFLOAT(20000.0f);
		fHslider1 = FAUSTFLOAT(1.0f);
	}
	
	FAUSTPP_VIRTUAL void instanceClear() {
		for (int l0 = 0; (l0 < 2); l0 = (l0 + 1)) {
			fRec5[l0] = 0.0f;
		}
		for (int l1 = 0; (l1 < 2); l1 = (l1 + 1)) {
			fRec1[l1] = 0.0f;
		}
		for (int l2 = 0; (l2 < 2); l2 = (l2 + 1)) {
			fRec2[l2] = 0.0f;
		}
		for (int l3 = 0; (l3 < 2); l3 = (l3 + 1)) {
			fRec3[l3] = 0.0f;
		}
		for (int l4 = 0; (l4 < 2); l4 = (l4 + 1)) {
			fRec4[l4] = 0.0f;
		}
	}
	
	FAUSTPP_VIRTUAL void init(int sample_rate) {
		classInit(sample_rate);
		instanceInit(sample_rate);
	}
	FAUSTPP_VIRTUAL void instanceInit(int sample_rate) {
		instanceConstants(sample_rate);
		instanceResetUserInterface();
		instanceClear();
	}
	
	FAUSTPP_VIRTUAL mydsp* clone() {
		return new mydsp();
	}
	
	FAUSTPP_VIRTUAL int getSampleRate() {
		return fSampleRate;
	}
	
	FAUSTPP_VIRTUAL void buildUserInterface(UI* ui_interface) {
		ui_interface->openVerticalBox("MoogLadder");
		ui_interface->declare(&fHslider0, "0", "");
		ui_interface->declare(&fHslider0, "abbrev", "cutoff");
		ui_interface->declare(&fHslider0, "scale", "log");
		ui_interface->declare(&fHslider0, "style", "knob");
		ui_interface->declare(&fHslider0, "symbol", "cutoff");
		ui_interface->declare(&fHslider0, "unit", "hz");
		ui_interface->addHorizontalSlider("Cutoff frequency", &fHslider0, 20000.0f, 20.0f, 20000.0f, 0.100000001f);
		ui_interface->declare(&fHslider1, "1", "");
		ui_interface->declare(&fHslider1, "abbrev", "q");
		ui_interface->declare(&fHslider1, "style", "knob");
		ui_interface->declare(&fHslider1, "symbol", "q");
		ui_interface->addHorizontalSlider("Q", &fHslider1, 1.0f, 0.707199991f, 25.0f, 0.00999999978f);
		ui_interface->closeBox();
	}
	
	FAUSTPP_VIRTUAL void compute(int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) {
		FAUSTFLOAT* input0 = inputs[0];
		FAUSTFLOAT* output0 = outputs[0];
		float fSlow0 = (0.00100000005f * float(fHslider0));
		float fSlow1 = (0.0411641225f * (float(fHslider1) + -0.707000017f));
		for (int i = 0; (i < count); i = (i + 1)) {
			fRec5[0] = (fSlow0 + (0.999000013f * fRec5[1]));
			float fTemp0 = std::tan((fConst0 * fRec5[0]));
			float fTemp1 = (3.9000001f - (0.899999976f * std::pow((0.0f - (0.333333343f * (1.0f - (std::log10(fRec5[0]) + -0.30103001f)))), 0.200000003f)));
			float fTemp2 = (fTemp0 + 1.0f);
			float fTemp3 = ((fTemp0 * (((float(input0[i]) - (fSlow1 * (fTemp1 * (((fRec1[1] + (fRec2[1] * fTemp0)) + (mydsp_faustpower2_f(fTemp0) * fRec3[1])) + (mydsp_faustpower3_f(fTemp0) * fRec4[1]))))) / ((fSlow1 * (fTemp1 * mydsp_faustpower4_f(fTemp0))) + 1.0f)) - fRec4[1])) / fTemp2);
			float fTemp4 = ((fTemp0 * ((fRec4[1] + fTemp3) - fRec3[1])) / fTemp2);
			float fTemp5 = ((fTemp0 * ((fRec3[1] + fTemp4) - fRec2[1])) / fTemp2);
			float fTemp6 = ((fTemp0 * ((fRec2[1] + fTemp5) - fRec1[1])) / fTemp2);
			float fRec0 = (fRec1[1] + fTemp6);
			fRec1[0] = (fRec1[1] + (2.0f * fTemp6));
			fRec2[0] = (fRec2[1] + (2.0f * fTemp5));
			fRec3[0] = (fRec3[1] + (2.0f * fTemp4));
			fRec4[0] = (fRec4[1] + (2.0f * fTemp3));
			output0[i] = FAUSTFLOAT(fRec0);
			fRec5[1] = fRec5[0];
			fRec1[1] = fRec1[0];
			fRec2[1] = fRec2[0];
			fRec3[1] = fRec3[0];
			fRec4[1] = fRec4[0];
		}
	}

};
FAUSTPP_END_NAMESPACE


#if defined(__GNUC__)
#   pragma GCC diagnostic pop
#endif



//------------------------------------------------------------------------------
// End the Faust code section




MoogLadder::MoogLadder()
{

    mydsp *dsp = new mydsp;
    fDsp.reset(dsp);
    dsp->instanceResetUserInterface();

}

MoogLadder::~MoogLadder()
{
}

void MoogLadder::init(float sample_rate)
{

    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    dsp.classInit(sample_rate);
    dsp.instanceConstants(sample_rate);
    clear();

}

void MoogLadder::clear() noexcept
{

    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    dsp.instanceClear();

}

void MoogLadder::process(
    const float *in0,
    float *out0,
    unsigned count) noexcept
{

    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    float *inputs[] = {
        const_cast<float *>(in0),
    };
    float *outputs[] = {
        out0,
    };
    dsp.compute(count, inputs, outputs);

}

const char *MoogLadder::parameter_label(unsigned index) noexcept
{
    switch (index) {
    
    case 0:
        return "Cutoff frequency";
    
    case 1:
        return "Q";
    
    default:
        return 0;
    }
}

const char *MoogLadder::parameter_short_label(unsigned index) noexcept
{
    switch (index) {
    
    case 0:
        return "cutoff";
    
    case 1:
        return "q";
    
    default:
        return 0;
    }
}

const char *MoogLadder::parameter_symbol(unsigned index) noexcept
{
    switch (index) {
    
    case 0:
        return "cutoff";
    
    case 1:
        return "q";
    
    default:
        return 0;
    }
}

const char *MoogLadder::parameter_unit(unsigned index) noexcept
{
    switch (index) {
    
    case 0:
        return "hz";
    
    case 1:
        return "";
    
    default:
        return 0;
    }
}

const MoogLadder::ParameterRange *MoogLadder::parameter_range(unsigned index) noexcept
{
    switch (index) {
    
    case 0: {
        static const ParameterRange range = { 20000, 20, 20000 };
        return &range;
    }
    
    case 1: {
        static const ParameterRange range = { 1, 0.70719999, 25 };
        return &range;
    }
    
    default:
        return 0;
    }
}

bool MoogLadder::parameter_is_trigger(unsigned index) noexcept
{
    switch (index) {
    
    default:
        return false;
    }
}

bool MoogLadder::parameter_is_boolean(unsigned index) noexcept
{
    switch (index) {
    
    default:
        return false;
    }
}

bool MoogLadder::parameter_is_integer(unsigned index) noexcept
{
    switch (index) {
    
    default:
        return false;
    }
}

bool MoogLadder::parameter_is_logarithmic(unsigned index) noexcept
{
    switch (index) {
    
    case 0:
        return true;
    
    default:
        return false;
    }
}

float MoogLadder::get_parameter(unsigned index) const noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    switch (index) {
    
    case 0:
        return dsp.fHslider0;
    
    case 1:
        return dsp.fHslider1;
    
    default:
        (void)dsp;
        return 0;
    }
}

void MoogLadder::set_parameter(unsigned index, float value) noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    switch (index) {
    
    case 0:
        dsp.fHslider0 = value;
        break;
    
    case 1:
        dsp.fHslider1 = value;
        break;
    
    default:
        (void)dsp;
        (void)value;
        break;
    }
}


float MoogLadder::get_cutoff() const noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    return dsp.fHslider0;
}

float MoogLadder::get_q() const noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    return dsp.fHslider1;
}


void MoogLadder::set_cutoff(float value) noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    dsp.fHslider0 = value;
}

void MoogLadder::set_q(float value) noexcept
{
    mydsp &dsp = static_cast<mydsp &>(*fDsp);
    dsp.fHslider1 = value;
}




