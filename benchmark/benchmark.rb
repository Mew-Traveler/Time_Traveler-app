require './init.rb'
require 'benchmark'

print '# APP, No Concurrency:   '
puts Benchmark.measure {
  5.times {
    HTTP.get("http://localhost:9292/rent?live_location=倫敦")
  }
}.real

print '# APP, With Concurrency: '
puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
        HTTP.get("http://localhost:9292/rent?live_location=倫敦")
    }
  }
}.real
