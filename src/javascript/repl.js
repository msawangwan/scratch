const { stdout, stderr } = process

const put = (...args) => stdout.write(args.join(" "))
const putl = (...args) => put(...[...args, "\n"])
const err = (...args) => stderr.write(...args)
const cls = () => {
  stdout.cursorTo(0, 0)
  stdout.write("\x1Bc")
}

putl("foo")
putl("bar")
