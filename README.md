# README
This is my fork of `scroll`.

Mostly I'll just add nix(os) buildscripts and might tweak the bindings a little.

I'd might like to work on an external pip feature like in 
(this `st` patch)[https://st.suckless.org/patches/externalpipe/]. But I am pretty
sure my C KungFu is not good enough.

## Build localy
Just run `nix-build` or `nix-build default.nix`. The binary can be found at `result/bin/st`.

## Include in NixOS

In my `configuration.nix` have (among overlay definitions) this:

```
  nixpkgs.overlays =
    let
      scroll_src = pkgs.fetchFromGitHub {
        owner  = "agschaid";
        repo   = "scroll";
        rev    = "a3078d4e5c956b9cfe483c8f500c8994d01e54d0";
        sha256 = "1d1lsqafkcia3s86cbmpgw7dz9qp5mwra8s0cg5x3a86p81cl1ca";
      };


      src_overlays = self: super: {
        scroll = import "${st_src}/default.nix";
      };

      other_overlays = self: super: {
        # other stuff
      };

    in
    [other_overlays src_overlays];

    # then install scroll as usual package
```
Not sure if this is the most elegant or idiomatic way but it works.


# Original README

This program provides a scroll back buffer for a terminal like st(1).  It
should run on any Unix-like system.

At the moment it is in an experimental state.  Its not recommended for
productive use.

The initial version of this program is from Roberto E. Vargas Caballero:
	https://lists.suckless.org/dev/1703/31256.html

What is the state of scroll?

The project is faced with some hard facts, that our original plan is not doable
as we thought in the first place:

 1. [crtl]+[e] is used in emacs mode (default) on the shell to jump to the end
    of the line.  But, its also used so signal a scroll down mouse event from
    terminal emulators to the shell an other programs.

    - A workaround is to use vi mode in the shell.
    - Or to give up mouse support (default behavior)

 2. scroll could not handle backward cursor jumps and editing of old lines
    properly.  We just handle current line editing and switching between
    alternative screens (curses mode).  For a proper end user experience we
    would need to write a completely new terminal emulator like screen or tmux.

What is the performance impact of scroll?

	indirect	OpenBSD
-------------------------------
	0x		 7.53 s
	1x		10.10 s
	2x		12.00 s
	3x		13.73 s
