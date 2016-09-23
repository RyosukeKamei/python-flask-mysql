# Pythonは公式イメージ
FROM python:3.5.2

# オリジナルはJoshua Conner氏
# MAINTAINER Joshua Conner <joshua.conner@gmail.com>
MAINTAINER Ryosuke Kamei <sr2smail@gmail.com>

# 各ライブラリインストール
# Pythonがパッケージ依存するものもインストール
# Pythonプロフェッショナルプログラミング第2版P9より
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y 	vim \
						sudo \
						python3-dev \
						zlib1g-dev \
						libsqlite3-dev \
						libreadline6-dev \
						libgdbm-dev \
						libbz2-dev \
						tk-dev
	
# ユーザ作成
RUN groupadd web
RUN useradd -d /home/python -m python

# pipでインストール
# virtualenv Pythonの仮想環境構築コマンド
# flake8 コーディングスタイル/シンタックスのチェック
# ipython Pythonのインタラクティブモード拡張
# Flask Pytrhonの軽量フレームワーク
RUN pip install virtualenv \
				ipython \
				flake8 \
                Flask

# MySQLドライバ"mysql-connector-python"をインストール
# pipのを使うとうまくいかない。
# git cloneしてビルド、インストール
RUN git clone https://github.com/mysql/mysql-connector-python.git
WORKDIR mysql-connector-python
RUN python ./setup.py build
RUN python ./setup.py install

# ユーザを変更
USER python

# vim の設定ファイル
ADD ./vim/.vimrc /home/python/
WORKDIR /home/python
RUN mkdir /home/python/.vim
RUN mkdir /home/python/.vim/ftplugin
ADD ./vim/python.vim /home/python/.vim/ftplugin/
RUN mkdir /home/python/.vim/bundle
RUN git clone https://github.com/Shougo/neobundle.vim /home/python/.vim/bundle/neobundle.vim

# bottleの場合
# ポートを解放（bottleのデフォルトのポート番号:8080）
# EXPOSE 8080
# サーバ起動
# ENTRYPOINT ["/usr/local/bin/python", "/home/python/bottle_sample.py"]

# Flaskの場合
# ポートを解放（Flaskのデフォルトのポート番号:5000）
EXPOSE 5000
# サーバ起動
ENTRYPOINT ["/usr/local/bin/python", "/home/python/flask_sample.py"]

# フレームワークを指定しない時や、サーバにログインしてから実行したい場合
# ENTRYPOINT ["/usr/bin/tail", "-f", "/dev/null"]