#!/bin/bash
# Full dependency installer

# System packages
sudo apt update && sudo apt install -y \
    jq python3-pip golang docker.io \
    i2c-tools libgpiod-dev

# Python requirements
pip3 install \
    smbus2 RPi.GPIO opencv-python \
    speechrecognition

# Go modules
go get github.com/golang-jwt/jwt/v5 \
    github.com/gorilla/mux \
    github.com/stretchr/testify/assert

# Ollama setup
git clone https://github.com/ollama/ollama
cd ollama && make && sudo make install