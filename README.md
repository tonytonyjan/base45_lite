# Base45Lite

![](https://github.com/tonytonyjan/base45_lite/actions/workflows/ci.yml/badge.svg)

`base45_list` is an implementation of [The Base45 Data Encoding](https://datatracker.ietf.org/doc/draft-faltstrom-base45/)

## Installation

```sh
gem install base45_lite
```

## Usage

See [test/test_base45_lite.rb](test/test_base45_lite.rb)

## Benchmark

Compare to [base45](https://rubygems.org/gems/base45):

```sh
rake benchmark
```

```
Warming up --------------------------------------
   Base45Lite.encode    38.080k i/100ms
       Base45.encode    15.564k i/100ms
Calculating -------------------------------------
   Base45Lite.encode    347.340k (± 8.5%) i/s -      1.752M in   5.082412s
       Base45.encode    141.198k (± 6.5%) i/s -    715.944k in   5.092245s

Comparison:
   Base45Lite.encode:   347340.1 i/s
       Base45.encode:   141197.9 i/s - 2.46x  (± 0.00) slower

Warming up --------------------------------------
   Base45Lite.decode    23.842k i/100ms
       Base45.decode    15.195k i/100ms
Calculating -------------------------------------
   Base45Lite.decode    238.203k (± 6.7%) i/s -      1.192M in   5.028081s
       Base45.decode    167.595k (± 5.3%) i/s -    835.725k in   5.001845s

Comparison:
   Base45Lite.decode:   238202.6 i/s
       Base45.decode:   167595.3 i/s - 1.42x  (± 0.00) slower
```
