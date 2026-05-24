Spectrogram Tool
================

# Motivation

This folder contains a first attempt to develop a first-pass "specialised / custom tool", as a step towards
developing the visualisation I have in mind. The original aim of this tool was to mainly be a test-bed to see
how far we could push the "showcqt" like visualisation to start performing the things I had in mind when I first
saw that visualisation style. Namely, it had the following technical objectives:
  1) Build a visualisation that does the pitch-colour labelling of an arbitrary piece of music, so I can see how 
     these colours fit together in soundscapes I've created

  2) Experiment with how far we can push "dominant pitch extraction" techniques, to hopefully pick out melodic lines
     and/or other "key" elements from the piece, and allow examining what colours the tool had picked out at each moment
     (i.e. see what it has chosen when, and then check by scrubbing the audio whether that's an accurate assessment, or if
     something else should have been featured instead)

  3) Act as an initial prototype demonstrating how I can build these types of lightweight experiments with minimal scaffodling,
     while being able to deploy + run them with minimal effort  (i.e. Key point here is that this is supposed to be a
     **"FUN CREATIVE SIDE-PROJECT"**, that I do in my free time after a long week of heavy-duty formal engineering work for
     my dayjob. In other words: "If something goes wrong, it doesn't matter as no-one dies!")


-- @Aligorith (22 - 24 May, 2026)


# What Do We Have Here

What is defined here is a "single page", fully in-browser, spectograph-like viewer for short music recordings, 
colouring the frequencies by manually hand-curated colours per pitch name instead of intensity-based mappings. 
It supports audio scrubbing + playback, recording of the visualisation to .mp4 videos, and a bunch of live-tweaking
capabilities to fine-tune the resulting visualisation to correct for subtle issues that are discovered when seeing the
generated result.


Directory Tree:
* **"prototype_iterations/"** -- This is where the "Prompt + Resulting Output" pairs reside

* **"src/"**  - This is where the current version of this code resides, following hand editing + refactoring.
                The main page is called "spectrochrome.html" (based on v46-ManuallyMergedWith42.html)

* **"docs/"** - This contains the living Markdown design document for the design. This was the result of instructing
                the AI to generate a design document for the state of the system after "v42.html"

* **"gallery/"** - This contains a few sample outputs for reference of what it can do



# How Did We Get Here

The initial codebase was clobbered together by effectively vibe-coding a free publicly available cloud AI 
(i.e. the only one to allow non-logged-in-usage) to generate the necessary HTML/JS/etc. implementation,
and then iterating on it.

This process is documented in the "prototype_iterations" folder. We have the "v[\d]_prompt.txt" files containing the
prompts given to the AI, followed by any Markdown response received.

* Overall, the first "decent" and "mostly-there" version was "v42.html"

* Versions after that turned to custard, when the AI, likely running out of context window space, started generating
  increasingly unreliable outputs (along with some wrong paths that ended up really contaminating the state space,
  causing future prompt attempts after that to get even weirder + even more incomplete). 

  * Notably, the final / base version the implemention in the "src" folder is based on the "v46-ManuallyMergedWith42.html"
    file, which was a hand-edited file that merged all the successful parts of the 45-49 prompt cycles into the `v42.html`
    "good" version, and combined that with a handful of manual fixes for a number of bugs identified  (NOTE: All of these
    are prefixed by "JSL:" comments). 

  * At this point, it was deemed that there was no point in letting the AI continue to bulk generate any code, and instead, 
    work shifted to only using it to answer queries about suggested implementation approaches for a bunch of outstanding
    features / tweaks / bugfixes  (to take advantage of the session still existing with all the state "in memory", leading to
    hopefully more coherent + relevant answers than trying to start fresh / clean later).  These are all the "prompt" files
    labelled "50+"

  * Also, since increasingly more manual hand-edited fixes were now necessary, I decided at this point to simply properly
    set up a git repo for hosting this code (with the prompt history archived alongside it for future reference), and to
    carry out the remaining dev work on this using traditional engineering techniques (i.e. "by hand"), after refactoring the
    code, fixing any bugs, and then carrying on any subsequent development after that.

* It was somewhat random when a prompt would return a fully usable HTML version, vs instructions on how to patch your
  existing code. As will be seen with some of the filenames, some attempts to apply these failed, leading to increasing
  usage of prompts to "generate the full html" (to see what the AI "thinks" the current output "looks like", vs what it
  tells you to do... there is a gap!). As a result, these "show me the output" prompts do end up bonking up the iteration
  count a bit.