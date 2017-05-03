#!/usr/bin/env bash

source ${UTILS_PATH}/log_messages.sh

APACHE_CONF=${APP_PATH}/apache2/conf/httpd.conf
# Change old Python path or old Python home to this env
sed -ire 's|python-path.*|python-home='${APP_PATH}'/env|' ${APACHE_CONF}
sed -ire 's|python-home.*|python-home='${APP_PATH}'/env|' ${APACHE_CONF}

section "Restart Apache server"
${APP_PATH}/apache2/bin/restart
[ $? -eq 0 ] && exit 0 || exit 1