## Test efficency of accumulating data in hashes and arrays

<<INTERESTING
Rehearsal ------------------------------------------
merge!   8.980000   0.720000   9.700000 ( 10.230802)
merge   15.280000   1.600000  16.880000 ( 19.326307)
&       29.190000   1.400000  30.590000 ( 33.012279)
+        4.070000   0.750000   4.820000 (  5.601307)
-------------------------------- total: 61.990000sec

             user     system      total        real
merge!  10.610000   1.230000  11.840000 ( 13.078149)
merge   15.730000   1.840000  17.570000 ( 20.307140)
&       29.460000   1.500000  30.960000 ( 32.743924)
+        4.700000   0.810000   5.510000 (  6.425507)
INTERESTING

require 'benchmark'

GC.disable

N = 1_000_000

h = { foo0: 'bar0',
      foo1: 'bar1',
      foo2: 'bar2',
      foo3: 'bar3',
      foo4: 'bar4',
      foo5: 'bar5',
      foo6: 'bar6',
      foo7: 'bar7',
      foo8: 'bar8',
      foo9: 'bar9',
    }
i = h.to_a
a,b,c,d = [h.dup, h.dup, i.to_a, i.to_a]
Proc.new{
  res = [a.merge(b),
         a.dup.merge!(b),
         (c & d).to_h,
         (c + d).to_h]
  res.each{|i| raise StandardError.new("not equal: #{i}, #{res[0]}")  unless i == res[0]}
}.call

Benchmark.bmbm do |b|
  b.report('merge!') do
    N.times do |n|
      a = h.dup
      b = h.dup
      c = a.merge!(b)
    end
  end
  b.report('merge') do
    N.times do |n|
      a = h.dup
      b = h.dup
      c = a.merge(b)
    end
  end
  b.report('&') do
    N.times do |n|
      a = i.dup
      b = i.dup
      c = (a & b).to_h
    end
  end
  b.report('+') do
    N.times do |n|
      a = i.dup
      b = i.dup
      c = (a + b).to_h
    end
  end
end
