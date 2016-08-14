## Test efficency of instance variable assignment

require 'benchmark'

GC.disable

N = 1_000_000
O = 20
VALUE = "foo"
obj = N.times.map{ Class.new.new }

Benchmark.bmbm do |bench|
  O.times do |count|
    bench.report("adding instance variable number #{count + 1}") do
      N.times do |n|
        obj[n].instance_variable_set("@var#{count}", VALUE)
      end
    end
  end
end
