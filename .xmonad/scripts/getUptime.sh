#!/bin/bash

uptime | awk '{ printf $3 }'
