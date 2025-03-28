# Modules

This repository is intended to add new third party JASP modules.

## How to add a new module

- fork this repository
- add a new `yaml` file in `modules-metadata` folder with the following structure:

```yaml
name: "Module Name"
gitUrl: "Your JASP module git repository"
```

- create a pull request to this repository
- after review, and successful merge, your module will be added to the `beta-modules` folder
