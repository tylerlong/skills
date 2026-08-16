# Install Source Skills from the published GitHub repo via the npx skills CLI

`make install` previously rsynced this repository's Source Skills directly into
`~/.agents/skills`. We instead publish the repository publicly to GitHub
(`tylerlong/skills`) and install them with `npx skills add --global
tylerlong/skills`, the same mechanism the Skills CLI uses for upstream skills,
removing the local copy and reconciliation machinery (rsync, executable_bits).
Consequence: a local skill edit takes effect only after it is committed,
pushed to `main`, and reinstalled — `make install` pulls from GitHub and never
pushes.