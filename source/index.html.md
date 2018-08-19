---
title: Akash Documentation

toc_footers:
  - <a href='http://akash.network/testnet'>Sign Up for Akash TestNet</a>
  - <a href='http://akash.network'><div class="badge-white-128-80 white"></div></a>

search: true
---

# Introduction

The Akash Network is a decentralized protocol for provisioning, scaling, and securing cloud workloads. Using Akash, companies (Providers) make their spare server capacity available for containerized deployments by any developer (Tenants). Tenants benefit from access to a a low-cost, decentralized, geographically distributed cloud infrastructure platform whose conventions are very similar to any other cloud provider. Providers benefit by monetizing the idle compute capacity in their on-prem and colocated datacenters.

The Network contains two major functional elements:

* **Marketplace**: A blockchain-based system that allocates capacity on provider servers to tenants wishing to deploy to them, and transfers payments from tenant to provider in the native Akash (AKSH) token.

* **Deployment**: A Kubernetes-based system that provisions pods on provider servers and deploys/orchestrates Tenant containers within them.

The permission-less marketplace provides a censorship-resistant procurement mechanism for highly scalable and secure container based deployments for base resources which are compute, memory, bandwidth, and storage.

# Installation

The Akash Suite is composed of a full node `akashd` and the client `akash`.  The full node (`akashd`) is the (tendermint-based) blockchain node that implements the decentralized exchange. `akash` is the client used to access the exchange and network in general.

## MacOS

> Install Homebrew

```shell
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> Install `akash` client using homebrew

```shell
$ brew install ovrclk/tap/akash
```

> Install `akashd` daemon using homebrew

```shell
$ brew install ovrclk/tap/akashd
```

The simplest way to install is by using [homebrew](https://brew.sh)

### Install the client(`akash`)

Install `akash` client by running `brew install ovrclk/tap/akash`. Once installed, verify the installation by running `akash version`.

### Install the daemon (`akashd`)

Install `akashd` daemon by running `brew install ovrclk/tap/akashd`. Once installed, verify the installation by running `akashd version`.

## Others (From Source)

> Installing akash suite from source

```shell
$ go get -d github.com/ovrclk/akash
$ cd $GOPATH/src/github.com/ovrclk/akash
$ make deps-install
$ make install
```

Akash is developed and tested with [golang 1.8+](https://golang.org/).  Building requires a working [golang](https://golang.org/) installation, a properly set `GOPATH`, and `$GOPATH/bin` present in `$PATH`.

Additional requirements are:

* [glide](https://github.com/Masterminds/glide): Golang library management.

For development environments, requirements include:

* [protocol buffers](https://developers.google.com/protocol-buffers/): Protobuf compiler.

Most golang libraries will be packaged in the local `vendor/` directory via [glide](https://github.com/Masterminds/glide), however the following packages will
 be installed globally with their binaries placed in `$GOPATH/bin` by `make devdeps-install`:

* [gogoprotobuf](https://github.com/gogo/protobuf): Golang protobuf compiler plugin.
* [mockery](https://github.com/vektra/mockery): Mock generator.

Once you have the dependencies properly setup, download and build `akash` and `akashd` using `make install`

# TestNet

The Akash testnet is a fully-functioning decentralized cloud, with support for requesting, deploying, and paying for cloud deployments. Server capacity is being kindly provided by Packet, the world's leading bare-metal provider. Access is **free** for registered users. As a free service, capacity is tightly managed, so please treat testnet capacity as the scarce community resource it is.  In other words, please play nicely in our sandbox.


We want your feedback!  Please message us [on Telegram](https://t.me/AkashNW) with any and all of your feedback.  We're putting our in-progess platform out there so that we can get real-world feedback, so don't be shy!

Finally, some warnings. The Akash testnet is at an alpha-level stage of development and so **not intended for production use.**  New functionality and capacity is being added constantly, but is always presented to you as-is, so use at your own risk. Use is at our discretion and we reserve the right to bring down deployments or to re-initialize the chain at any time for any reason.

## Intended users

Fundamentally, the Akash testnet is a deployment platform with a CLI and intended for relatively sophisticated users.  If you are comfortable managing instances via the AWS API and can build and deploy a Docker container, you will find the Akash testnet easy to use.  If not, please feel free to give it a shot, but you might find it confusing.

## Getting help

First of course, [RTFM](#client-usage), then please feel free to ask questions in our [Telegram](http://t.me/akashnw).

## Constraints

### Supported regions

These regions are currently supported by the testnet. More will come online, so check back frequently.

- AMS (Amsterdam, Netherlands)
- NRT (Tokyo, Japan)
- SJC (San Jose, California, USA)
- EWR (New Jersey, USA)

### Uptime and availability

The Akash testnet is at an alpha-level stage of development and so **not intended for production use.**  New functionality and capacity is being added constantly, but is always presented to you as-is, so use at your own risk. Use is at our discretion and we reserve the right to bring down deployments or to re-initialize the chain at any time for any reason. 

## Getting Started

The testnet supports this basic workflow:

1. Register and receive testnet tokens
1. Deploy your image
1. Close your deployment (i.e. deprovision containers)

The sections below describe each step.

### Register for the testnet

You must register with Akash to request access to the testnet. This is a one-time only action.  After registering, you will receive a set of Akash testnet tokens **Please note that testnet tokens are only usable on the Akash testnet and have no market value.**

To register:

1. Go to [akash.network/testnet](/https://akash.network/testnet) and follow the instructions.
1. You'll immediately receive a confirmation email.  Click the link inside to confirm your email and request testnet tokens.
1. After review by our staff, we will send tokens to your address and confirm with another email.

If you wish to receive another token allocation, repeat these steps and we will happily consider your request.

# Deployment Guide

In this step, you actually use the testnet to deploy an image, paying with your testnet tokens.

## 1. Check your balance

```shell
$ akash key list #returns your key names and values
$ akash query account [key value] #returns your balance
```

> For, example:

```shell
$ akash key list
my-key-name 4b5446b97930b1885d11550cb2b277b6fee8e3ce

