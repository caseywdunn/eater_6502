# Build a 6502 computer

![My 6502](6502s.jpg)


Files for my build of Ben Eater's excellent 6502 breadboard computer. More
from him at https://eater.net/6502.

## Memory map

With reference to https://www.reddit.com/r/beneater/comments/doytpo/6502_project_memory_map/

| Chip | Range | Description |
| --- | --- | --- |
| RAM | `$0000` - `$00ff` | Zero page |
| RAM | `$0100` - `$01ff` | Stack |
| RAM | `$0200` - `$3fff` | General RAM |
| Open | `$4000` - `$5fff` | Not mapped to a device |
| 6522 | `$6000` | I/O Register B |
| 6522 | `$6001` | I/O Register A |
| 6522 | `$6002` | Data Direction Register B |
| 6522 | `$6003` | Data Direction Register A |
| 6522 | `$6004` | T1 Low Order Latches/Counter |
| 6522 | `$6005` | T1 High Order Counter |
| 6522 | `$6006` | T1 Low Order Latches |
| 6522 | `$6007` | T1 High Order Latches |
| 6522 | `$6008` | T2 Low Order Latches/Counter |
| 6522 | `$6009` | T2 High Order Counter |
| 6522 | `$600a` | Shift Register |
| 6522 | `$600b` | Auxiliary Control Register |
| 6522 | `$600c` | Peripheral Control Register |
| 6522 | `$600d` | Interrupt Flag Register |
| 6522 | `$600e` | Interrupt Enable Register |
| 6522 | `$600f` | I/O Register A sans Handshake |
| 6522 | `$6010` - `7fff` | Mirrors of the sixteen VIA registers |
| 6522 | `$8000` - `$ffff` | ROM |

## Code for videos

I've slightly modified some of the commands and code to have incremental
versions of some of the programs he iterates on.

### Video 1

There are no commands for [video 1](https://www.youtube.com/watch?v=yl8vPW5hydQ).
All the software is hardwired resistors.

"My favorite programming language is solder." - [Todd Whitehurst](https://www.google.com/books/edition/The_Art_and_Science_of_Analog_Circuit_De/SPwqg7qpFWUC?hl=en&gbpv=1&dq=bob%20pease%20richard%20feynman&pg=PA41&printsec=frontcover) (or Bob Pease?)


### Video 2

Commands for [video 2](https://www.youtube.com/watch?v=yl8vPW5hydQ).

First, the bin with just `ea` values.

    python makerom_ea.py
    hexdump -C rom_ea.bin
    minipro -p AT28C256 -w rom_ea.bin

Now the full binary.

    python makerom.py
    hexdump -C rom.bin
    minipro -p AT28C256 -w rom.bin

### Video 3

Commands for [video 3](https://www.youtube.com/watch?v=oO8_2JJV0B4).

    vasm6502_oldstyle -Fbin -dotdir blink.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out

### Video 4

Commands for [video 4](https://www.youtube.com/watch?v=oO8_2JJV0B4).

    vasm6502_oldstyle -Fbin -dotdir hello-world_vid04.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out


### Video 5

Commands for [video 5](https://www.youtube.com/watch?v=xBjQVxVxOxc).


    vasm6502_oldstyle -Fbin -dotdir hello-world_vid05.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out


### Video 7

Commands for [video 7](https://www.youtube.com/watch?v=omI0MrTWiMU).

    vasm6502_oldstyle -Fbin -dotdir hello-world_vid07.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out
