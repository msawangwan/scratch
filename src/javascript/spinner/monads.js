//https://blog.jcoglan.com/2011/03/05/translation-from-haskell-to-javascript-of-selected-portions-of-the-best-introduction-to-monads-ive-ever-read/

console.log("MONADS")
console.log("https://blog.klipse.tech/javascript/2016/08/31/monads-javascript.html")

const sine = (x) => Math.sin(x)
const cube = (x) => x * x * x

const sine2 = (x) => [sine(x), 'sine was called.'];
const cube2 = (x) => [cube(x), 'cube was called.'];

const testValue = 0.123

console.log(sine(testValue))
console.log(cube(testValue))

const compose = (f, g) => (x) => f(g(x))
const composeDebuggable = (f, g) => (x) => {
  const [y, s] = g(x)
  const [z, t] = f(y)

  return [z, [s, t].map(v => v.replace(/\.$/, '')).join('.')]
};

const f = compose(sine, cube)
const ff = composeDebuggable(sine2, cube2)

const transform = (f) => (tuple) => {
  const [z, t] = f(tuple[0])

  return [z, [tuple[1], t].map(v => v.replace(/\.$/, '')).join('.')]
};

const unit = (x) => [x, '']

const fy = compose(transform(sine2), transform(cube2))

console.log(f(testValue))
console.log(ff(testValue))

const result = fy(unit(testValue))

console.log(result)
console.log(compose(fy, unit)(3))

// lift :: (Number -> Number) -> (Number -> (Number,String))
const lift = (f) => compose(unit, f)

// round :: Number -> Number
const round = function (x) { return Math.round(x) }

// roundDebug :: Number -> (Number,String)
const roundDebug = lift(Math.round) // const roundDebug = function (x) { return unit(round(x)) }

const fx = compose(transform(roundDebug), transform(sine2))

console.log(fx(unit(27)))
