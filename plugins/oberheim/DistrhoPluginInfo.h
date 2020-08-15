/*
 * Oberheim multi-mode filter audio effect based on DISTRHO Plugin Framework (DPF)
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

#ifndef DISTRHO_PLUGIN_INFO_H
#define DISTRHO_PLUGIN_INFO_H

#define DISTRHO_PLUGIN_BRAND "chrisarndt.de"
#define DISTRHO_PLUGIN_NAME  "Oberheim Multi-Mode Filter"
#define DISTRHO_PLUGIN_URI   "https://chrisarndt.de/plugins/faustfilters#oberheim"

#define DISTRHO_PLUGIN_HAS_UI        0
#define DISTRHO_UI_USE_NANOVG        0

#define DISTRHO_PLUGIN_IS_RT_SAFE       1
#define DISTRHO_PLUGIN_NUM_INPUTS       1
#define DISTRHO_PLUGIN_NUM_OUTPUTS      4
#define DISTRHO_PLUGIN_WANT_TIMEPOS     0
#define DISTRHO_PLUGIN_WANT_PROGRAMS    1
#define DISTRHO_PLUGIN_WANT_MIDI_INPUT  0
#define DISTRHO_PLUGIN_WANT_MIDI_OUTPUT 0

// Most hosts will only recognize the first (alphabetically) category :(
//#define DISTRHO_PLUGIN_LV2_CATEGORY "lv2:BandpassPlugin, lv2:BandstopPlugin, lv2:HighpassPlugin, lv2:LowpassPlugin"
#define DISTRHO_PLUGIN_LV2_CATEGORY "lv2:LowpassPlugin"

#endif // DISTRHO_PLUGIN_INFO_H
