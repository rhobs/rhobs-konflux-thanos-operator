# rhobs-konflux-thanos-operator

Use this repository to deploy thanos-operator built with Konflux

## Update submodule to specific tag

Update the submodule to the latest commit:
```bash
cd path/to/submodule
git fetch --tags
git checkout tag_name
cd ..
git add path/to/submodule
git commit -m "Updated submodule to tag_name"
git push
```
or use make target `make update-submodule`

## Update submodule to latest commit on main

```bash
git submodule update --init thanos-operator
git submodule update --remote thanos-operator
git add .
git commit -m "Updated submodule to <commit>"
git push
```