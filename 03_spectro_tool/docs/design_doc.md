# Interactive CQT Spectrogram Analyzer — Design Document

## Overview

This application is a single-page HTML/WebAudio visualization tool inspired by FFmpeg’s `showcqt` filter.

It:

* loads audio files directly in-browser
* performs spectral analysis
* renders a continuously updating spectrogram
* estimates dominant pitches
* overlays musical note bubbles
* supports interactive scrub playback
* allows tuning adjustments
* exports detected notes
* provides realtime transport/playback controls

The system is intentionally designed as:

* dependency-light
* GPU-friendly
* incrementally rendered
* interactive during analysis
* visually musical rather than purely scientific

---

# Functional Requirements

## 1. Audio Loading

### Supported formats

The browser decoder supports:

* WAV
* MP3
* FLAC (browser dependent)
* OGG
* AAC/M4A (browser dependent)

### UI

Topbar contains:

* file picker
* analyze button

### Workflow

1. User selects file
2. Audio decoded with WebAudio API
3. PCM buffer extracted
4. Spectral processing begins

---

# 2. Spectrogram Rendering

## Rendering Style

The spectrogram:

* spans entire page
* left = start time
* right = end time
* bottom = low pitch
* top = high pitch

Background:

```text
#454545
```

Rendering uses:

* additive translucent vertical energy bands
* logarithmic frequency scaling
* note-based colour mapping
* glow-based intensity rendering

---

## Spectrogram Pipeline

### FFT Parameters

```text
FFT size: 4096
Hop size: 1024
```

### Windowing

Each frame is Hann-windowed before FFT:

```text
0.5 * (1 - cos(...))
```

This reduces spectral leakage.

---

## Frequency Scaling

Y-axis uses logarithmic pitch scaling:

```text
y = log2(freq)
```

This creates musically proportional spacing.

---

## Frequency Range

Lower bound:

```text
G1 (~49Hz)
```

Upper bound:

```text
8000Hz
```

This intentionally removes:

* inaudible rumble
* unnecessary sub-bass
* excess empty low-end space

---

# 3. Colour Mapping System

## Goal

Colours encode:

* pitch class
* octave intensity
* musical identity

Rather than using scientific rainbow palettes.

---

## Pitch-Class Mapping

