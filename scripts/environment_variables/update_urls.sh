#!/bin/bash

# 0. Try to remove existing .venv (if it exists)
rm -rf .venv

# 1. Create virtual environment
python3 -m venv .venv
source .venv/bin/activate

# 2. Install dependencies and run URL update script
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
python3 update_urls.py 