考试系统
--------

## 安装说明
1. [git clone 项目](https://github.com/myloveGy/examination)
```
git clone git@github.com:myloveGy/examination.git
```

2. composer install 
```
php composer install
```

3. 将SQL文件导入数据库(文件位于目录下的/docs/examination.sql)

4. 配置虚拟目录(需要开启路由重写)，后台地址：域名/admin 

> 超级管理员： super 密码： admin123

> 普通管理员： admin 密码： admin123

### 预览
1. 首页
![首页](./docs/docs0.png)
2. 类型选择
![类型选择](./docs/docs1.png)
3. 顺序答题
![顺序答题](./docs/docs2.png)
4. 模拟考试
![模拟考试](./docs/docs3.png)
5. 后台管理
![后台管理](./docs/docs4.png)