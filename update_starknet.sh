#!/bin/bash

function logo {
  curl -s https://raw.githubusercontent.com/95brsu/tools/main/nuts.sh | bash
}

function line {
  echo "----12.05.2022--------------------------------------------------------------------"
}

function colors {
  GREEN="\e[1m\e[32m"
  RED="\e[1m\e[39m"
  NORMAL="\e[0m"
}


function install_stark {
  cd ~/pathfinder
  git fetch
  git checkout v0.1.11-alpha
  cargo build --release --bin pathfinder
  mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
  cd py
  source .venv/bin/activate
  PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
  }



function build_pd {
cd $HOME/penumbra/
sudo apt-get install clang
cargo build --release --bin pd
cargo run --quiet --release --bin pcli balance
}


function restart {
  systemctl restart starknetd
  pathfinder -V
}

function rust_update {
  rustup update
  rustup default nightly
}

function tendermint {
  tendermint init full 
  curl -s http://testnet.penumbra.zone:26657/genesis | jq ".result.genesis" > $HOME/.tendermint/config/genesis.json
}




colors

line
logo
line
echo -e "${RED}Начинаем обновление StarkNet ${NORMAL}"
line
install_stark
line
echo -e "${GREEN}2/2 Перезагрузка ${NORMAL}"
line
restart
line
echo -e "${RED}Обновление завершено. Посмотри логи journalctl -u starknetd -f ${NORMAL}"
