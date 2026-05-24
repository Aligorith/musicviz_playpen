01_pitch_color_map
==================

This folder documents my first official steps on this project, and represent the first
formal + complete attempt to figure out the mapping between pitches and the RGB colours 
that I'd long been associating with them. These colours are particularly relevant in the
context of the "Violin Layering" improvised violin-playing recording sessions that motivated
the need to create most of the visualisation tools in the first place (e.g. stuff like
G4 being a "Lawn Green / Lush Spring Growth" type colour, which in turn corresponds to many
pieces anchored around that subsequently having names involving the words "Healing", "Green",
and "Garden", given how that note often really resonates and rings out with a soothing purity).


Mapping Datasets
================

* 1) "pitch_color_map-v1" - These files were from my initial attempt back in June 2024, and represent
  the first time I had documented these mappings at all. Some of these notes were somewhat "shaky"
  as I didn't have any clear notion about them yet.

* 2) "GMajScale" - These represent a second cruder attempt, based on the "20260523-vs01-GMajScale.flac"
  calibration recording that captures a representative sample of the typical range of notes included
  in the various "violin layering" pieces. This capture was mainly aimed at giving a baseline capture of the
  spectrum to analyse, in a monophonic way, with gaps between the notes so we had certainty about when each
  started and ended. Hence the weird construction. It was intended to answer a few questions I had been having
  about the nature of the relationship between the fundamental frequency vs all the harmonics - in particular,
  relating to answering questions about whether there would be clearly defined fundamental frequencies that could
  be identified and tagged (while applying broad-base filters across the rest to ignore them).

  NOTEs: 
  * a) It should be noted that these have typically been recorded with tuning of A = 432 Hz, as that's what 
       naturally sounded "in tune" to me when retuning my violin each time the strings popped + being too lazy to reach
       for an A=440 tuning reference, which doesn't matter much when no longer actively performing live in any ensembles)

  * b) There are a bunch of flubbed notes in this sample, which mean that not all the notes are entirely "clean".
       This does pose some challenges for the tagging code, and results in some glitches / quirks that may lead
       QA efforts astray.