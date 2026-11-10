# Operator tooling

`mise` installs the pinned local toolchain and `task` runs the supported workflows.

## Toolchain

Install the declared toolchain before working in the repository:

```bash
mise install
```

## Taskfile

Use `task --list` to view the current supported commands and their descriptions.

Review a task's implementation before executing any command that changes infrastructure, cluster state, local credentials, or the host operating system.

Generated Terraform inputs, Talos configuration, and kubeconfig are local credentials. They are ignored by Git and must never be committed.
