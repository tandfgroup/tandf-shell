# T&F Shell

> T&F Shell is for the efficient storage and management of shell scripts.

## Table of Contents

- [About the Service](#about)
  - [Features](#features)
  - [Usage](#usage)
- [File Structure](#file-structure)
- [Contributing](#contributing)
  - [Pull Requests](#pull-requests)
  - [Clone the repository](#clone-repo)
- [License](#license)

---

## About the Service <a id="about"></a>

This repository is used to manage reusable shell scripts and helpers.

Most scripts are written for `bash`, but intended to work on most 'nix shells.

*Note: Some scripts may not work as intended on Windows machines.*

### Features <a id="features"></a>

- Autoloading for aliases, functions, etc.
- Well organized app-based directory structure
- Easily add color and clean formatting to shell output

### Usage <a id="usage"></a>

First you must load the shell scripts somewhere and there are a few ways to do that.

#### 1. Use Git:
```bash
# Clone repo (without the .git/commit history)...
git clone --depth=1 --branch=master https://github.com/tandfgroup/tandf-shell.git tandf-shell && rm -rf !$/.git
# ...then move/use/reference the scripts as you please.
mv -a tandf-shell/scripts to/my/dir
```

#### 2. Use a _package manager_ to import it...

[Node.js](https://nodejs.org/)/[npm](https://www.npmjs.com/), and/or [Yarn](https://yarnpkg.com/),
can be used to load this package as a dependency. This will load _T&F Shell_ into
the following directory inside your project root; `./node_modules/tandf_shell`

##### Require module:

Add the following property/value to the `dependencies` object in your `package.json` file.

```javascript
{
  "dependencies": {
    "tandf-shell": "^1.0.0-alpha"
  }
}
```

##### Install module:
```bash
# Using NPM:
npm install
# Using Yarn:
yarn install
```

#### Import/use shell script(s) via `node_modules` directory...
```bash
# Load shell support/helpers:
. "./node_modules/tandf-shell/scripts/support.sh"
# Run installer for Node/npm:
. "./node_modules/tandf-shell/scripts/apps/node/install.sh"
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
 └─ package.json               * npm/yarn package config
```

---

## Contributing <a id="contributing"></a>

Contributions are always welcome, no matter how large or small.

### Pull Requests <a id="pull-requests"></a>

We actively welcome your pull requests.

1. [Create your branch](https://github.com/tandfgroup/tandf-shell#fork-destination-box) from `master`.
2. Make sure your scripts are well-formed, well-documented and object-oriented.
3. Make sure your scripts are stateless and can be reused by all.
4. Make sure you update your branch, and resolve any conflicts, before [making pull request](https://github.com/tandfgroup/tandf-shell/pulls).

### Clone the repository <a id="clone-repo"></a>

```bash
git clone https://github.com/tandfgroup/tandf-shell.git tandf-shell && cd tandf-shell
```

#### Happy coding!

## License <a id="license"></a>

Copyright 2017 Taylor & Francis Group

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
