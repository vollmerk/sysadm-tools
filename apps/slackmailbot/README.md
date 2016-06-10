Slackmailbot
=======

Checks a local mail spool for a specific e-mail FROM: pattern, if found fires it up to slack. We use this because we're too cheap to pay for slack. Written in python quickly and expects to be run from cron


#### Requirements
It requires the following python modules. 

* slackweb https://github.com/satoshi03/slack-python-webhook
* html2text
* tzlocal
* re, os, mailbox, ConfigParser
