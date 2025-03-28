## Quick and dirty nix development shells

Example for starting a deno shell:
```shell
nix develop 'github:markuskobler/dev?dir=deno'
```

Example of loading node into existing shells

```shell
nix shell 'github:markuskobler/dev?dir=node'

node --version
```