$ akash query account 4b5446b97930b1885d11550cb2b277b6fee8e3ce
{
  "address": "4b5446b97930b1885d11550cb2b277b6fee8e3ce",
  "balance": 420,
  "nonce": 1
}
```

List your keys using `akash key list` command and query your balance using `akash query account [key value]` command.

## 2. Download the sample deployment file and modify it if desired. 

> Download using cURL

```shell
$ curl -s https://raw.githubusercontent.com/ovrclk/akash/master/_docs/testnet/testnet-deployment.yml > testnet-deployment.yml
```

The sample deployment file specifies a small webapp container running a simple demo site we created. [You may download it here](https://raw.githubusercontent.com/ovrclk/akash/master/_docs/testnet/testnet-deployment.yml).

You may use the sample deployment file as-is or modify it for your own needs as desscribed in our [SDL (Stack Definition Language) documentation](https://github.com/ovrclk/akash/blob/master/_docs/sdl.md). A typical modification would be to reference your own image instead of our demo app image.  Note that you are limited in the amount of testnet resources you may request. Please see the [constraints section](#constraints).


## 3. Create the deployment

> Create a deployment

```shell
$ akash deployment create ./testnet-deployment.yml -k my-key-name
66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357
Waiting...
Group 1/1 Fulfillment: 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357/1/2/49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9befc [price=11]
Group 1/1 Fulfillment: 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357/1/2/a8954503bdd62134bf691c954d4eba3099952424ed708c7b69afeecaa8f9b38f [price=13]
Group 1/1 Lease: 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357/1/2/49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9befc [price=11]
Sending manifest to http://sjc.147.75.70.13.aksh.io...
Service URIs for provider: 38323234653134663930336132653133366136333632353237623139663131393335313937313735636236393938313934303933336161303434353961326139
	webapp: webapp.a138530f21e98e88bfc449d6736798fbe5130fa99b748d7aeb5d08b15e326cb8.147.75.70.13.aksh.io
