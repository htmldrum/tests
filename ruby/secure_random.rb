## Looking at cost of SecureRandom functions

# htmldrum  ☆  ~/code/htmldrum/tests $ ./test ./ruby/secure_random.rb
# Rehearsal -----------------------------------------------------------------------
# SecureRandom.uuid, 1000000 times      6.650000   0.390000   7.040000 (  7.164103)
# SecureRandom.hex(50), 1000000 times   4.230000   0.180000   4.410000 (  4.487530)
# ------------------------------------------------------------- total: 11.450000sec
#                                           user     system      total        real
# SecureRandom.uuid, 1000000 times      5.590000   0.260000   5.850000 (  5.966903)
# SecureRandom.hex(50), 1000000 times   4.400000   0.320000   4.720000 (  4.872860)

require 'benchmark'
require 'securerandom'
GC.disable
N = 1_000_000
Benchmark.bmbm do |bench|
  bench.report "SecureRandom.uuid, #{N} times" do
    N.times do |c|
      SecureRandom.uuid
    end
  end
  bench.report "SecureRandom.hex(50), #{N} times" do
    N.times do |c|
      SecureRandom.hex(50)
    end
  end
end
