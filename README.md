LTESniffer
=================

>[!WARNING]
>This repository is currently unmaintained and should not be used in lieu of [the official LTESniffer Repository](https://github.com/SysSec-KAIST/LTESniffer). It uses a version of LTESniffer that has not been kept up to date with the main repo, and an old release of Ubuntu (18.04) whose use is unadvisable. You are advised to use the [official repository instead](https://github.com/SysSec-KAIST/LTESniffer).

------

*LTESniffer* is An Open-Source LTE Downlink/Uplink Eavesdropper

It first decodes the Physical Downlink Control Channel (PDCCH) to obtain the
Downlink Control Informations (DCIs) and Radio Network Temporary Identifiers
(RNTIs) of all active users. Using decoded DCIs and RNTIs, LTESniffer further
decodes the Physical Downlink Shared Channel (PDSCH) and Physical Uplink Shared
Channel (PUSCH) to retrieve uplink and downlink data traffic.

LTESniffer supports an API with three functions for security applications and
research. Many LTE security research assumes a passive sniffer that can capture
privacy-related packets on the air. However, non of the current open-source
sniffers satisfy their requirements as they cannot decode protocol packets in
PDSCH and PUSCH. We developed a proof-of-concept security API that supports
three tasks that were proposed by previous works: 1) Identity mapping, 2) IMSI
collecting, and 3) Capability profiling.

Please refer to the original authors' [paper](https://syssec.kaist.ac.kr/pub/2023/wisec2023_tuan.pdf)
for more details.

Ethical Consideration
---------------------

The main purpose of LTESniffer is to support security and analysis research on the
cellular network. Due to the collection of uplink-downlink user data, any use of
LTESniffer must follow the local regulations on sniffing the LTE traffic. We are
not responsible for any illegal purposes such as intentionally collecting user
privacy-related information.

Please act responsibly.

LTESniffer Docker
-----------------

This repository contains the dockerfile and submodules to build LTESniffer on docker. This repository was
created through the guidance of @hdtuanss the maintainer of the LTESniffer repository. It uses Ubuntu 18.04 as it's base
image, and includes both the repository for [uhd](https://github.com/EttusResearch/uhd) and the repository for
[LTESniffer](https://github.com/SysSec-KAIST/LTESniffer) as git submodules.

Due to the required build dependencies of the LTESniffer, it is not advised to try to build LTESniffer on any
release of Ubuntu other than 18.04 (bionic). This means that once support for the bionic release is dropped by
Ubuntu, a considerable effort will be needed to update the dependencies of the project, and this repository
will cease to function in perpetuity.

### Building

It should be quite easy to build a working instance of LTESniffer within docker performing the following
steps.

1. First, most obviously, you will need to reccursively clone this repository so that you have it's contents
   and the contents of the two submodule repositories.
   ```bash
   git clone --recursive https://github.com/anoduck/ltesniffer-docker.git
   ```
2. Next, you will want to build the docker image. So, change your current directory to the the path of this
   repository and perform the docker build command.
```bash
cd ltesniffer-docker && docker build -t ltesniffer:18.04 .
```
3. Once this completes successfully, you will have a working instance of LTESniffer running on docker. At this
   point you may perform the happy dance.

### Usage

After installation of LTESniffer, it would be a good idea to either 1) create an alias within your shell
configuration, or 2) create a shell script to perform regular / often performed command strings. Either way,
running the docker container is the same as running LTESniffer. The only difference being the conainer is a
docker container, obviously. Below are a few suggestions on how you may go about creating an alias or creating
a shell script to run the container for you.

#### Shell Alias

Creating a shell alias to help you run the docker container is quite simple. Just include the following
snippet in your `~/.bashrc` or `~/.zshrc` file.

```bash
alias ltesniffer="docker run ltesniffer $@"
```

#### Shell script

Creating a little shell script is equally as simmple as creating an alias. You just need to ensure that the
script is in your `$PATH`. For most of us, either `~/bin` or `~/.local/bin` is already in our `$PATH`. Currently,
python places user level installed executables in `~/.local/bin`, so if you do not already have `~/bin/` in
your path, then `~/.local/bin` would probably be the best option.

1. Open up the file `~/.local/bin/ltesniffer` in the text editor of your choosing.

2. Copy and paste the below snippet of code into the text editor, save, and close out the editor.

```bash
#!/usr/bin/env bash

docker run ltesniffer-ubuntu "$@"
```

3. And, that's it. Just run LTESniffer as you would normally from the command line.

## Acknowledgements

Special thanks goes to @hdtuanss of the LTESniffer project.
