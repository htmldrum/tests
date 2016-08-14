## Test efficency of accumulation methods

require 'benchmark'

GC.disable

N = 1_000_000
nums = N.times.map{ rand(N) }

Benchmark.bmbm do |x|
  x.report('inject'){nums.inject({}){ |h,n| h[n]=n; h }}
  x.report('tap/each'){{}.tap{ |h| nums.each{ |n| h[n]=n }}}
  x.report('ea_wi_obj'){nums.each_with_object({}){ |n,h| h[n]=n}}
end
