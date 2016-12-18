require './init.rb'
require 'benchmark'

print '# APP, No Concurrency:   '
puts Benchmark.measure {
  5.times {
    HTTP.get("https://timepo-viajero.herokuapp.com/rent?live_location=倫敦")
  }
}.real

print '# APP, With Concurrency: '
puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
        HTTP.get("https://timepo-viajero.herokuapp.com/rent?live_location=倫敦")
    }
  }
}.real
