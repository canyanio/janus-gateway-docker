[![Build Status](https://gitlab.com/canyan/janus-gateway-docker/badges/master/pipeline.svg)](https://gitlab.com/canyan/janus-gateway-docker/pipelines) [![Docker pulls](https://img.shields.io/docker/pulls/canyan/janus-gateway.svg?maxAge=3600)](https://hub.docker.com/repository/docker/canyan/janus-gateway)

# Janus WebRTC Server

This repository provides the Dockerfile to build a full-featured docker image for the [Janus WebRTC Server](https://github.com/meetecho/janus-gateway) based on Debian buster.

Janus is an open source, general purpose, WebRTC server designed and developed by [Meetecho](http://www.meetecho.com). This version of the server is tailored for Linux systems, although it can be compiled for, and installed on, MacOS machines as well. Windows is not supported, but if that's a requirement, Janus is known to work in the "Windows Subsystem for Linux" on Windows 10.

For some online demos and documentations, make sure you pay the [project website](https://janus.conf.meetecho.com/) a visit!

To discuss Janus with us and other users, there's a Google Group called [meetecho-janus](https://groups.google.com/forum/#!forum/meetecho-janus) that you can use. If you encounter bugs, though, please submit an issue on [github](https://github.com/meetecho/janus-gateway/issues) instead.

## Usage

You can use the docker image as follows:

```bash
$ docker pull canyan/janus-gateway:latest
```

We provide the following tags:

* **latest**: points to the latest stable version
* **full version number (e.g., 0.10.7)**
* **major version number (e.g., 0.10)**
* **master**: daily rebuild of the master branch

You can use the docker-image in a docker-compose project including:

```yaml
version: '2.1'
services:

  #
  # janus-gateway
  #
  janus-gateway:
    image: 'canyan/janus-gateway:0.10.7'
    command: ["/usr/local/bin/janus", "-F", "/usr/local/etc/janus"]
    ports:
      - "8188:8188"
      - "8088:8088"
      - "8089:8089"
      - "8889:8889"
      - "8000:8000"
      - "7088:7088"
      - "7089:7089"
    volumes:
      - "./etc/janus/janus.jcfg:/usr/local/etc/janus/janus.jcfg"
      - "./etc/janus/janus.eventhandler.sampleevh.jcfg:/usr/local/etc/janus/janus.eventhandler.sampleevh.jcfg"
    restart: always
```

## Authors

This dockerfile is maintained by Canyan.io.

Canyan Rating is an open source real-time highly scalable rating system. It is composed of an Agent Service, an API, and a Rating Engine.

The rating system is a critical component in any business, especially when real-time features are a strict requirement to ensure business continuity and congruence of transactions. Any compromise to availability, integrity, and authentication in the billing system makes a huge impact on the services provided.

Canyan aims to address these challenges with a cloud-native scalable solution, easily deployable and easily usable. It has been designed to work atomically ensuring the system status is always consistent, reproducible and coherent. Asynchronous processing of no real-time, consolidation events, prioritization, and time-boxed tasks provide the basics to ensure lightning-fast transaction processing without compromises.

Ease of use is addressed with comprehensive documentation, examples and high-quality software (see the test coverage badge).

Canyan Rating is designed as a microservice architecture and comprises [several repositories](https://github.com/canyanio). Its components are stateless and easily deployable via containers on-premises or in the cloud. This repository contains the Canyan Rating API.

![Canyan logo](https://canyanio.github.io/rating-integration/canyan-logo.png)

## Getting started

To start using Canyan Rating, we recommend that you begin with the Getting started
section in [the Canyan Rating documentation](https://canyanio.github.io/rating-integration/).

## Contributing

We welcome and ask for your contribution. If you would like to contribute to Canyan Rating, please read our guide on how to best get started [contributing code or documentation](https://canyanio.github.io/rating-integration/contributing/).

## License

Canyan is licensed under the GNU General Public License version 3. See
[LICENSE](https://canyanio.github.io/rating-integration/license/) for the full license text.

## Security disclosure

We take Canyan's security and our users trust very seriously.
If you believe you have found a security issue in Canyan, please responsibly
disclose by contacting us at [security@canyan.io](mailto:security@canyan.io).

## Connect with us

* Follow us on [Twitter](https://twitter.com/canyan_io). Please
  feel free to tweet us questions.
* Connect with us on [LinkedIN](https://www.linkedin.com/company/canyan/).
* Join us on [Slack](http://slack.canyan.io)
* Fork us on [Github](https://github.com/canyanio)
* Email us at [info@canyan.io](mailto:info@canyan.io)
