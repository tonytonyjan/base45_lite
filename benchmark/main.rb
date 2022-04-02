# frozen_string_literal: true

require 'benchmark/ips'
require 'base45'
require 'base45_lite'

message = 'base-45'
encoded = 'UJCLQE7W581'

Benchmark.ips do |x|
  x.report('Base45Lite.encode') { |n| n.times { Base45Lite.encode(message) } }
  x.report('Base45.encode') { |n| n.times { Base45.encode(message) } }
  x.compare!
end

Benchmark.ips do |x|
  x.report('Base45Lite.decode') { |n| n.times { Base45Lite.decode(encoded) } }
  x.report('Base45.decode') { |n| n.times { Base45.decode(encoded) } }
  x.compare!
end
