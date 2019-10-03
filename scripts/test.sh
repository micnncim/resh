#!/usr/bin/env bash

[ "${BASH_SOURCE[0]}" != "scripts/test.sh" ] && echo 'Run this script using `make test`' && exit 1 

for f in scripts/*.sh; do
    echo "Running shellcheck on $f ..."
    shellcheck $f --shell=bash --severity=error || exit 1
done

echo "Checking Zsh syntax of scripts/shellrc.sh ..."
! zsh -n scripts/shellrc.sh && echo "Zsh syntax check failed!" && exit 1

for sh in bash zsh; do
    echo "Running functions in scripts/shellrc.sh using $sh ..."
    ! $sh -c ". scripts/shellrc.sh; __resh_preexec; __resh_precmd" && echo "Error while running functions!" && exit 1
done

# TODO: test installation

exit 0