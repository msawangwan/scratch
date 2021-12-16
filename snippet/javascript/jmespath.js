const DATA = {
  'part1': {
    'name': 'Part 1',
    'size': '20',
    'qty': '50'
  },
  'part2': {
    'name': 'Part 2',
    'size': '15',
    'qty': '60'
  },
  'part3': [
    {
      'name': 'Part 3A',
      'size': '10',
      'qty': '20'
    }, {
      'name': 'Part 3B',
      'size': '5',
      'qty': '20'
    }, {
      'name': 'Part 3C',
      'size': '7.5',
      'qty': '20'
    }
  ]
}

// extractIndex parses the offset indices of square brackets which enclose a number.
//
// returns a type of tuple, e.g.:
//
// `[start, end]` or `[undefined, undefined]`
//
// chars: Array<string>
//
// e.g.:
//  ['p', 'a', 'r', 't', '1', '.', 'n', 'a', 'm', 'e']
//   -8   -7   -6   -5   -4   -3   -2   -1
//    0    1    2    3    4    5    6    7
//  ['p', 'a', 'r', 't', '3', '[', '0', ']']
//  ['p', 'a', 'r', 't', '3', '[', '0', ']', '.', 'n', 'a', 'm', 'e']
const extractIndex = (chars) => {
  const lastChar = chars.at(-1)

  // not an array
  if (lastChar !== "]") {
    return [undefined, undefined]
  }

  let start, end;

  end = chars.length
  start = end;

  let cursor = -2

  while (true) {
    const c = chars.at(cursor)

    // we've reached either the closing bracket or ran out of characters
    if (!c || c === "[") {
      break
    }

    // nested index
    if (c === "]") {
      return extractIndex(chars.slice(0, end + cursor + 1))
    }

    start = cursor
    cursor -= 1
  }

  return [end + start, end - 1]
}

function JMesPath(o) {
  this.o = o

  // the following method is my own.
  //
  // but ..for lots of other techniques, see:
  //
  // https://stackoverflow.com/a/13974041
  // https://stackoverflow.com/a/7641272
  // https://stackoverflow.com/a/6394168
  this.resolve = (path, oref = undefined) => {
    let ref = oref ?? this.o
    let sanitized = path.replace(/^\./, ''); // strip a leading dot

    // for arrays one can also use dot notation so:
    // sanitized = sanitized.replace(/\[(\w+)\]/g, '.$1'))  // convert indexes to properties

    const pathParts = sanitized.split(".")
    const len = pathParts.length

    // the zero length string
    if (!len) {
      return undefined
    }

    const chars = pathParts[0].split("")
    const [start, end] = extractIndex(chars)

    // possible index
    let i
    if (typeof start !== "undefined" && typeof end !== "undefined") {
      try {
        i = Number(chars.slice(start, end))
      } catch {
        throw new Error("JMesPath: invalid array index: expected type integer: got:", `"${chars.slice(start, end)}"`)
      }

      if (typeof i !== "number") {
        throw new Error("JMesPath: invalid array index: expected type integer: got:", `"${typeof value}"`);
      }

      const key = chars.slice(0, start - 1).join("")
      const value = ref[key]

      if (Array.isArray(value)) {
        return value[i]
      }

      throw new Error("JMesPath: invalid value type: expected type \"array\": got:", `"${typeof value}"`);
    }

    while (true) {
      const pathSegment = pathParts.shift()
      const value = ref[pathSegment]

      if (typeof value === "object" && pathParts.length) {
        return this.resolve(pathParts.join("."), value)
      }

      return value
    }
  }
}

const p1 = "part1.name"
const p2 = "part2.qty"
const p3 = "part3[0].name"
const p4 = ".part1"

const j = new JMesPath(DATA)
for (const p of [p1, p2, p3, p4]) {
  try {
    console.log(p, "=", j.resolve(p))
  } catch (e) {
    console.error(e.message)
  }
}
