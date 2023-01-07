# slyfox's ebuild overlay

This is an overlay for my personal hacks. These are small tools and
ancient games.

It should be safe to use this overlay on a day-to-day basis
in stable or ~arch systems. Most suspicious ebuilds are
unkeyworded (these are usually prerelreases).

# How to use

First, let's enable the overlay. We can either use the
`eselect-repository` method:

```sh
# Install eselect-repository if you don't already have it
emerge app-eselect/eselect-repository
# Fetch and output the list of overlays
eselect repository list
eselect repository enable slyfox
```

or we can use the layman method:

```sh
# Add important USE flags for layman to your package.use directory:
echo "app-portage/layman sync-plugin-portage git" >> /etc/portage/package.use/layman
# Install layman if you don't already have it
emerge app-portage/layman
# Rebuild layman's repos.conf file:
layman-updater -R
# Add the ::slyfox overlay:
layman -a slyfox
```

Finally, we need to unmask the overlay (this does not apply if your system
is already running ~arch):

```sh
# Unmask ~testing versions for your arch:
echo "*/*::slyfox" >> /etc/portage/package.accept_keywords
```

# No big things

I would like to keep the overlay safe to use for everyone.
If it gets out of hands I'll try to fork off big things
to other overlays. The possible candidates are:

- [::haskell overlay](https://github.com/gentoo-haskell/gentoo-haskell/)
- [::nix-guix overlay](https://github.com/trofi/nix-guix-gentoo/)
