#!/bin/sh
ls ~/.local/share/mail > /dev/null && ls -l ~/.local/share/mail/*/INBOX/new/* | wc -l ||  echo '?'
