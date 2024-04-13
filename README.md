# mazify

Mazify generates mazes from files based on the MazeVim / PacVim format,
where spaces are passages and # are walls. For example, this input:

```
#########
#########
#########
  #######
  #######
```

Could become:

```
#########
#   #   #
### # ###
  #     #
  #######
```

Input file is expected to have lines with N characters, N is uneven and >= 3.

## Build

Install GNAT and gprbuild, then run gprbuild from the root of the repository.
