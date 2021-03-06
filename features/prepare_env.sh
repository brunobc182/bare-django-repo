#!/usr/bin/env bash

source ${UTILS_PATH}/log_messages.sh

ENV_PATH=${APP_PATH}/env

APP_JSON=${PROJECT_PATH}/app.json

if [ ! -d ${ENV_PATH} ]; then
  APP_NAME=$(basename ${APP_PATH})

  if [ -f ${APP_JSON} ]; then
    PYTHON_VERSION=$(cat ${APP_JSON} | ${JQ_BIN} -r '.environments.webfaction.python?')
  fi

  if [[ "${PYTHON_VERSION}" == "null" ]] || [[ "${PYTHON_VERSION}" == "" ]]; then
    PYTHON_VERSION=2.7
  fi

  section "Create virtual environment with Python ${PYTHON_VERSION} for \"${APP_NAME}\""
  PYTHONPATH=${VENV_PYTHONPATH} ${VENV_BIN} -p /usr/local/bin/python${PYTHON_VERSION} --prompt="(${APP_NAME})" ${ENV_PATH} || exit 1
fi

# Solution source: https://community.webfaction.com/questions/18791/why-can-my-virtualenv-still-see-system-site-packages/18792
touch ${APP_PATH}/env/lib/python2.7/sitecustomize.py
