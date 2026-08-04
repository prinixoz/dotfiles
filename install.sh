#!/bin/bash
stow -vt ~ config
stow -vt ~ scripts
sudo stow -vt / root --adopt
sudo stow -vt /root/ config
