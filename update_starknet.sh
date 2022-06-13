#!/bin/bash

echo "=================================================="
echo -e "\033[0;35m"
echo " ::::    :::  ::     ::  :::::::::   ::::::::   ";
echo " :+:+:   :+: :+:    :+:     :+:     :+:    :+:  ";
echo " :+:+:+  +:+ +:+    +:+     +:+     +:+         ";
echo " +#+ +:+ +#+ +#+    +:+     +:+     +#++:++#++  ";
echo " +#+  +#+#+# +#+    +#+     +#+             +#+ ";
echo " #+#   #+#+# #+#    #+#     #+#     #+#     #+# ";
echo " ###    ####  ########      ###      ########   ";
echo -e "\e[0m"
echo "=================================================="

sleep 2


function line {
  echo "----13.06.2022--------------------------------------------------------------------"
}

function colors {
  GREEN="\e[1m\e[32m"
  RED="\e[1m\e[39m"
  NORMAL="\e[0m"
}


function update_stark {
cd ~/pathfinder
git fetch
git checkout v0.2.2-alpha
cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
cd py
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
  }

function restart {
  systemctl restart starknetd
  pathfinder -V
}


colors

line
echo -e "${RED}1/2Начинаем обновление StarkNet ${NORMAL}"
line
update_stark
line
echo -e "${GREEN}2/2 Перезагрузка ${NORMAL}"
line
restart
line
echo -e "${RED}Обновление завершено. Посмотри логи journalctl -u starknetd -f ${NORMAL}"
