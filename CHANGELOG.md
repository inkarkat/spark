# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2.1.0 - RELEASEME
### Added
- Allow addition of legend unit via --legend-unit
### Changed
- The `spark` command now resides in a `./bin` subdirectory.
- Improve double and fullwidth rendering characters.
### Deprecated
### Experimental
### Removed
### Fixed
### Security

## 2.0.0 - 10-Oct-2024
### Added
- Output space and newline arguments as-is instead of suppressing them
  Addresses holman/spark#110
- Render x in input as unknown data (×)
  Cp. holman/spark#97
- Allow fixed `--min` / `--max` that overrides the auto-scaling of the input data
  Fixes holman/spark#102
- Indicate under-/overflow (when using fixed min/max) with special symbols
- Allow logarithmic scaling of input data
  Cp. holman/spark#99
- Allow customization of ticks via `SPARK_TICKS`
- Support vertical flipping with `--flip`
- Render an exact value of 0 with a special `SPARK_ZERO` value
- Add _{rainbow,greyscale,green}-*_, _sized-[fullwidth-]boxes_, _[double-]shaded-boxes_ tick renderings
- Add tick variants using ANSI color sequences: _greyscale|green|[RGB]rainbow_
- Make empty and unknown data configurable
- Allow streaming of input data if both min and max are fixed
- Record numbers that fall into each sparkline bucket and allow printing of legend with `--with-legend`
### Changed
- Change default division algorithm to even distribution, add `--single-max-range` to switch back
  Fixes holman/spark#101

## 1.0.0

Hey! A 1.0! Now's a decent time as any. Starting to cut versions just for the
sake of things like Homebrew. So, might as well start with 1.0.

1.0 encompasses things that happened during
[the first week](https://zachholman.com/posts/from-hack-to-popular-project/)
of development.
