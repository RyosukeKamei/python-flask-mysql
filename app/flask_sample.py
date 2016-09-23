# ライブラリをインポート
from flask import Flask, render_template, request, redirect, url_for

# MySQLドライバはmysql.connector
import mysql.connector
# Dockerを使う場合で、初期設定の場合hostは"192.168.99.100"
# MySQLのユーザやパスワード、データベースはdocker-compose.ymlで設定したもの
connector = mysql.connector.connect(
            user='python',
            password='python',
            host='192.168.99.100',
            database='sample')

cursor = connector.cursor()
cursor.execute("select * from users")

disp = ""
for row in cursor.fetchall():
    disp = "ID:" + str(row[0]) + "  名前:" + row[1]

cursor.close
connector.close

# Flaskはインスタンスを生成する
app = Flask(__name__)
app.config.update({'DEBUG': True })

# ここからウェブアプリケーション用のルーティングを記述
# index にアクセスしたときの処理
@app.route('/hello')
def hello():
    # return "Flask DBから取得 "+disp
    # Jinjaを使う
    title = "ようこそ"
    message = "DBから取得 "+disp
    # index.html をレンダリングする
    return render_template('index.html', message=message, title=title)
if __name__ == '__main__':
    app.run(host='0.0.0.0')
