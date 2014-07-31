#!/bin/bash

grep '^[^#]' /etc/modules |
  while read module args
  do
    [ "$module" ] || continue
    modprobe $module $args || :
  done
