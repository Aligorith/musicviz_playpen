reference_data/GMajScale_vs01
=============================

This folder contains exported "detected midi events" dumps from the tool, when using the GMajScale_vs01 dataset.


* "GMajScale-detected_notes-Mag[*].csv"
  These are from attempting to tweak "minimumPitchStrength"  (see 8c040a3e0ad5d9943e9383dd7d56be9a3838f4f1)
  
  The main issue is that the first harmonics are stronger than the fundamentals / real-pitches, along with the
  tuning being slightly off (despite an earlier version having been more accurate)