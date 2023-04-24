# slyfox's ebuild overlay

This is an overlay for my personal hacks. These are small tools and
ancient games.

It should be safe to use this overlay on a day-to-day basis
in stable or ~arch systems. Most suspicious ebuilds are
unkeyworded (these are usually prerelreases).

# How to use

Use standard [repos.conf](https://wiki.gentoo.org/wiki//etc/portage/repos.conf)
configuration for the overlay:

```bash
cat > slyfox.conf <<EOF
[slyfox]
location = /var/db/repos/slyfox
sync-type = git
sync-uri = https://github.com/trofi/slyfox-gentoo.git
EOF
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
