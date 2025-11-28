#!/bin/bash
  set -e

  # Execute PHP-FPM with all arguments
  exec "$@" --nodaemonize
