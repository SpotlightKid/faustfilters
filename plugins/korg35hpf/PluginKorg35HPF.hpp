/*
 * Korg 35 HPF audio effect based on DISTRHO Plugin Framework (DPF)
 *
 * SPDX-License-Identifier: MIT
 *
 * Copyright (C) 2020 Christopher Arndt <info@chrisarndt.de>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

#ifndef PLUGIN_KORG35HPF_H
#define PLUGIN_KORG35HPF_H

#include "DistrhoPlugin.hpp"
#include "Korg35HPF.hpp"

START_NAMESPACE_DISTRHO

#ifndef MIN
#define MIN(a,b) ( (a) < (b) ? (a) : (b) )
#endif

#ifndef MAX
#define MAX(a,b) ( (a) > (b) ? (a) : (b) )
#endif

#ifndef CLAMP
#define CLAMP(v, min, max) (MIN((max), MAX((min), (v))))
#endif


// -----------------------------------------------------------------------

class PluginKorg35HPF : public Plugin {
public:
    enum Parameters {
        paramCutoff = 0,
        paramQ,
        paramCount
    };

    PluginKorg35HPF();

    ~PluginKorg35HPF();

protected:
    // -------------------------------------------------------------------
    // Information

    const char* getLabel() const noexcept override {
        return "Korg 35 HPF";
    }

    const char* getDescription() const override {
        return "A Korg 35 24 dB high pass filter as found in the MS-10 and early MS-20s";
    }

    const char* getMaker() const noexcept override {
        return "chrisarndt.de";
    }

    const char* getHomePage() const override {
        return DISTRHO_PLUGIN_URI;
    }

    const char* getLicense() const noexcept override {
        return "https://spdx.org/licenses/MIT";
    }

    uint32_t getVersion() const noexcept override {
        return d_version(0, 3, 0);
    }

    // Go to:
    //
    // http://service.steinberg.de/databases/plugin.nsf/plugIn
    //
    // Get a proper plugin UID and fill it in here!
    int64_t getUniqueId() const noexcept override {
        return d_cconst('P', 'f', 'K', 'H');
    }

    // -------------------------------------------------------------------
    // Init

    void initParameter(uint32_t index, Parameter& parameter) override;
    void initProgramName(uint32_t index, String& programName) override;

    // -------------------------------------------------------------------
    // Internal data

    float getParameterValue(uint32_t index) const override;
    void setParameterValue(uint32_t index, float value) override;
    void loadProgram(uint32_t index) override;

    // -------------------------------------------------------------------
    // Optional

    // Optional callback to inform the plugin about a sample rate change.
    void sampleRateChanged(double newSampleRate) override;

    // -------------------------------------------------------------------
    // Process

    void activate() override;

    void run(const float**, float** outputs, uint32_t frames) override;

    // -------------------------------------------------------------------

private:
    float           fParams[paramCount];
    double          fSampleRate;
    Korg35HPF*     flt;

    DISTRHO_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(PluginKorg35HPF)
};

struct Preset {
    const char* name;
    float params[PluginKorg35HPF::paramCount];
};

const Preset factoryPresets[] = {
    {
        "Default",
        {20000.0f, 1.0f}
    }
    //,{
    //    "Another preset",  // preset name
    //    {-14.0f, ...}      // array of presetCount float param values
    //}
};

const uint presetCount = sizeof(factoryPresets) / sizeof(Preset);

// -----------------------------------------------------------------------

END_NAMESPACE_DISTRHO

#endif  // #ifndef PLUGIN_KORG35HPF_H
