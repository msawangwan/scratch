import ora from "ora";
import chalk from "chalk";
import spinners from "cli-spinners";

/*
  see:
    - https://jsfiddle.net/sindresorhus/2eLtsbey/embedded/result/
    - https://github.com/sindresorhus/ora#api
*/

const SPINNERS = [
  "arc",
  "material",
  "bouncingBar",
  "bouncingBall",
  "pong",
  "shark",
  "layer",
  "point",
  "aesthetic",
  "arrow2",
  "arrow3",
  "squish",
  "flip",
  "hamburger",
  "simpleDots",
  "simpleDotsScrolling",
  "pipe",
  "line2",
  "dots2",
  "dots3",
  "dots4",
  "dots5",
  "dots6",
  "dots7",
  "dots8",
  "dots9",
  "dots10",
  "dots11",
  "dots12",
]

const columns = process.stdout.columns
const rows = process.stdout.rows

// const n = SPINNERS[3]
const n = SPINNERS[2]
const o = spinners[n]

const spinner = ora({
  text: "Loading build environment ..",
})

spinner._spinner = o; // this was the only way to get the stupid thing to work.
//
const { stdout, stderr } = process

const put = (...args) => stdout.write(args.join(" "))
const putl = (...args) => put(...[...args, "\n"])
const err = (...args) => stderr.write(...args)
const clearScreen = () => {
  stdout.cursorTo(0, 0)
  stdout.write("\x1Bc")
}
// unicode characters:
// ░░░░░░░░░░░░░░
// ▒▒▒▒▒▒▒▒▒▒
// █

const logo = (style = "block") => {
  const draw = s => console.log(chalk.whiteBright.blue(s))

  //draw(`${chalk.whiteBright('▒▒██████')}${chalk.whiteBright.bgBlue('▓▓')}${chalk.blue('░░')}`)

  //draw('▒'.repeat(5))

  clearScreen()

  switch (style) {
    case "block":
      draw(`                                                                        `)
      draw(`                                                   (${rows}x${columns}) `)
      draw(`                                                                        `)
      draw(`   ▒▒▒▒▒   ▒▒  ▒▒▒    ▒▒▒ ▒▒▒▒▒▒▒  ▒▒▒     ▒▒▒▒▒▒▒                      `)
      draw(`   █████   ██  ███    ███ ███████  ███     ███████                      `)
      draw(`   ███  █  ██   ██    ██  ███░  ██ ███     ███                          `)
      draw(`   ███          █ ████ █   ██████  ███     █████                        `)
      draw(`    ▒▒▒▒▒  ▒▒   ▒  ▒▒  ▒   ▒▒▒     ▒▒▒     ▒▒▒                          `)
      draw(`  █   ███  ██  ██      ██  ███     ███████ ████████                     `)
      draw(`   ██████  ██ ███      ███ ███     ███████ ████████                     `)
      draw(`                                                                        `)
      draw(`       █  █ ██   █  ███  Frontend Host v1.0.0                           `)
      draw(`       █    █ █ █ █ █                                                   `)
      draw(`       █  █ █ █ ██   ██                                                 `)
      draw(`       ██ █ █ █ ███ ███  Copyright © 2022 Simple Lines                  `)
      draw(`                                                                        `)

      break
    default:
      draw(`                                                                        `)
      draw(`                                                   (${rows}x${columns}) `)
      draw(`                                                                        `)
      draw(`  █▒▒▒▒   █▒  █▒   ░█▒  █▒▒▒▒   █▒     █▒▒▒▒▒▒                          `)
      draw(`  █▒▒▒▒   █▒  █▒   ░█▒  █▒▒▒▒   █▒     █▒▒▒▒▒▒                          `)
      draw(`  █▓   ▒  ░█  ░▒█  ░█▒  ░█  ░▒  █▒     █▒    ░▒                         `)
      draw(`   █▓  ▒      ░▒ █▒▒ ░  ░▒█▒▒   ░█     ░█▒▒▒▒▒   .~                     `)
      draw(`    █     ░█  ░█     █  ░█      ░▒█▒█  ░▒█      █                       `)
      draw(`     █    █▒  ░▒█   ░▒  ░▒      ░░▒█▒  ░▒▒█▒    ▒                       `)
      draw(`  ░  ░█   ░█            ░▒                ░█▒▒▒▒                        `)
      draw(`  ░   ░█                                                                `)
      draw(`   ██▒▒█   █  █ ██   █  ███  Frontend Host v1.0.0                       `)
      draw(`           █    █ █ █ █ █                                               `)
      draw(`           █  █ █ █ ██   ██                                             `)
      draw(`           ██ █ █ █ ███ ███  Copyright © 2022 Simple Lines              `)
      draw(`                                                                        `)

      break
  }
}

logo()

setTimeout(() => {
  spinner.stop()
}, 5000)

spinner.start()
