# docr

Docr - 使用 Docker 封装的 OCR 服务。


## 安装

### 安装 Docker

访问 Docker 官网 https://www.docker.com/ 或从以下 URL 下载 Docker 并安装，也可以使用软件包管理器将 Docker 安装到您的系统上：

https://www.docker.com/community-edition

#### MacOS

https://store.docker.com/editions/community/docker-ce-desktop-mac

或者使用 [Homebrew](https://brew.sh) 安装:

```sh
$ brew cask install docker
```

#### Windows

https://store.docker.com/editions/community/docker-ce-desktop-windows

#### Ubuntu

https://store.docker.com/editions/community/docker-ce-server-ubuntu

或者使用官方脚本安装：

```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

其它安装方式参考[官方文档](https://docs.docker.com/install/linux/docker-ce/ubuntu/)。


### 安装 Docr

```sh
$ git clone https://github.com/zhanet/docr.git && cd docr
```

## 启动

### 使用启用脚本

```sh
$ ./start.sh
```


## 测试

### 测试 Docr 运行

```sh
./bin/test
```

### 使用 Docr 服务

将待识别的图片文件复制到 ocr/upload 目录即可：

```sh
$ cd ocr
$ cp phototest.tif upload/
```

### 查看 Docr 结果

Docr 使用 Postgres 数据库保存 OCR 结果。

#### 使用 psql 查看
```
$ docker exec -it docr-postgres psql -U postgres

postgres=# select * from docr;
```

#### 使用 pgAdmin 查看

Docr 内置了 pgAdmin4 。

打开浏览器，访问：http://localhost:5050 

填写 pgAdmin 4 Login 页面信息:
```
Email Address: postgres@pgadmin.org 
Password: postgres
```

创建数据库链接：Object -> Create -> Server...

General 标签页填写：
```
Name: docr-postgres
```
Connection 标签页填写：
```
Host name/address: docr-postgres
Port: 5432
Maintenance database: postgres
Username: postgres
Password: postgres
```

点击 Save 按钮登录数据库。通过左侧导航栏导航到数据库，右击数据库项目选择 Query Tool...，在打开的Query标签页面中输入SQL语句，按F5执行。


#### 其它工具

[DataGrip](https://www.jetbrains.com/datagrip/), [DBeaver](http://dbeaver.jkiss.org/), [PSequel](http://www.psequel.com/) ...


## 参考

### Docker Docs

https://docs.docker.com/

https://docs.docker-cn.com/