```

<aside class="notice">
You must replace <code>my-key-name</code> with the key name you created during testnet registration
</aside>


In this step, you post your deployment, the Akash marketplace matches you with a provider via auction, and your image is deployed. To create a deployment use `akash deployment`. The syntax for the deployment is `akash deployment <deployment file path> -k <key name>`.

The client will print the deployment id, bid, lease, and deployment data to console. Alternatively, you may also query your leases with `akash query lease`.


> Check the status of the lease

```shell
$ akash query lease
{
  "items": [
    {
      "id": {
        "deployment": "66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357",
        "group": 1,
        "order": 2,
        "provider": "49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9befc"
      },
      "price": 11
    }
  ]
}
```

The price of your deployment is transferred from your account every second.


## 4. Access your deployed application in whatever way makes sense to you

> Check the application logs using `akash logs` command, with the below syntax:

```shell
$ akash logs <service name> <lease>
```

> For example:

```shell
$ ./akash logs webapp 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357/1/2/49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9befc -l 1 -f
[webapp-58c8984dfd-nbf6g]  2018-07-04T01:57:55.141522165Z 172.17.0.5 - - [04/Jul/2018:01:57:55 +0000] "GET /images/favicon.png HTTP/1.1" 200 1825 "http://hello.192.168.99.100.nip.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" "192.168.99.1"
[webapp-58c8984dfd-nbf6g]  2018-07-04T01:57:57.255819449Z 172.17.0.5 - - [04/Jul/2018:01:57:57 +0000] "GET /images/favicon.png HTTP/1.1" 200 1825 "http://hello.192.168.99.100.nip.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" "192.168.99.1"
[webapp-58c8984dfd-nbf6g]  2018-07-04T02:03:04.221319604Z 172.17.0.5 - - [04/Jul/2018:02:03:04 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36" "192.168.99.1"
```

You may also view your application logs with `akash logs <service name> <lease>`.  The lease id is constructed as `[deployment]/[group]/[order]/[provider]`

For example, given a service named `webapp`, the lease in the previous has the below properties:

Attribute | Value
--------- | -----------
deployment | 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357
group | 1
order | 2
provider | 49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9befc

So, the lease id would be `66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357/1/2/49877504638723665f08dd57c2b0fbae79bd2abf65fe0d397e20880953b9be`


## 5. Close your deployment

> Close deployment using `deployment close` command:

```shell
$ akash deployment close <deployment id> -k <key name>
```

> For example:

```shell
$ akash deployment close 66809b2c537fcdd79bc6b5b6d28bbf2d51fbe59133a4ba0119b9e0160ab16357 -k my-key-name
Closing deployment
```

When you are done with your application, close the deployment. This will deprovision your container and stop the token transfer. This is a critical step to conserve both your tokens and testnet server capacity.

# Client Usage

This section describes usage of the Akash client for requesting and managing deployments to the Akash Network.

### Installation

Installation instructions for the client binary may be found [here](#installing). Each of these package managers will install both `akashd` (the server) and `akash` (the client). This document describes client usage only.

### The Akash TestNet
The Akash testnet is available for public use.A description of the testnet, registration instructions, and a getting-started guide may be found [here](#testnet).

## Top-level commands

> You can access help using `akash help`:

These commands are presented as an overview of the features available via the Akash client. Individual command usage is described in subsequent sections.

```shell
$ akash help
```

> Outputs:

```
Akash client

Usage:
  akash [command]

Available Commands:
  deployment  manage deployments
  help        Help about any command
  key         Key commands
  logs        service logs
  marketplace monitor marketplace
  provider    manage provider
  query       query something
  send        send tokens
  status      get remote node status
  version     Print version

Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")
  -h, --help          help for akash

Use "akash [command] --help" for more information about a command
```

| Command | Description |
|:--|:--|
| [deployment](#manage-deployments) | Manage deployments. |
| [key](#manage-keys) | Manage keys. |
| [logs](#display-logs) | Service logs |
| [marketplace](#monitor-marketplace) | Monitor marketplace. |
| [provider](#manage-providers) | Manage provider. |
| [query](#query-network) | Query things that need querying. |
| [send](#transfer-tokens) | Send tokens to an account. |
| [status](#check-network-status) | Get remote node status. |
| [version](#check-version) | Print Akash version. |

**Flags**

Every command accepts the following flags. For brevity, they are omitted from the following documentation.

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -h | --help | None | N | Help for any command. |
| -d | --data | String | N | User data directory (defaults to `~/.akash`).  |


# Manage Deployments

> **Usage**

```shell
$ akash deployment [command]
```

> **Example**

```shell
$ akash deployment help

manage deployments

Usage:
  akash deployment [command]

Available Commands:
  close       close a deployment
  create      create a deployment
  sendmani    send manifest to all deployment providers
  status      get deployment status
  update      update a deployment (*EXPERIMENTAL*)
  validate    validate deployment file

Flags:
  -h, --help   help for deployment

Global Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")

Use "akash deployment [command] --help" for more information about a command.
```

Use `akash deployment` to create, manage, and query your deployments.

**Available Commands**

| Command | Description |
|:--|:--|
| close | Close a deployment. |
| create | Create a deployment. |
| sendmani | Send manifest to all deployment providers. |
| status | Get deployment status. |
| validate | Validate deployment file. |

## `close`

> **Usage**

```shell
$ akash deployment close <deployment-id> [flags]
```

> **Example**

```shell
$ akash deployment close 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42 -k my-key-name
Closing deployment
```

Close one of your deployments. Deletes the pod(s) containing your container(s) and stops token transfer.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| deployment-id | string | Y | ID of the deployment to close, returned by (`akash query deployment`) |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. Tokens will be transferred from the account associated with this key. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |
|  | --nonce | uint | N | Nonce. |


## `create`

> **Usage**

```shell
$ akash deployment create <deployment-file> [flags]
```

> **Example**

```shell
$ akash deployment create testnet-deployment.yml -k my-key-name
619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
Waiting...
Group 1/1 Fulfillment: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=57]
Group 1/1 Fulfillment: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737 [price=70]
Group 1/1 Lease: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=57]
Sending manifest to http://provider.ewr.salusa.akashtest.net...
Service URIs for provider: 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
	webapp: webapp.48bc1ea9-c2aa-4de3-bbfb-5e8d409ae334.147-75-193-181.aksh.io