| Pitch | Colour                           |
| ----- | -------------------------------- |
| C     | Peach / gold                     |
| D     | Navy blue                        |
| E     | Lavender above A440, brown below |
| F     | Yellow (#F5D954)                 |
| G     | Greens by octave                 |
| A     | Red                              |
| B     | Sky blue                         |

---

## G-Octave Rules

| Octave Region        | Colour            |
| -------------------- | ----------------- |
| Below middle region  | Dark bottle green |
| Near tuning A region | Lawn green        |
| Above                | Lime green        |

---

## Intensity Rendering

Brightness slider affects:

* alpha/intensity only

It does NOT:

* desaturate colours
* recolour spectrum

---

# 4. Progressive Rendering

## Requirement

Spectrogram must reveal:

```text
left → right
```

while processing.

NOT:

* compressed afterward
* rescaled during analysis

---

## Implementation

Column width computed before processing:

```text
fixedColumnWidth = canvas.width / totalFrames
```

Each FFT frame:

1. analyzed
2. immediately rendered
3. painted into offscreen canvas

This creates:

* stable positioning
* progressive reveal
* no leftward compression artifacts

---

# 5. Pitch Detection

## Current Method

Simplified dominant-bin analysis:

* strongest FFT bin selected
* converted to frequency
* mapped to note name

---

## Tuning System

Pitch calculations use configurable tuning reference:

```text
A = 440
A = 432
Custom future support possible
```

---

## Tuning Offset

Additional semitone offset slider:

```text
-12 to +12 semitones
```

Used for:

* non-standard tunings
* tape drift correction
* historical pitch systems

---

# 6. Bubble Overlay System

## Purpose

Bubble overlays provide:

* human-readable note summaries
* musical landmarks
* scrub interaction targets

---

## Placement

Bubble row positioned:

```text
near lower third / C2 region
```

Not centered vertically.

---

## Bubble Types

### Inactive Bubbles

Collapsed mini rounded rectangles:

* blue
* compact
* persistent

These indicate note-event positions.

---

### Active Bubble

When scrubber approaches:

* expands horizontally
* turns orange
* raises visual prominence
* displays note label

---

## Bubble Density Reduction

To avoid clutter:

* repeated nearby notes merged
* minimum spacing threshold applied
* pitch changes prioritized

This restores:

* phrase-like clustering
* sparse meaningful events

---

# 7. Scrubber System

## Vertical Scrubber

Mouse movement creates:

* full-height vertical line
* orange transport indicator

---

## Scrubber Bubble

Top hover bubble displays:

* timestamp
* current detected pitch
* pitch colour swatch

Bubble constrained onscreen:

* never clipped
* always fully visible

Positioned:

```text
below topbar
```

---

# 8. Playback System

## Transport Controls

Centered topbar controls:

* Play/Pause toggle
* Stop
* Restart

---

## Playback Behaviour

When playback active:

* scrubber follows audio
* clicking timeline seeks
* playback continues after seek

---

## Scrub Preview

Mouse dragging:

* previews nearby audio
* plays short snippets
* allows spectral auditioning

---

# 9. Timeline System

Bottom timeline contains:

* small ticks every second
* larger ticks every 10 seconds
* mm:ss labels

---

# 10. C Markers

Horizontal markers for every C note:

```text
C0–C8
```

Middle C (`c4`) emphasized:

* bold text
* rounded border

---

# 11. Export System

Current export:

```text
CSV note list
```

Includes:

* timestamps
* note labels
* frequencies

Planned:

* MIDI export
* Lilypond export

---

# 12. Processing Feedback

Status line displays:

* frames processed
* elapsed seconds
* estimated remaining time

Realtime updated during analysis.

---

# 13. Offscreen Rendering Architecture

## Main Canvases

### Visible canvas

Handles:

* overlays
* bubbles
* scrubber
* timeline

### Offscreen spectrogram canvas

Handles:

* spectral painting only

This separation prevents:

* redraw flicker
* overlay corruption
* expensive repainting

---

# 14. Performance Strategy

## Current Optimizations

### Cached FFT Results

Spectrogram data retained for:

* brightness redraws
* tuning redraws

without re-analysis.

---

### Incremental Async Processing

Uses:

```js
await new Promise(r=>setTimeout(r,0))
```

to keep UI responsive.

---

### Offscreen Composition

Reduces:

* overdraw
* repaint cost
* layout thrashing

---

# 15. Current Limitations

## Pitch Detection

Current implementation:

* monophonic dominant-frequency estimation

Not yet:

* true polyphonic decomposition
* harmonic clustering
* probabilistic tracking

---

## FFT Implementation

Current FFT:

* naive O(N²)

Not optimized.

Recommended future:

* KissFFT
* Meyda
* FFT.js
* WASM FFT backend

---

## Spectral Analysis

Currently:

* FFT-based approximation

Not true:

```text
Constant-Q Transform
```

Future:

* real logarithmic CQT bins
* harmonic templates
* note-energy aggregation

---

# 16. Planned Future Enhancements

## Analysis

### True CQT

Musically aligned frequency bins.

### Harmonic Smoothing

Fundamental extraction from overtone stacks.

### Polyphonic Tracking

Multiple simultaneous notes.

### Onset Detection

Attack/transient localization.

---

## Export

### MIDI

Realtime note-event export.

### Lilypond

Score-oriented export.

### JSON Session Save

Persist overlays/settings.

---

## Rendering

### GPU WebGL Spectrogram

Higher resolution realtime rendering.

### Zoom + Pan

Detailed navigation.

### Multi-layer overlays

Separate melody/chord layers.

---

# 17. UI Philosophy

The application intentionally avoids:

* scientific rainbow palettes
* DAW complexity
* dense labeling

Instead emphasizing:

* musical readability
* ambient visualization
* intuitive harmonic colour identity
* smooth exploratory interaction

The target aesthetic is:

```text
showcqt + musical score + transport scrubber
```

rather than:

```text
engineering spectrogram analyzer
```
