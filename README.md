# 简要部署流程

1.创建相应的数据库，并默认utf8字符集。<br>
&nbsp;&nbsp;例： CREATE DATABASE `demo_production` DEFAULT CHARACTER SET utf8 

2.运行db:migration, db:seed

3.将下列两个example的配置文件修改好即可:

* config/database.rb.example

* config/cache_store.rb.example

