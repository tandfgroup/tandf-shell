# Contributing

> Contributions are always welcome, no matter how large or small.

## Table of Contents

- [Pull Requests](#pull-requests)
- [Style Guides](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md)
- [Clone the Repository](#clone-repo)
- [Install dependencies](#install-dependencies)
- [File Structure](#file_structure)

---

## Pull Requests <a id="pull-requests"></a>

Thank you for contributing.

* Create your branch from `master`.
* Ensure your scripts are well-formed, well-documented and object-oriented.
* Ensure your scripts are stateless and can be reused by all.
* Update your branch, and resolve any conflicts, before making pull request.
* Fill in [the required template](https://github.com/tandfgroup/engineering/blob/master/PULL_REQUEST_TEMPLATE.md).
* Do not include issue numbers in the PR title.
* Include screenshots and animated GIFs in your pull request whenever possible.
* Follow the [style guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md) [applicable to the language](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#languages) or task.
* Include thoughtfully-worded, well-structured tests/specs. See the [Tests/Specs Style Guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#tests).
* Document new code based on the [Documentation Style Guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#documentation).
* End all files with a newline.

---

## Clone the Repository <a id="clone-repo"></a>

```bash
git clone https://github.com/tandfgroup/tandf-shell.git tandf-shell && cd tandf-shell
```

## Install dependencies <a id="install-dependencies"></a>
```bash
# Using NPM:
npm install
# Using Yarn:
yarn install
```

---

## File Structure
```
tandf-shell/
 ├─ scripts/                   * the directory containing all shell script files
 │   ├─ apps/                  * Apps directory containing app/binary scripts
 │   │   ├─ [node]/            * App/binary directory
 │   │   :   ├─ aliases.sh     * App-related aliases
 │   │       ├─ functions.sh   * App-related functions
 │   │       ├─ install.sh     * App/binary installer
 │   │       └─ path.sh        * App/binary paths
 │   │
 │   ├─ functions/             * Shell functions directory
 │   │   ├─ [lowercase]        * Shell function (with filename identical to function name)
 │   │   :
 │   │
 │   ├─ services/              * Services directory containing service scripting
 │   │   ├─ [aws]/             * Service directory
 │   │   :   ├─ aliases.sh     * Service-related aliases
 │   │       ├─ functions.sh   * Service-related functions
 │   │       ├─ install.sh     * Service installer
 │   │       └─ path.sh        * Service paths
 │   │
 |   ├─ aliases.sh             * Shell aliases (loads all `./apps/**/aliases.sh`)
 |   ├─ functions.sh           * Shell functions (loads all `./functions/*`,
 |   │                           `./apps/**/functions.sh`, `./services/**/functions.sh`)
 |   ├─ response.sh            * Shell response helpers
 |   ├─ support.sh             * Shell support loader
 |   └─ test.sh                * Shell support tests
 │
 ├─ tests/                     * unit/integration tests
 │   ├─ support.sh             * tests for Shell support loader
 │   :
 │
 ├─ package.json               * npm/yarn package config
 └─ yarn.lock                  * yarn lock file for package config
```

---

#### Happy coding!
