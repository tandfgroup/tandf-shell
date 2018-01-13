# T&F Shell

> T&F Shell is for the efficient storage and management of shell scripts.

## Table of Contents

- [About the Service](#about)
  - [Features](#features)
  - [Usage](#usage)
- [File Structure](CONTRIBUTING.md#file_structure)
- [Contributing](CONTRIBUTING.md)
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

#### 1. Use a _package manager_ to install it...

[Node.js](https://nodejs.org/)/[npm](https://www.npmjs.com/), and/or [Yarn](https://yarnpkg.com/),
can be used to load this package as a dependency. This will load _T&F Shell_ into
the following directory inside your project root; `./node_modules/tandf_shell`

```bash
# Using NPM:
npm install tandf-shell
# Using Yarn:
yarn add tandf-shell
```

##### 2. Import and use shell scripts via `node_modules` directory...
```bash
# Set variable for path to scripts directory:
TFSHELL_SCRIPTS="./node_modules/tandf-shell/scripts"

# Load shell support/helpers:
. "$TFSHELL_SCRIPTS/support.sh"

# Run installer for Node/npm:
. "$TFSHELL_SCRIPTS/apps/node/install.sh"
```

---

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
