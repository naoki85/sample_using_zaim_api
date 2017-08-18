# Sample using Zaim API

ZaimのAPIを利用したサンプルです。  
実際のサンプルはこちらです。  
[https://sample-using-zaim-api.herokuapp.com/top](https://sample-using-zaim-api.herokuapp.com/top)  

## Specification

### 節約できたら自慢ツイート

* 目標の金額を設定し、定めた期間でそれ以下の支払いであればツイートします。

* ログインはTwitterのOAuth認証でのみ行います。これは、Twitterアカウントが必ず必要になるためです。

* 目標値とツイート文言をあらかじめ設定しておきます。定期バッチにより判定を行い、Twitterにツイートします。

* Twitterボットとなるため、各種APIキーを登録していただく必要があります。

## Versions and Environment

* Ruby: 2.4.1

* Ruby on Rails: 5.1.3

* Development Database: SQLite3

* Production Database: PostgreSQL 

* Testing Framework: RSpec

* For HTML and CSS: Slim and Scss

* CSS Framework: Bootstrap3

## Usage

* Ruby、およびRails環境をご用意ください。

* クローンしたら、各種Gemをインストールします。

```sh
$ bundle install --without production
```
* 環境変数には`dotenv`を使用しています。そのため、プロジェクトディレクトリに、`.env`ファイルを作成してください。

```
ZAIM_CONSUMER_KEY = 'ZaimのConsumer key'
ZAIM_CONSUMER_SECRET = 'ZaimのConsumer secret'
ZAIM_CALLBACK_URL = 'コールバックURL'
TWITTER_CONSUMER_KEY = 'TwitterのConsumer key'
TWITTER_CONSUMER_SECRET = 'TwitterのConsumer secret'
ENCRYPT_SECURE_KEY = '暗号化のkey'
```
* サーバーを起動し、状態を確認してください。

```sh
$ ./bin/rails server
```

* バッチを確認する場合は、`runner`コマンドを使用します。
このとき、ユーザー情報やツイート情報などは設定しておいてください。
また、条件をクリアしていない場合はツイートされません。

```sh
# 引数でdaily、monthly, yearlyで渡します。
$ ./bin/rails runner "Tasks::RunnerTweetAchievingGoal.execute('daily')"
```
バッチファイル自体は、`lib/tasks`以下にあります。

## Sample
Heroku環境にてサンプルを確認することができます。  
[https://sample-using-zaim-api.herokuapp.com/top](https://sample-using-zaim-api.herokuapp.com/top)  
  
※ バッチの定期実行処理は設定されておりません。