```

Create a new deployment. Posts your requested to the chain for bidding and subsequent lease creation. Your manifest(s) are then sent to the winning provider(s), pod(s) created, and token transfer from your account to provider(s) initiated.

In the example:
 
 - **deployment-id**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450`
 - **lease**: `619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44` (in the form [deployment id]/[deployment group number]/[order number]/[provider address])
 - **service URI**: `webapp.48bc1ea9-c2aa-4de3-bbfb-5e8d409ae334.147-75-193-181.aksh.io`
 - **price**: Given in microAKSH (AKSH * 10^-6).

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| deployment-file | string | Y | Absolute or relative path to your deployment file. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. |
|  | --no-wait | none | N | Exit before waiting for lease creation. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |
|  | --nonce | uint | N | Nonce |

## `sendmani`

> **Usage**

```shell
$ akash deployment sendmani <deployment-file> <deployment-id> [flags]
```

> **Example**

```shell
$ akash deployment sendmani testnet-deployment.yml 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450 -k my-key-name
```

Sends manifest directly to a deployment's provider(s), using data from the deployment file. Use this command after creating a deployment using the `--no-wait` flag.


**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| manifest | String | Y | **?** |
| deployment-id | string | Y | ID of the deployment to for which to send the manifest, returned by (`akash query deployment`.  |


**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

## `status`

> **Usage**

```shell
$ akash deployment status <deployment-id> [flags]
```

> **Example**

> Deployment is open

```
$ akash deployment status 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450
lease: 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44
	webapp: webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io
```

> Deployment is closed

```
$ akash deployment close 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42 -k my-key-name
```
Get the lease and service URI(s) for an open deployment.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| deployment-id | string | Y | ID of the deployment to check, returned by `akash query deployment`  |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

## `validate`
Validate the syntax and structure of a deployment file.

> **Usage**

```shell
$ akash deployment validate <deployment-file> [flags]
```

> **Example**

> File passes validation

```shell
$ akash deployment validate testnet-deployment.yml 
ok
```

> File does not pass validation (min price too low)

```shell
$ akash deployment validate badfile.yml
Error: group specs: group san-jose: price too low (1 >= 25 fails)
```

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| deployment-file | string | Y | Absolute or relative path to your deployment file. |

**Flags**

None

# Manage Keys

> **Usage**

```shell
$  akash key [subcommand]
```

> **Example**

```shell
$  akash key help

Key commands

Usage:
  akash key [command]

Available Commands:
  create      Create new key
  list        list keys
  show        display a key

Flags:
  -h, --help   help for key

Global Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")

Use "akash key [command] --help" for more information about a command.
```

Use `akash key` to create and manage your keys. 

**Available Commands**

| Command | Description |
|:--|:--|
| create | Create new key |
| list | List all your keys |
| show | Display a single key |

## `create`

> **Usage**

```shell
akash key create <key-name> [flags]
```

> **Example**

```shell
$ akash key create my-key-name
8d2cb35f05ec35666bbc841331718e31415926a1
```

Create a new key to use in the Akash Network. A key links to an Akash account and is used to authenticate to the network.

In the example:

**key value**: `8d2cb35f05ec35666bbc841331718e31415926a1`

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| key-name | string | Y | A meaningful-to-you name for your key. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -t | --type | (ed25519\|secp256k1\|ledger) | N | Type of key (default "ed25519"). |

## `list`

> **Usage**

```shell
$ akash key list [flags]
```

> **Example**

```shell
$ akash key list

my-key-name 		8d2cb35f05ec35666bbc841331718e31415926a1
my-other-key-name 	35c055f1fa38cb1864e484a1d733a58bbffb1156
```

List all your local keys.

**Arguments**

None

**Flags**

None

## `show`

> **Usage**

```shell
$ akash key show <key-name> [flags]
```

> **Example**

```shell
$ akash key show my-key-name
8d2cb35f05ec35666bbc841331718e31415926a1
```

Show the key value belonging to a key name.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| key-name | string | Y | Name of the key to display. |

**Flags**

None

# Display Logs

> **Usage**

```shell
$ akash logs <service> <lease> [flags]
```

> **Example**

```shell
$ akash logs webapp 619d25a730f8451b1ba3bf9c1bfabcb469068ad7d8da9a0d4b9bcd1080fb2450/1/2/5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 -f
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.307976982Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET / HTTP/1.1" 200 3583 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.614215684Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /css/main.css HTTP/1.1" 200 195072 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
[webapp-64bcb5d547-fblkv] 2018-08-01T00:08:51.712794998Z 192.168.0.1 - - [01/Aug/2018:00:08:51 +0000] "GET /images/qr.png HTTP/1.1" 200 7039 "http://webapp.9060b8ae-1b62-47ff-a247-164f2f081681.147-75-193-181.aksh.io/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" "73.162.194.173"
```

> In the example above, `webapp` is a simple web page serving static content.

Use `akash logs` to tail the application logs for each of your services.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| service | string | Y | The service name originally defined in your deployment file |
| lease | string | Y | The lease ID belonging to that service, returned by `akash deployment status` |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -f | --follow | none | N | Whether update the console with new log lines or simply return the last n lines defined by `-l`. |
| -l | --lines | uint | N | Number of lines from the end of the logs to show per service (default 10). |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

# Monitor Marketplace

> **Usage**

```shell
$ akash marketplace [flags]
```

> **Example**

```shell
$ akash marketplace
DEPLOYMENT CREATED	4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8 created by 35c055f1fa38cb1864920e2a7619d4f95d18c125
ORDER CREATED	4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2
FULFILLMENT CREATED	4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=48]
FULFILLMENT CREATED	4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737 [price=54]
LEASE CREATED	4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8/1/2 by 5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44 [price=48]
```
> In the example above, `price` is given in microAKSH (AKSH * 10^-6).

Use `akash marketplace` for monitoring marketplace transactions.

**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

# Manage Providers

> **Usage**

```shell
akash provider [command]
```

> **Example**

```shell
$ akash provider help

manage provider

Usage:
  akash provider [command]

Available Commands:
  closef      close an open fulfillment
  closel      close an active lease
  create      create a provider
  run         respond to chain events
  status      print status of (given) providers

Flags:
  -h, --help          help for provider
  -n, --node string   node host (default "http://api.akashtest.net:80")

Global Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")

Use "akash provider [command] --help" for more information about a command.
```

Use `akash provider` to manage provider(s)

**Available Commands**

| Command | Description |
|:--|:--|
| closef | Close an open fulfillment. Used by providers; not documented here.|
| closel | Close an active lease. Used by providers; not documented here. |
| create | Create a provider. Used by providers; not documented here. |
| run | Respond to chain events. Used by providers; not documented here. |
| status | Print provider details. |

`akash provider` is used to manage providers. This command is intended for providers, so this section will only address commands that are useful for a client creating and managing deployments.


## `status`

Retrieve the attributes and status of one or more providers.

> **Usage**

```shell
$ akash provider status [<provider-id> ...] [flags]
```

> **Example**

```shell
$ akash provider status d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276
[
 {
  "Provider": {
   "address": "d714ecb330d5a3873bdc88e9fce10dab1a65287fac4fe55c80ac48776fa83276",
   "owner": "59e018689248c527ed8a755a9c67ec647ce77d28",
   "hostURI": "http://provider.sjc.arrakis.akashtest.net",
   "attributes": [
    {
     "name": "region",
     "value": "sjc"
    }
   ]
  },
  "Status": {
   "code": 200,
   "version": {
    "version": "0.3.3",
    "commit": "4786994cf709e2829aadf64d05b07212e4a8ce28",
    "date": "2018-07-31T20:43:05Z"
   },
   "message": "OK"
  }
 }
```

**Arguments**

None

**Flags**

None

# Query Network

> **Usage**

```shell
$ akash query [command]
```

> **Example**

```shell
$ akash query help

query something

Usage:
  akash query [command]

Available Commands:
  account          query account
  deployment       query deployment
  deployment-group query deployment groups
  fulfillment      query fulfillment
  lease            query lease
  order            query order
  provider         query provider

Flags:
  -h, --help          help for query
  -n, --node string   node host (default "http://api.akashtest.net:80")

Global Flags:
  -d, --data string   data directory (default "/Users/gosuri/.akash")

Use "akash query [command] --help" for more information about a command.
```

Use `akash query` to query all the things that need querying.

**Available Commands**

| Command | Description |
|:--|:--|
| account | Query account details. |
| deployment | Query deployment details. |
| deployment-group | Query deployment-group details. |
| fulfillment | Query fulfillment details. |
| lease | Query lease details. |
| order | Query order details. |
| provider | Query provider details. |

## `account`

> **Usage**

```shell
akash query account [account ...] [flags]
```

> **Example**

```shell
$ akash query account -k my-key-name
{
  "address": "8d2cb35f05ec35666bbc841331718e31415926a1",
  "balance": 90351025,
  "nonce": 7
}
```

> In the example above, token balance is given in microAKSH `(AKSH * 10^-6)`.

Retrieve the details for one or more of your accounts, including token balance.

**Arguments**

 Argument | Type | Required | Description |
|:--|:--|:--|:--|
| account | string | N | One or more account addresses to query. Omitting this argument returns all your accounts for the provided key. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

## `deployment`

> **Usage**

```shell
akash query deployment [deployment ...] [flags]
```

> **Example**

```shell
$ akash query deployment -k alpha

{
  "items": [
    {
      "address": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
      "tenant": "8d2cb35f05ec35666bbc841331718e31415926a1",
      "state": 2,
      "version": "8e02ba39187cbd2de194a7ac3b31ffe9889856d4b817fc039669e569fde6c647"
    },
    {
      "address": "4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8",
      "tenant": "8d2cb35f05ec35666bbc841331718e31415926a1",
      "version": "8e02ba39187cbd2de194a7ac3b31ffe9889856d4b817fc039669e569fde6c647"
    },
...
  ]
}
```

Retrieve the details for one or more of your deployments. A deployment represents a request for provider resources.

In the example:

- **"state": 2**: indicates a closed deployment.  
- **version**: is a hash of the manifest, used by provider to verify incoming manifest content

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| deployment | string | N | One or more deployment ids to query. Omitting this argument returns all your deployments. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |


## `fulfillment`

> **Usage**

```shell
akash query fulfillment [fulfillment ...] [flags]
```

> **Example**

```shell
$ akash query fulfillment
{
  "items": [
    {
      "id": {
        "deployment": "2a15e3d0a5ed9201f46f9d4c8e0a80579d202b6bee90ff7fac613f1b289bdf9d",
        "group": 1,
        "order": 2,
        "provider": "4be226880fce4efd19f81c87cebc86bf001e05a7aae7b862d421f3ec36f9e345"
      },
      "price": 71
    },
    {
      "id": {
        "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
        "group": 1,
        "order": 2,
        "provider": "5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44"
      },
      "price": 73,
      "state": 2
    },
...
  ]
}
```

> In the example above, `"state": 2` indicates a closed fulfillment.

Retrieve the details for one or more fulfillments made for your deployments. A fulfillment represents a provider's bid on your deployments. 

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| fulfillment | string | N | One or more fulfillment ids to query. Omitting this argument returns all fulfillments that resulted in leases. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |


## `lease`

> **Usage**

```shell
$ akash query lease [lease ...] [flags]
```

> **Example**

```shell
$ akash query lease -k my-key-name
{
  "items": [
    {
      "id": {
        "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
        "group": 1,
        "order": 2,
        "provider": "d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737"
      },
      "price": 52,
      "state": 2
    },
    {
      "id": {
        "deployment": "4b24d14fe47d1b360fb6cebd883a5ba65f9876e62ba1ac27ace79001b42475e8",
        "group": 1,
        "order": 2,
        "provider": "5ed78fbc526270c3501d09f88a3c442cf1bc6c869eb2d4d6c4f4eb4d41ee3f44"
      },
      "price": 48
    },
...
  ]
}
```

> In the example above, `"state": 2` indicates a closed lease.

```shell
$ akash query lease 3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42/1/2/d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737
{
  "id": {
    "deployment": "3be771d6ce0a9e0b5b8caa35d674cdd790f94500226433ab2794ee46d8886f42",
    "group": 1,
    "order": 2,
    "provider": "d56f1a59caabe9facd684ae7f1c887a2f0d0b136c9c096877188221e350e4737"
  },
  "price": 52,
  "state": 2
}
```

> In the example above, the lease is specified in the form `[deployment id]/[deployment group number]/[order number]/[provider address]` and the `-k` flag is not required.

Retrieve the details for one or more of your leases. A lease represents an agreement between you and the lowest-bidding provider to provide resources as for the price specified in their  fullfillment.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| lease | string | N | One or more leases to query. Omitting this argument returns all your leases. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Conditional | Name of one of your keys, for authentication. Required when fetching all an account's leases, but not when fetching one lease. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |


## `order`

> **Usage**

```shell
$ akash query order [order ...] [flags]
```

> **Example**

```shell
$ akash query order
{
  "items": [
    {
      "id": {
        "deployment": "16bfd04ba37ca64ba675e47d2fb5fcab6c5c3c3e949d71f0012cd65a81dd6507",
        "group": 1,
        "seq": 2
      },
      "endAt": 3519,
      "state": 2
    },
    {
      "id": {
        "deployment": "2a15e3d0a5ed9201f46f9d4c8e0a80579d202b6bee90ff7fac613f1b289bdf9d",
        "group": 1,
        "seq": 2
      },
      "endAt": 204,
      "state": 1
    },
...
  ]
}
```

Retrieve the details for one or more of your orders.  An order is an internal representation of a deplyoyment group: the resources from your deployment that may be fulfilled by a single provider.

In the example:

- **"state": 2**: indicates a closed order. 
- **endAt**: indicates the block number upon which all fulfillments must be issued, prior to awarding a lease

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| order | string | N | One or more order ids to query. Omitting this argument returns all your orders. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

## `provider`

> **Usage**

```shell
$ akash query provider [provider ...] [flags]
```

> **Example**

```shell
$ akash query provider
{
  "providers": [
    {
      "address": "0253c080e189825da0e072ed8213947bb5d9386f4504ab9c15a15f5776600e83",
      "owner": "73ff91326664be3dad53b3b58e9d1fe08dfbec74",
      "hostURI": "http://provider.ewr.caladan.akashtest.net",
      "attributes": [
        {
          "name": "region",
          "value": "ewr"
        }
      ]
    },
    {
      "address": "4be226880fce4efd19f81c87cebc86bf001e05a7aae7b862d421f3ec36f9e345",
      "owner": "e6956171534f8ffbcf47c6830788df4ebbb165a9",
      "hostURI": "http://provider.sjc.arrakis.akashtest.net",
      "attributes": [
        {
          "name": "region",
          "value": "sjc"
        }
      ]
    },
...
  ]
}
```

Retrieve the attributes of one or more providers.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| provider | string | N | One or more provider ids to query. Omitting this argument returns all providers in the network. |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

# Transfer Tokens

> **Usage**

```shell
akash send <amount> <to-account> [flags]
```

> **Example**

```shell
$ akash send 1.1 35c055f1fa38cb1864e484a1d733a58bbffb1156 -k alpha
Sent 1.1 tokens to 35c055f1fa38cb1864e484a1d733a58bbffb1156 in block 61049
```

> In the example above, the amount is given in AKSH.  You may also specify the amount in microAKSH (AKSH * 10^-6) using the `u` unit suffix (e.g. `100u` for 100 microAKSH).

Use `akash send` to send tokens from one account to another.

**Arguments**

| Argument | Type | Required | Description |
|:--|:--|:--|:--|
| amount | float | Y | The amount of tokens to send. |
| to-account | string | Y | The key value for the recipient account.  |

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -k | --key | string | Y | Name of one of your keys, for authentication. Tokens will be sent from this account. |
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |
|  | --nonce | uint | N | Nonce. |

# Check Network Status

> **Usage**

```shell
akash status [flags]
```

> **Example**

```shell
$ akash status
Block: 61553
Block Hash: 734FBC125E094CBC18311B85B3D278E820891D06
```

Use `akash status` to get the status of a remote node.

**Arguments**

None

**Flags**

| Short | Verbose | Argument | Required | Description |
|:--|:--|:--|:--|:--|
| -n | --node | string | N | Node host (defaults to https://api.akashtest.net:80). |

# Check Version

> **Usage**

```shell
$ akash version [flags]
```

> **Example**

```shell
$ akash version
version:  0.3.4
commit:   8e90774b47cc3791603d443301038e4dbf49c748
date:     2018-08-01T06:45:59Z
```

Use `akash version` to get the client version.

**Arguments**

None

**Flags**

None
