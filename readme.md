# Build a 6502 computer

Files for my build of Ben Eater's excellent 6502 breadboard computer. More
from him at https://eater.net/6502.



## Video 5

Commands for [video 5](https://www.youtube.com/watch?v=xBjQVxVxOxc).

    vasm6502_oldstyle -Fbin -dotdir hello-world_vid05.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out


## Video 7

Commands for [video 7](https://www.youtube.com/watch?v=omI0MrTWiMU).

    vasm6502_oldstyle -Fbin -dotdir hello-world_vid07.s
    hexdump -C a.out
    minipro -p AT28C256 -w a.out
