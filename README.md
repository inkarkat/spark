# spark
### sparklines for your shell

See? Here's a graph of your productivity gains after using spark: ▁▂▃▅▇

This is a fork of [Zach Holman's original spark](https://github.com/holman/spark) with fixes and additional features.

## Dependencies

- `spark` requires `bash` and `sed`; additionally `bc` when scaling input data.

## Installation

Download or clone the Git repository (cloning allows easy updating via `git pull`):

    git clone [--branch stable] https://github.com/inkarkat/spark.git
    
- The `./bin` subdirectory is supposed to be added to `PATH`.

Depending on the fonts you have in your system and you use in the terminal, you
might end up with irregular blocks. This is due to some fonts providing only
part of the blocks, while the others are taken from a different, fallback font.

## Usage

Just run `spark` and pass it a list of numbers (comma-delimited, spaces,
whatever you'd like). It's designed to be used in conjunction with other
scripts that can output in that format.

    spark 0 30 55 80 33 150
    ▁▂▃▅▂▇

Invoke help with `spark -h`.

### Cooler usage

There's a lot of stuff you can do.

Number of commits to the github/github Git repository, by author:

```sh
› git shortlog -s |
      cut -f1 |
      spark
  ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▂▁▁▅▁▂▁▁▁▂▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁
```

Magnitude of earthquakes worldwide 2.5 and above in the last 24 hours:

```sh
› curl -s https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.csv |
  sed '1d' |
  cut -d, -f5 |
  spark
▃█▅▅█▅▃▃▅█▃▃▁▅▅▃▃▅▁▁▃▃▃▃▃▅▃█▅▁▃▅▃█▃▁
```

Code visualization. The number of characters of `spark` itself, by line, ignoring empty lines:

```sh
› awk '{ print length($0) }' spark |
  grep -Ev 0 |
  spark
  ▁▁▁▁▅▁▇▁▁▅▁▁▁▁▁▂▂▁▃▃▁▁▃▁▃▁▂▁▁▂▂▅▂▃▂▃▃▁▆▃▃▃▁▇▁▁▂▂▂▇▅▁▂▂▁▇▁▃▁▇▁▂▁▇▁▁▆▂▁▇▁▂▁▁▂▅▁▂▁▆▇▇▂▁▂▁▁▁▂▂▁▅▁▂▁▁▃▁▃▁▁▁▃▂▂▂▁▁▅▂▁▁▁▁▂▂▁▁▁▂▂
```

Since it's just a shell script, you could pop it in your prompt, too:

```
ruby-1.8.7-p334 in spark/ on master with history: ▂▅▇▂
›
```

### Wicked cool usage

The Wiki (from the original author) is a great place to collect all
of your [wicked cool usage](https://github.com/holman/spark/wiki/Wicked-Cool-Usage) for spark.

## Contributing

Make your changes and run the tests:

    ./tests/test

You should probably be adding your own tests as well as changing the code.
