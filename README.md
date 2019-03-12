Cakeshop-in-a-Box
=============

By [@imylomylo](https://github.com/imylomylo) and [contributors](https://github.com/Komodo-Cakeshop/cakeshopinabox/graphs/contributors).

Cakeshop-in-a-Box helps individuals and group  take back control of their economy by defining a one-click, easy-to-deploy blockchain+services server: a cakeshop in a box.

**Please see [https://komodo-cakeshop.com](https://komodo-cakeshop.com) for the project's website and setup guide!**

* * *

Project goals are to:

* Make deploying a good blockchain server easy.
* Promote innovation, and self-determination on the web.
* Build community projects and proof of concepts for people to learn
* **Not** make a totally unhackable, NSA-proof server.
* **Not** make something customizable by power users.

The Box
-------

Cakeshop-in-a-Box turns a fresh Ubuntu 18.04 LTS 64-bit machine into a working blockchain server by installing and configuring various components.

It is a one-click blockchain appliance. There are no user-configurable setup options. It "just works".

The components installed are:

* Custom blockchain platform by ([Komodo](http://komodoplatform.com/)) for building ecosystems.

It also includes:

* to do...
* to do...

Installation
------------

See the [setup guide](https://komodo-cakeshop.com/guide) for detailed, user-friendly instructions.

For experts, start with a completely fresh (really, I mean it) Ubuntu 18.04 LTS 64-bit machine. On the machine...

Clone this repository:

	$ git clone https://github.com/Komodo-Cakeshop/cakeshopinabox
	$ cd cakeshopinabox
	$ sudo setup/start.sh

# Original Mail-In-a-Box Information

The following is info from [Mail-In-a-Box](https://mailinabox.email) where I got the inspiration to create Cakeshop-In-a-Box.

_Optional:_ Download Josh's PGP key and then verify that the sources were signed
by him:

	$ curl -s https://keybase.io/joshdata/key.asc | gpg --import
	gpg: key C10BDD81: public key "Joshua Tauberer <jt@occams.info>" imported

	$ git verify-tag v0.41
	gpg: Signature made ..... using RSA key ID C10BDD81
	gpg: Good signature from "Joshua Tauberer <jt@occams.info>"
	gpg: WARNING: This key is not certified with a trusted signature!
	gpg:          There is no indication that the signature belongs to the owner.
	Primary key fingerprint: 5F4C 0E73 13CC D744 693B  2AEA B920 41F4 C10B DD81

You'll get a lot of warnings, but that's OK. Check that the primary key fingerprint matches the
fingerprint in the key details at [https://keybase.io/joshdata](https://keybase.io/joshdata)
and on his [personal homepage](https://razor.occams.info/). (Of course, if this repository has been compromised you can't trust these instructions.)

Checkout the tag corresponding to the most recent release:

	$ git checkout v0.41

Begin the installation.

	$ sudo setup/start.sh

For help, DO NOT contact Josh directly --- I don't do tech support by email or tweet (no exceptions).

Post your question on the [discussion forum](https://discourse.mailinabox.email/) instead, where maintainers and Mail-in-a-Box users may be able to help you.

Contributing and Development
----------------------------

Mail-in-a-Box is an open source project. Your contributions and pull requests are welcome. See [CONTRIBUTING](CONTRIBUTING.md) to get started. 


The Acknowledgements
--------------------

This project was inspired in part by the ["NSA-proof your email in 2 hours"](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/) blog post by Drew Crawford, [Sovereign](https://github.com/sovereign/sovereign) by Alex Payne, and conversations with <a href="https://twitter.com/shevski" target="_blank">@shevski</a>, <a href="https://github.com/konklone" target="_blank">@konklone</a>, and <a href="https://github.com/gregelin" target="_blank">@GregElin</a>.

Mail-in-a-Box is similar to [iRedMail](http://www.iredmail.org/) and [Modoboa](https://github.com/tonioo/modoboa).

The History
-----------

* In 2007 I wrote a relatively popular Mozilla Thunderbird extension that added client-side SPF and DKIM checks to mail to warn users about possible phishing: [add-on page](https://addons.mozilla.org/en-us/thunderbird/addon/sender-verification-anti-phish/), [source](https://github.com/JoshData/thunderbird-spf).
* In August 2013 I began Mail-in-a-Box by combining my own mail server configuration with the setup in ["NSA-proof your email in 2 hours"](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/) and making the setup steps reproducible with bash scripts.
* Mail-in-a-Box was a semifinalist in the 2014 [Knight News Challenge](https://www.newschallenge.org/challenge/2014/submissions/mail-in-a-box), but it was not selected as a winner.
* Mail-in-a-Box hit the front page of Hacker News in [April](https://news.ycombinator.com/item?id=7634514) 2014, [September](https://news.ycombinator.com/item?id=8276171) 2014, [May](https://news.ycombinator.com/item?id=9624267) 2015, and [November](https://news.ycombinator.com/item?id=13050500) 2016.
* FastCompany mentioned Mail-in-a-Box a [roundup of privacy projects](http://www.fastcompany.com/3047645/your-own-private-cloud) on June 26, 2015.
