# Contributing

> Thank you for contributing. Contributions are always welcome, no matter how large or small.

## Table of Contents

- [Guidelines](#guidelines)
- [Pull Requests](#pull-requests)
- [Clone the Repository](#clone-repo)
- [Install Dependencies](#install-dependencies)
- [File Structure](#file-structure)

---

## Guidelines <a id="guidelines"></a>

As a contributor, here are the guidelines we would like you to follow:

- [Code of conduct](https://github.com/tandfgroup/engineering/blob/master/CODE_OF_CONDUCT.md)
- [How can I contribute?](https://github.com/tandfgroup/engineering/blob/master/CONTRIBUTING.md#how-can-i-contribute)
- [Using the issue tracker](https://github.com/tandfgroup/engineering/blob/master/CONTRIBUTING.md#using-the-issue-tracker)
- [Submitting a Pull Request](https://github.com/tandfgroup/engineering/blob/master/CONTRIBUTING.md#submitting-a-pull-request)
- [Coding rules](https://github.com/tandfgroup/engineering/blob/master/CONTRIBUTING.md#coding-rules)
- [Working with code](https://github.com/tandfgroup/engineering/blob/master/CONTRIBUTING.md#working-with-code)

We also recommend to read [How to Contribute to Open Source](https://opensource.guide/how-to-contribute).

---

## Pull Requests <a id="pull-requests"></a>

Thank you for contributing.

- Create your branch from `master`.
- Ensure your [git commit messages follow the required format](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#git-commit-messages).
- Ensure your scripts are well-formed, well-documented and object-oriented.
- Ensure your scripts are stateless and can be reused by all.
- Update your branch, and resolve any conflicts, before making pull request.
- Fill in [the required template](https://github.com/tandfgroup/engineering/blob/master/PULL_REQUEST_TEMPLATE.md).
- Do not include issue numbers in the PR title.
- Include screenshots and animated GIFs in your pull request whenever possible.
- Follow the [style guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md) [applicable to the language](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#languages) or task.
- Include thoughtfully-worded, well-structured tests/specs. See the [Tests/Specs Style Guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#tests).
- Document new code based on the [Documentation Style Guide](https://github.com/tandfgroup/engineering/blob/master/STYLE_GUIDES.md#documentation).
- End all files with a newline.

---

## Clone the Repository <a id="clone-repo"></a>

```bash
git clone https://github.com/tandfgroup/tandf-shell.git tandf-shell && cd tandf-shell
```

## Install Dependencies <a id="install-dependencies"></a>

```bash
# Using NPM:
npm install
# Using Yarn:
yarn install
```

## Testing

- Linting is performed using [ShellCheck](https://github.com/koalaman/shellcheck). Learn more about '[How to use ShellCheck](https://github.com/koalaman/shellcheck#how-to-use)'.
- All tests are written using [Bats](https://github.com/bats-core/bats-core). Learn more about '[Writing Tests in Bats docs](https://github.com/bats-core/bats-core#writing-tests)'.
- Code coverage is generated using [kcov](https://github.com/SimonKagstrom/kcov). Reports are generated at `file://.../tandf-shell/coverage/bats/index.html` and published to [codecov.io]((https://codecov.io/) at [codecov.io/gh/tandfgroup/tandf-shell](https://codecov.io/gh/tandfgroup/tandf-shell)

---

## File Structure <a id="file-structure"></a>

```text
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
 │   ├─ apps-[git].bats        * tests for App-related functions
 │   ├─ functions.bats         * tests for Shell functions
 │   ├─ response.bats          * tests for Shell response helpers
 │   ├─ services-[aws].bats    * tests for Service-related functions
 │   ├─ support.bats           * tests for Shell support functions
 │   :
 │
 ├─ commitlint.config.js       * commitlint config
 ├─ package-lock.json          * npm dependency lock file
 └─ package.json               * npm package config
```

---

#### Happy coding!
