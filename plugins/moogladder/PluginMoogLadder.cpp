/*
 * Moog Ladder LPF audio effect based on DISTRHO Plugin Framework (DPF)
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

#include "PluginMoogLadder.hpp"

START_NAMESPACE_DISTRHO

// -----------------------------------------------------------------------

PluginMoogLadder::PluginMoogLadder()
    : Plugin(paramCount, presetCount, 0)  // paramCount param(s), presetCount program(s), 0 states
{
    flt = new MoogLadder;
    fSampleRate = getSampleRate();

    for (unsigned p = 0; p < paramCount; ++p) {
        Parameter param;
        initParameter(p, param);
        setParameterValue(p, param.ranges.def);
    }
}

PluginMoogLadder::~PluginMoogLadder() {
    delete flt;
}

// -----------------------------------------------------------------------
// Init

void PluginMoogLadder::initParameter(uint32_t index, Parameter& parameter) {
    if (index >= paramCount)
        return;

    const MoogLadder::ParameterRange* range = flt->parameter_range(index);
    parameter.name = flt->parameter_label(index);
    parameter.shortName = flt->parameter_short_label(index);
    parameter.symbol = flt->parameter_symbol(index);
    parameter.unit = flt->parameter_unit(index);
    parameter.ranges.min = range->min;
    parameter.ranges.max = range->max;
    parameter.ranges.def = range->init;
    parameter.hints = kParameterIsAutomable;

    if (flt->parameter_is_boolean(index))
        parameter.hints |= kParameterIsBoolean;
    if (flt->parameter_is_integer(index))
        parameter.hints |= kParameterIsInteger;
    if (flt->parameter_is_logarithmic(index))
        parameter.hints |= kParameterIsLogarithmic;
    if (flt->parameter_is_trigger(index))
        parameter.hints |= kParameterIsTrigger;
}

/**
  Set the name of the program @a index.
  This function will be called once, shortly after the plugin is created.
*/
void PluginMoogLadder::initProgramName(uint32_t index, String& programName) {
    if (index < presetCount) {
        programName = factoryPresets[index].name;
    }
}

// -----------------------------------------------------------------------
// Internal data

/**
  Optional callback to inform the plugin about a sample rate change.
*/
void PluginMoogLadder::sampleRateChanged(double newSampleRate) {
    fSampleRate = newSampleRate;
    flt->init(newSampleRate);
}

/**
  Get the current value of a parameter.
*/
float PluginMoogLadder::getParameterValue(uint32_t index) const {
    return fParams[index];
}

/**
  Change a parameter value.
*/
void PluginMoogLadder::setParameterValue(uint32_t index, float value) {
    const MoogLadder::ParameterRange* range = flt->parameter_range(index);
    fParams[index] = value;
    flt->set_parameter(index, CLAMP(value, range->min, range->max));
}

/**
  Load a program.
  The host may call this function from any context,
  including realtime processing.
*/
void PluginMoogLadder::loadProgram(uint32_t index) {
    if (index < presetCount) {
        for (int i=0; i < paramCount; i++) {
            setParameterValue(i, factoryPresets[index].params[i]);
        }
    }
}

// -----------------------------------------------------------------------
// Process

void PluginMoogLadder::activate() {
    // plugin is activated
    fSampleRate = getSampleRate();
    flt->init(fSampleRate);
}

void PluginMoogLadder::run(const float** inputs, float** outputs, uint32_t frames) {
    flt->process(inputs[0], outputs[0], (unsigned)frames);
}

// -----------------------------------------------------------------------

Plugin* createPlugin() {
    return new PluginMoogLadder();
}

// -----------------------------------------------------------------------

END_NAMESPACE_DISTRHO
