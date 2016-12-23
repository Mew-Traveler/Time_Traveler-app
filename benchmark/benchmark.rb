require './init.rb'
require 'benchmark'

print '# APP, No Concurrency:   '
puts Benchmark.measure {
  5.times {
<<<<<<< HEAD
    HTTP.get("http://localhost:9292/rent?live_location=倫敦")
=======
    HTTP.get("https://timepo-viajero.herokuapp.com/rent?live_location=倫敦")
>>>>>>> c6b0ff02ab2438b60284dcfa1981548e0b58545a
  }
}.real

print '# APP, With Concurrency: '
puts Benchmark.measure {
  5.times {
    Concurrent::Promise.execute {
<<<<<<< HEAD
        HTTP.get("http://localhost:9292/rent?live_location=倫敦")
=======
        HTTP.get("https://timepo-viajero.herokuapp.com/rent?live_location=倫敦")
>>>>>>> c6b0ff02ab2438b60284dcfa1981548e0b58545a
    }
  }
}.real
