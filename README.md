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
It can then be read by [MazeVim](https://github.com/TamaMcGlinn/MazeVim) / [PacVim](https://github.com/TamaMcGlinn/PacVim)
so that you can walk around with hjkl:

![playing Mazifier-generated map with MazeVim](https://i.imgur.com/90Wawjs.png)

## Build

Install GNAT and gprbuild, then run gprbuild from the root of the repository.
