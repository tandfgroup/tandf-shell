# T&F Shell

> T&F Shell is for the efficient storage and management of shell scripts.

[![Build Status](https://travis-ci.org/tandfgroup/tandf-shell.svg?branch=master)](https://travis-ci.org/tandfgroup/tandf-shell) [![codecov](https://codecov.io/gh/tandfgroup/tandf-shell/branch/master/graph/badge.svg)](https://codecov.io/gh/tandfgroup/tandf-shell) [![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release) [![Greenkeeper badge](https://badges.greenkeeper.io/tandfgroup/tandf-shell.svg)](https://greenkeeper.io/)

[![npm latest version](https://img.shields.io/npm/v/tandf-shell/latest.svg)](https://www.npmjs.com/package/tandf-shell) [![npm next version](https://img.shields.io/npm/v/tandf-shell/next.svg)](https://www.npmjs.com/package/tandf-shell) [![npm downloads per week](https://img.shields.io/npm/dw/tandf-shell.svg)](https://www.npmjs.com/package/tandf-shell) [![npm total downloads](https://img.shields.io/npm/dt/tandf-shell.svg)](https://www.npmjs.com/package/tandf-shell)

## Table of Contents

- [About the Service](#about)
  - [Features](#features)
- [Install](#install)
- [Usage](#usage)
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

## Install <a id="install"></a>

[Node.js](https://nodejs.org/)/[npm](https://www.npmjs.com/), and/or [Yarn](https://yarnpkg.com/),
can be used to load this package as a dependency. This will load _T&F Shell_ into
the following directory inside your project root; `./node_modules/tandf-shell`

```bash
# Using NPM:
npm install tandf-shell
# Using Yarn:
yarn add tandf-shell
```

## Usage <a id="usage"></a>

### Import and use shell scripts via `node_modules` directory...
```bash
# Set variable for path to scripts directory:
TFSHELL_SCRIPTS="./node_modules/tandf-shell/scripts"

# Load shell support/helpers:
. "$TFSHELL_SCRIPTS/support.sh"

# Run installer for Node/npm:
. "$TFSHELL_SCRIPTS/apps/node/install.sh"
```

> :point_up: _more instructions coming soon._

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
