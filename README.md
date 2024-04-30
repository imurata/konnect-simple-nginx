# konnect-simple-nginx
## これは何？
nginxを立ててKonnectにControlPlaneを作り、DataPlaneをContainerで立ててテストするまでをセットアップするツール。

## 内容物
```
.
├── 01_build_nginx.sh      nginxのインストール
├── 02_create_cp.sh        ControlPlaneの作成
├── 03_create_service.sh   Gateway Services, Routeの作成
├── 04_prepare_dp.sh        DataPlaneの作成準備
├── 05_run_dp.sh            DataPlaneのデプロイ（Docker Compose）
├── 99_random_access.sh    テスト
├── README.md
├── certs
├── docker-compose-dp.yaml
└── konnect-env.sh
```

## 前提
- nginxを起動するLinuxサーバがある
- 証明書を作成してcertsディレクトリ以下にtls.crt, tls.keyで格納済み

## 使い方
1. konnect-env.shにPersonal Access Tokenとnginxが起動するホストの情報を設定する。
2. 01から05まで順々に実行する

